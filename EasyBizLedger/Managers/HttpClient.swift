//
//  HttpClient.swift
//  EasyBizLedger
//
//  Created by Peiyun on 2024/2/1.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}
