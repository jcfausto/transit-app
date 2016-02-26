//
//  ErrorHelper.swift
//  TransitApp
//
//  Created by Julio Cesar Fausto on 24/02/16.
//  Copyright © 2016 Julio Cesar Fausto. All rights reserved.
//

import Foundation

enum TransitAppError: ErrorType {
    case JSONDecodingError(errorMessage:String)
}
