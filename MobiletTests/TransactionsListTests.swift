//
//  TransactionsLListTests.swift
//  Mobilet
//
//  Created by Benyamin Mokhtarpour on 9/19/23.
//

import XCTest
@testable import Mobilet

class TransactionsListViewModelTests: XCTestCase {
    var viewModel: TransactionsListViewModel!
    var mockTransactionsUseCase: MockTransactionUseCase!
    var mockDelegate: MockTransactionsListViewModelDelegate!

    override func setUp() {
        super.setUp()
        mockTransactionsUseCase = MockTransactionUseCase()
        viewModel = TransactionsListViewModel(transactionsUseCase: mockTransactionsUseCase)
        mockDelegate = MockTransactionsListViewModelDelegate()
        viewModel.delegate = mockDelegate
    }

    override func tearDown() {
        viewModel = nil
        mockTransactionsUseCase = nil
        mockDelegate = nil
        super.tearDown()
    }

    func testFetchTransactions_Success() {
        let mockTransactions = [Entities.Responses.Transaction(id: "1", date: "2023-09-19", amount: "100.00", userDescription: nil, status: "SUCCESS", isWithdraw: false, bank: nil, person: nil, _isExpanded: nil)]
        mockTransactionsUseCase.mockFetchTransactionsResult = .success(mockTransactions)

        viewModel.fetchTransactions()

        XCTAssertEqual(viewModel.datasource, mockTransactions.sorted(by: { $0.date < $1.date }))
        XCTAssertTrue(mockDelegate.transactionsDidUpdateCalled)
    }

    func testFetchTransactions_Failure() {
        // Arrange
        let error = NSError(domain: "TestErrorDomain", code: 42, userInfo: nil)
        mockTransactionsUseCase.mockFetchTransactionsResult = .failure(error)

        // Act
        viewModel.fetchTransactions()

        // Assert
        XCTAssertEqual(viewModel.datasource.count, 0)
        XCTAssertTrue(mockDelegate.transactionsFetchFailedCalled)
        XCTAssertEqual(mockDelegate.transactionsFetchFailedError, error)
    }

    func testFetchTransactionDetails_Success() {
        // Arrange
        let transactionId = "1"
        let mockTransaction = Entities.Responses.Transaction(id: transactionId, date: "2023-09-19", amount: "100.00", userDescription: nil, status: "SUCCESS", isWithdraw: false, bank: nil, person: nil, _isExpanded: nil)
        mockTransactionsUseCase.mockFetchTransactionDetailResult = .success(mockTransaction)

        // Act
        viewModel.fetchTransactionDetails(id: transactionId)

        // Assert
        XCTAssertEqual(viewModel.transaction, mockTransaction)
        XCTAssertTrue(mockDelegate.transactionsDidUpdateCalled)
    }

    func testFetchTransactionDetails_Failure() {
        // Arrange
        let transactionId = "1"
        let error = NSError(domain: "TestErrorDomain", code: 42, userInfo: nil)
        mockTransactionsUseCase.mockFetchTransactionDetailResult = .failure(error)

        // Act
        viewModel.fetchTransactionDetails(id: transactionId)

        // Assert
        XCTAssertNil(viewModel.transaction)
        XCTAssertTrue(mockDelegate.transactionsFetchFailedCalled)
        XCTAssertEqual(mockDelegate.transactionsFetchFailedError, error)
    }
}

// MockTransactionUseCase is a mock implementation of TransactionUseCaseProtocol for testing purposes.
class MockTransactionUseCase: TransactionUseCaseProtocol {
    var mockFetchTransactionsResult: Result<[Entities.Responses.Transaction], Error> = .success([])
    var mockFetchTransactionDetailResult: Result<Entities.Responses.Transaction, Error> = .success(Entities.Responses.Transaction(id: "1", date: "2023-09-19", amount: "100.00", userDescription: nil, status: "SUCCESS", isWithdraw: false, bank: nil, person: nil, _isExpanded: nil))

    func fetchTransactions(completion: @escaping (Result<[Entities.Responses.Transaction], Error>) -> Void) {
        completion(mockFetchTransactionsResult)
    }

    func fetchTransactionDetail(for id: String, completion: @escaping (Result<Entities.Responses.Transaction, Error>) -> Void) {
        completion(mockFetchTransactionDetailResult)
    }
}

// MockTransactionsListViewModelDelegate is a mock implementation of TransactionsListViewModelDelegate for testing purposes.
class MockTransactionsListViewModelDelegate: TransactionsListViewModelDelegate {
    var transactionsDidUpdateCalled = false
    var transactionsFetchFailedCalled = false
    var transactionsFetchFailedError: Error?

    func transactionsDidUpdate() {
        transactionsDidUpdateCalled = true
    }

    func transactionsFetchFailed(with error: Error) {
        transactionsFetchFailedCalled = true
        transactionsFetchFailedError = error
    }
}

