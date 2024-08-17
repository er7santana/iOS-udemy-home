//
//  HomeCollectionView.swift
//  ios-udemy-home
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 17/08/24.
//

import Combine
import UIKit

final class HomeCollectionView: UICollectionView {
    
    enum Event {
        case itemTapped(HomeUIModel.Item)
    }
    
    private var diffableDataSource: UICollectionViewDiffableDataSource<HomeUIModel.Section, HomeUIModel.Item>!
    private var uiModel: HomeUIModel?
    
    private let eventSubject = PassthroughSubject<Event, Never>()
    var eventPublisher: AnyPublisher<Event, Never> {
        return eventSubject.eraseToAnyPublisher()
    }
    
    init() {
        super.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionViewLayout = makeCompositionalLayout()
        setup()
        setupDataSource()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    func setDataSource(uiModel: HomeUIModel) {
        self.uiModel = uiModel
        self.applySnapshot()
    }
    
    func setup() {        
        register(MainBannerCollectionViewCell.self, forCellWithReuseIdentifier: MainBannerCollectionViewCell.namedIdentifier)
        register(TextHeaderCollectionViewCell.self, forCellWithReuseIdentifier: TextHeaderCollectionViewCell.namedIdentifier)
        register(CourseCollectionViewCell.self, forCellWithReuseIdentifier: CourseCollectionViewCell.namedIdentifier)
        register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: CategoriesCollectionViewCell.namedIdentifier)
        register(FeatureCourseCollectionViewCell.self, forCellWithReuseIdentifier: FeatureCourseCollectionViewCell.namedIdentifier)
        register(UdemyBusinessCollectionViewCell.self, forCellWithReuseIdentifier: UdemyBusinessCollectionViewCell.namedIdentifier)
    }
    
    func setupDataSource() {
        diffableDataSource = UICollectionViewDiffableDataSource(collectionView: self,
                                                                cellProvider: { collectionView, indexPath, item in
            switch item {
            case let .mainBanner(_, imageLink, title, caption):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainBannerCollectionViewCell.namedIdentifier, for: indexPath) as! MainBannerCollectionViewCell
                cell.configure(imageLink: imageLink, title: title, caption: caption)
                return cell
            case let .textHeader(id, text, highlightedText):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TextHeaderCollectionViewCell.namedIdentifier, for: indexPath) as! TextHeaderCollectionViewCell
                cell.configure(text: text, highlightedText: highlightedText)
                cell.onTap = { [weak self] in
                    self?.eventSubject.send(.itemTapped(item))
                }
                return cell
            case let .course(id, imageLink, title, author, rating, reviewCount, price, tag):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CourseCollectionViewCell.namedIdentifier, for: indexPath) as! CourseCollectionViewCell
                cell.configure(imageLink: imageLink, title: title, author: author, rating: rating, reviewCount: reviewCount, price: price, tag: tag)
                cell.onTap = { [weak self] in
                    self?.eventSubject.send(.itemTapped(item))
                }
                return cell
            case let .categoriesScroller(id, titles):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.namedIdentifier, for: indexPath) as! CategoriesCollectionViewCell
                cell.configure(titles: titles)
                cell.onTap = { [weak self] title in
                    let selected = HomeUIModel.Item.categoriesScroller(id: id, titles: [title])
                    self?.eventSubject.send(.itemTapped(selected))
                }
                return cell
            case let .featureCourse(id, imageLink, title, author, rating, reviewCount, price):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeatureCourseCollectionViewCell.namedIdentifier, for: indexPath) as! FeatureCourseCollectionViewCell
                cell.configure(imageLink: imageLink, title: title, author: author, rating: rating, reviewCount: reviewCount, price: price)
                cell.onTap = { [weak self] in
                    self?.eventSubject.send(.itemTapped(item))
                }
                return cell
            case let .udemyBusinessBanner(_, link):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UdemyBusinessCollectionViewCell.namedIdentifier, for: indexPath) as! UdemyBusinessCollectionViewCell
                cell.onTap = { [weak self] in
                    self?.eventSubject.send(.itemTapped(item))
                }
                return cell
            }
        })
    }
    
    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<HomeUIModel.Section, HomeUIModel.Item>()
        uiModel?.sectionModels.forEach({ sectionModel in
            snapshot.appendSections([sectionModel.section])
            snapshot.appendItems(sectionModel.body, toSection: sectionModel.section)
        })
        diffableDataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func makeCompositionalLayout() -> UICollectionViewCompositionalLayout {
        
        let provider: UICollectionViewCompositionalLayoutSectionProvider = { [weak self] index, environment in
            guard let sectionModel = self?.uiModel?.sectionModels[index] else { return nil }
            
            switch sectionModel.section {
            case .mainBanner:
                return self?.makeMainBannerSection()
            case .textHeader:
                guard case let .textHeader(_, text, highlightedText) = sectionModel.body.first else { return nil }
                return self?.makeTextHeaderSection(text: text, highlightedText: highlightedText)
            case .courseSwimLane:
                return self?.makeCourseSwimLaneSection()
            case .categories:
                return self?.makeCategoriesSection()
            case .featureCourse:
                return self?.makeFeaturedCourseSection()
            case .udemyBusinessBanner:
                return self?.makeUdemyBusinessSection()
            }
        }
        
        return UICollectionViewCompositionalLayout(sectionProvider: provider)
    }
    
    func makeMainBannerSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(220))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0)
        return section
    }
    
    func makeTextHeaderSection(text: String, highlightedText: String?) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let height = AttributedTappableLabel.heightForWidth(frame.size.width, text: text)
        
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(height))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 8, trailing: 20)
        return section
    }
    
    func makeCourseSwimLaneSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let layoutSize = NSCollectionLayoutSize(widthDimension: .absolute(160), heightDimension: .absolute(220))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20)
        return section
    }
    
    func makeCategoriesSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(88))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20)
        return section
    }
    
    func makeFeaturedCourseSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(230))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutSize, subitems: [item])
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20)
        return section
    }
    
    func makeUdemyBusinessSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(160))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutSize, subitems: [item])
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20)
        return section
    }
}
