//
//  FeedViewControllerTests.swift
//  EssentialFeed
//
//  Created by Vanya Mutafchieva on 19/02/2025.
//

import XCTest
import UIKit
import EssentialFeed

final public class FeedViewController: UITableViewController {
    private var loader: FeedLoader?
    private var onViewIsAppearing: ((FeedViewController) -> Void)?
    
    public convenience init(loader: FeedLoader) {
        self.init()
        self.loader = loader
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(load), for: .valueChanged)
        
        onViewIsAppearing = { vc in
            
            //vc.refreshControl?.addTarget(vc, action: #selector(vc.refresh), for: .valueChanged)
            vc.onViewIsAppearing = nil
            vc.refresh()
        }
        load()
    }
    
    public override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        
        onViewIsAppearing?(self)
    }
    
    @objc func load() {
        loader?.load { [weak self] _ in
            self?.refreshControl?.endRefreshing()
        }
    }
    
    @objc private func refresh() {
        refreshControl?.beginRefreshing()
    }
}

//final class FeedViewController1: UITableViewController {
//    private var loader: FeedLoader?
//    private var onViewIsAppearing: ((FeedViewController) -> Void)?
//    
//    convenience init(loader: FeedLoader) {
//        self.init()
//        self.loader = loader
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        refreshControl = UIRefreshControl()
//        refreshControl?.addTarget(self, action: #selector(load), for: .valueChanged)
//
//        //refreshControl?.beginRefreshing() // works on iOS16, doesn't work on iOS17
//        
//        onViewIsAppearing = { vc in  // iOS17 workaround
//            
//            vc.refresh()
//            vc.refreshControl?.addTarget(vc, action: #selector(vc.refresh), for: .valueChanged)
//            vc.onViewIsAppearing = nil
//        }
//        
//        load()
//    }
//    
//    override func viewIsAppearing(_ animated: Bool) {
//        super.viewIsAppearing(animated)
//        
//        onViewIsAppearing?(self)
//    }
//    
//    @objc private func load() {
//        loader?.load { [weak self] _ in
//            self?.refreshControl?.endRefreshing()
//        }
//    }
//    
//    @objc private func refresh() {
//        refreshControl?.beginRefreshing()
//         print("refresh")
//        // refresh data
//    }
//}

final class FeedViewControllerTests: XCTestCase {

	func test_init_doesNotLoadFeed() {
        let (_, loader) = makeSUT()

		XCTAssertEqual(loader.loadCallCount, 0)
	}
    
    func test_viewDidLoad_loadsFeed() {
        let (sut, loader) = makeSUT()
        
        sut.simulateAppearance() // sut.loadViewIfNeeded() //iOS16
        
        XCTAssertEqual(loader.loadCallCount, 1)
    }
    
    func test_userInitiatedFeedReload_reloadsFeed() {
        let (sut, loader) = makeSUT()
        sut.simulateAppearance() // sut.loadViewIfNeeded() //iOS16
    
        sut.simulateUserInitiatedFeedReload()
        XCTAssertEqual(loader.loadCallCount, 2)
        
        sut.simulateUserInitiatedFeedReload()
        XCTAssertEqual(loader.loadCallCount, 3)
    }
    
    func test_viewDidLoad_showsLoadingIndicator() {
        let (sut, _) = makeSUT()
        
        sut.simulateAppearance() // sut.loadViewIfNeeded() // iOS16
        
        XCTAssertEqual(sut.refreshControl?.isRefreshing, true)
    }
    
    func test_viewDidLoad_hidesLoadingIndicatorOnLoaderCompletion() {
        let (sut, loader) = makeSUT()
        
        sut.simulateAppearance()
        loader.completeFeedLoading()
        
        XCTAssertEqual(sut.refreshControl?.isRefreshing, false)
    }
    
    func test_userInitiatedFeedReload_showsLoadingIndicator() {
        let (sut, _) = makeSUT()
        
        sut.simulateAppearance()
        sut.simulateUserInitiatedFeedReload() // X
        
        XCTAssertEqual(sut.refreshControl?.isRefreshing, true)
    }
    
    func test_userInitiatedFeedReload_hidesLoadingIndicatorOnLoaderCompletion() {
        let (sut, loader) = makeSUT()
        
        sut.simulateUserInitiatedFeedReload()
        loader.completeFeedLoading()
        
        XCTAssertEqual(sut.refreshControl?.isRefreshing, false)
    }
    
//    func test_refreshControl() {
//        let (sut, _) = makeSUT()
//        
//        sut.loadViewIfNeeded()  // since we already covered viewDidLoad in simulateAppearance() we can remove these 3 lines
//        sut.replaceRefreshControlWithFakeForiOS17Support()
//        XCTAssertEqual(sut.refreshControl?.isRefreshing, false)
//        
//        sut.simulateAppearance()
//        XCTAssertEqual(sut.refreshControl?.isRefreshing, true)
//        
//        sut.refreshControl?.endRefreshing()
//        sut.refreshControl?.simulatePullToRefresh()
//        //sut.refreshControl?.sendActions(for: .valueChanged) // sendActions doesn't work in framework targets
//        XCTAssertEqual(sut.refreshControl?.isRefreshing, true)
//        
//        sut.refreshControl?.endRefreshing()
//        sut.simulateAppearance()
//        XCTAssertEqual(sut.refreshControl?.isRefreshing, false)
//    }


	// MARK: - Helpers
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: FeedViewController, loader: LoaderSpy) {
        let loader = LoaderSpy()
        let sut = FeedViewController(loader: loader)
        trackForMemoryLeaks(loader, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut, loader)
    }
    
    class LoaderSpy: FeedLoader {
        private var completions = [(FeedLoader.Result) -> Void]()
        
        var loadCallCount: Int {
            return completions.count
        }
        
        func load(completion: @escaping (FeedLoader.Result) -> Void) {
            completions.append(completion)
        }
        
        func completeFeedLoading() {
            completions[0](.success([]))
        }
	}
}

private extension FeedViewController {
    func simulateUserInitiatedFeedReload() {
        refreshControl?.simulatePullToRefresh()
    }
}

private extension UIRefreshControl {
    func simulatePullToRefresh() {
        allTargets.forEach { target in
            actions(forTarget: target, forControlEvent: .valueChanged)?.forEach {
                (target as NSObject).perform(Selector($0))
            }
        }
    }
}

private class FakeRefreshControl: UIRefreshControl {
    private var _isRefreshing = false
    
    override var isRefreshing: Bool { _isRefreshing }
    
    override func beginRefreshing() {
        _isRefreshing = true
    }
    
    override func endRefreshing() {
        _isRefreshing = false
    }
}

private extension FeedViewController {
    func simulateAppearance() {
        if !isViewLoaded {
            loadViewIfNeeded()
            replaceRefreshControlWithFakeForiOS17Support()
        }
        
        beginAppearanceTransition(true, animated: false)
        endAppearanceTransition()
    }
    
    func replaceRefreshControlWithFakeForiOS17Support() {
        let fake = FakeRefreshControl()
        
        refreshControl?.allTargets.forEach { target in
            refreshControl?.actions(forTarget: target, forControlEvent: .valueChanged)?.forEach { action in
                fake.addTarget(target, action: Selector(action), for: .valueChanged)
            }
        }
        
        refreshControl = fake
    }
}
