//
//  MNError.swift
//  Movie Night
//
//  Created by Tom Bastable on 07/11/2019.
//  Copyright © 2019 Tom Bastable. All rights reserved.
//

import Foundation

enum MovieError: Error {
    
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure(message: String)
    case downcastError
    case resultsRetrievalError
    
}
