//
//  ContentViewModel.swift
//  ClosureSample
//
//  Created by Peter Kurzok on 13.01.22.
//

import Foundation

class ContentViewModel: ObservableObject {
    @Published var showDetail: Bool = false

    deinit {
        print("Deiniting ViewModel")
    }
}

class ContentDetailViewModel: ObservableObject {
    private let service: Service

    @Published var message = "Hello, world!"

    lazy var work: () -> Void = {
//        [weak self] in
//        guard let self = self else { print("self is gone"); return }
        self.message = "\(self.message) Work is done!"
    }

    init(service: Service = Service()) {
        self.service = service
    }

    deinit {
        print("Deiniting Detail ViewModel")
    }

    func onDoSomeWork() {
        service.doSomeAsyncWork(completion: work)

//        service.doSomeAsyncWork {
//            [weak self] in
//            guard let self = self else { print("self is gone"); return }
//                self.message = "\(self.message) Work is done!"
//        }
    }
}

class Service {
    deinit {
        print("Deiniting Service")
    }

    func doSomeAsyncWork(completion: @escaping () -> Void) {
        DispatchQueue.global().async {
            print("Working Async")
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {
                completion()
            }
        }
    }
}
