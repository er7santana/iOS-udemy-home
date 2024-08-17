//
//  HomeCollectionView.swift
//  ios-udemy-home
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 17/08/24.
//

import UIKit

final class HomeCollectionView: UICollectionView {
    
    private var diffableDataSource: UICollectionViewDiffableDataSource<HomeUIModel.Section, HomeUIModel.Item>!
    private var uiModel: HomeUIModel?
    
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
            case let .textHeader(_, text, highlightedText):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TextHeaderCollectionViewCell.namedIdentifier, for: indexPath) as! TextHeaderCollectionViewCell
                cell.configure(text: text, highlightedText: highlightedText)
                return cell
            case let .course(_, imageLink, title, author, rating, reviewCount, price, tag):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CourseCollectionViewCell.namedIdentifier, for: indexPath) as! CourseCollectionViewCell
                cell.configure(imageLink: imageLink, title: title, author: author, rating: rating, reviewCount: reviewCount, price: price, tag: tag)
                return cell
            case let .categoriesScroller(_, titles):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.namedIdentifier, for: indexPath) as! CategoriesCollectionViewCell
                cell.configure(titles: titles)
                return cell
            case let .featureCourse(_, imageLink, title, author, rating, reviewCount, price):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeatureCourseCollectionViewCell.namedIdentifier, for: indexPath) as! FeatureCourseCollectionViewCell
                cell.configure(imageLink: imageLink, title: title, author: author, rating: rating, reviewCount: reviewCount, price: price)
                return cell
            case let .udemyBusinessBanner(_, link):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UdemyBusinessCollectionViewCell.namedIdentifier, for: indexPath) as! UdemyBusinessCollectionViewCell
                cell.onTap = {
                    print(">>>>>>>>> Tapped on udemy Business \(link)")
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
            default:
                fatalError()
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
