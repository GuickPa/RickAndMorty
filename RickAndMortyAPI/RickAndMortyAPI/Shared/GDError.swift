//
//  GDError.swift
//  RickAndMortyAPI
//
//  Created by Guglielmo Deletis on 19/04/22.
//

import Foundation

enum GDError: Error {
    case instanceError
    case methodNotAllowed
    case badFormat
    case aborted
}

extension GDError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .instanceError:
            return NSLocalizedString("gd_error_instance", comment: "")
        case .methodNotAllowed:
            return NSLocalizedString("gd_error_unallowed_method", comment: "")
        case .badFormat:
            return NSLocalizedString("gd_error_bad_format", comment: "")
        case .aborted:
            return NSLocalizedString("gd_error_aborted", comment: "")
        }
    }
}
