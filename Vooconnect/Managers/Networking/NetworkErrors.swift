//
//  NetworkErrors.swift
//  LiveCheff
//
//  Created by Online Developer on 02/09/2022.
//

import Foundation

/// Error model to send complete error information
struct RequestError: Error {
    let code: Int
    let message: String
}

struct RequestErrorModel: Codable {
    let status: Int
    let message: String
}


enum NetworkError: Error {
    case invalidURL
    case responseError
    case unknown
    case serverError
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "Invalid URL")
        case .responseError:
            return NSLocalizedString("Unexpected status code", comment: "Invalid response")
        case .unknown:
            return NSLocalizedString("Something went wrong", comment: "Unknown error")
        case .serverError:
            return NSLocalizedString("Unknown error", comment: "Unknown error")
        }
    }
}


/// The various error codes that we will reference throughout all of the network endpoint calls we will make to handle errors correctly
class NetworkErrorCodes {
    
    static let ResponseError = 1
    static let ValidationError = 99999

    enum JwtAuth {
        static let TokenExpired = 10001
        static let Unauthorized = 10002
    }

    enum Auth {
        static let wrongInvitationCode = 60301
        static let EmailAlreadyExists = 11001
        static let EmailCannotBeVerified = 11002
        static let EmailNotValid = 11003
        static let LinkExpired = 11004
        static let InvalidToken = 11005
        static let VerificationLinkExpired = 11006
    }

    enum Skillr {
        static let NoSuchUser = 21001
        static let AlreadyCreated = 21002
        static let NoSuchSkillr = 21003
        static let SkillrAppAlreadySubmitted = 21004
        static let UsernameAlreadyTaken = 21005
        static let UsernameInvalidError = 80085
    }

    enum SkillrMedia {
        static let NoSuchSkill = 22001
        static let SkillAppAlreadySubmitted = 22002
        static let CheckInput = 22003
        static let MimeTypeNotSupported = 22004
        static let NoSuchSkillrMedia = 22005
    }

    enum SkillrSkill {
        static let NoMoreThan5Skills = 23001
        static let NoSameSkillTwice = 23002
        static let NotValidSkillId = 23003
        static let RateAboveMax = 23004
    }

    enum User {
        static let WrongOldPassword = 20001
        static let BadCredentials = 20002
        static let DeletedUser = 20003
        static let DeactivatedUser = 20004
        static let PasswordResetHashExpired = 20005
        static let EmailNotVerified = 20006
        static let rateLimit = 20007
    }

    enum Booking {
        static let NoSuchBook = 24001
        static let CannotBookOutOfAvailability = 24002
        static let BookOverlap = 24003
        static let NotInBook = 24004
        static let Earlier5minStartDate = 24005
        static let NoToken = 24006
        static let NotFound = 24007
        static let BookRateAfterCall = 24008
        static let NotAcceptedBook = 24010
        static let SlowerReaction = 24011
    }

    enum Payment {
        static let PaymentFailed = 80001
        static let NoPaymentMethod = 80002
        static let StripeAccountOnBoardingAlreadyDone = 80003
        static let StripeAccountOnBoardingNotDone = 80004
        static let StripeAccountNotExist = 80005
    }

    enum Vonage {
        static let VonageApiError = 90001
    }
    
    enum Video {
        static let noSuchVideo = 24101
    }
}

/// Handle network errors by code by passing the whole error through the method
/// - Parameters: error - The error in which the code will be extracted and handled from
/// - Returns: String - An explanation of the error that will most likely go into a message or a logging
//public func networkErrorMessage(fromTheCodeIn error: Error, orWithRequestErrorCode requestErrorCode: Int = 0) -> String {
//        
//    let errorCode: Int!
//    
//    if requestErrorCode == 0 {
//        errorCode = (error as NSError).code
//    } else {
//        errorCode = requestErrorCode
//    }
//
//    
//    switch errorCode {
//        
//        // VALIDAITON
//    case NetworkErrorCodes.ValidationError:
//        return Localizer.get("NetworkError.0")
//    case NetworkErrorCodes.ResponseError:
//        return Localizer.get("NetworkError.99999")
//        
//        // AUTH
//    case NetworkErrorCodes.Auth.wrongInvitationCode:
//        return Localizer.get("NetworkError.60301")
//    case NetworkErrorCodes.Auth.EmailAlreadyExists:
//        return Localizer.get("NetworkError.11001")
//    case NetworkErrorCodes.Auth.EmailCannotBeVerified:
//        return Localizer.get("NetworkError.11002")
//    case NetworkErrorCodes.Auth.EmailNotValid:
//        return Localizer.get("NetworkError.11003")
//    case NetworkErrorCodes.Auth.InvalidToken:
//        return Localizer.get("NetworkError.11004")
//    case NetworkErrorCodes.Auth.LinkExpired:
//        return Localizer.get("NetworkError.11005")
//    case NetworkErrorCodes.Auth.VerificationLinkExpired:
//        return Localizer.get("NetworkError.11006")
//        
//        // SKILLR
//    case NetworkErrorCodes.Skillr.NoSuchUser:
//        return Localizer.get("NetworkError.21001")
//    case NetworkErrorCodes.Skillr.AlreadyCreated:
//        return Localizer.get("NetworkError.21002")
//    case NetworkErrorCodes.Skillr.NoSuchSkillr:
//        return Localizer.get("NetworkError.21003")
//    case NetworkErrorCodes.Skillr.SkillrAppAlreadySubmitted:
//        return Localizer.get("NetworkError.21004")
//    case NetworkErrorCodes.Skillr.UsernameAlreadyTaken:
//        return Localizer.get("NetworkError.21005")
//    case NetworkErrorCodes.Skillr.UsernameInvalidError:
//        return Localizer.get("NetworkError.80085")
//        
//        // SKILLR MEDIA
//    case NetworkErrorCodes.SkillrMedia.NoSuchSkill,
//        NetworkErrorCodes.SkillrMedia.SkillAppAlreadySubmitted,
//        NetworkErrorCodes.SkillrMedia.CheckInput,
//        NetworkErrorCodes.SkillrMedia.MimeTypeNotSupported,
//        NetworkErrorCodes.SkillrMedia.NoSuchSkillrMedia:
//        return Localizer.get("NetworkError.0")
//        
//        // SKILLR SKILL
//    case NetworkErrorCodes.SkillrSkill.NoMoreThan5Skills,
//        NetworkErrorCodes.SkillrSkill.NoSameSkillTwice,
//        NetworkErrorCodes.SkillrSkill.NotValidSkillId,
//        NetworkErrorCodes.SkillrSkill.RateAboveMax:
//        return Localizer.get("NetworkError.0")
//        
//        // USER
//    case NetworkErrorCodes.User.WrongOldPassword:
//        return Localizer.get("NetworkError.20001")
//    case NetworkErrorCodes.User.BadCredentials:
//        return Localizer.get("NetworkError.20002")
//    case NetworkErrorCodes.User.DeletedUser:
//        return Localizer.get("NetworkError.20003")
//    case NetworkErrorCodes.User.DeactivatedUser:
//        return Localizer.get("NetworkError.20004")
//    case NetworkErrorCodes.User.PasswordResetHashExpired:
//        return Localizer.get("NetworkError.20005")
//    case NetworkErrorCodes.User.EmailNotVerified:
//        return Localizer.get("NetworkError.20006")
//        
//        // BOOKING
//    case NetworkErrorCodes.Booking.NoSuchBook:
//        return Localizer.get("NetworkError.24001")
//    case NetworkErrorCodes.Booking.CannotBookOutOfAvailability:
//        return Localizer.get("NetworkError.24002")
//    case NetworkErrorCodes.Booking.BookOverlap:
//        return Localizer.get("NetworkError.24003")
//    case NetworkErrorCodes.Booking.NotInBook:
//        return Localizer.get("NetworkError.24004")
//    case NetworkErrorCodes.Booking.Earlier5minStartDate:
//        return Localizer.get("NetworkError.24005")
//    case NetworkErrorCodes.Booking.NoToken:
//        return Localizer.get("NetworkError.24006")
//    case NetworkErrorCodes.Booking.NotFound:
//        return Localizer.get("NetworkError.24007")
//    case NetworkErrorCodes.Booking.BookRateAfterCall:
//        return Localizer.get("NetworkError.24008")
//    case NetworkErrorCodes.Booking.NotAcceptedBook:
//        return Localizer.get("NetworkError.240010")
//    case NetworkErrorCodes.Booking.SlowerReaction:
//        return Localizer.get("NetworkError.240011")
//        
//        // PAYMENT
//    case NetworkErrorCodes.Payment.PaymentFailed:
//        return Localizer.get("NetworkError.80001")
//    case NetworkErrorCodes.Payment.NoPaymentMethod:
//        return Localizer.get("NetworkError.80002")
//    case NetworkErrorCodes.Payment.StripeAccountOnBoardingAlreadyDone:
//        return Localizer.get("NetworkError.80003")
//    case NetworkErrorCodes.Payment.StripeAccountOnBoardingNotDone:
//        return Localizer.get("NetworkError.80004")
//    case NetworkErrorCodes.Payment.StripeAccountNotExist:
//        return Localizer.get("NetworkError.80005")
//        
//        // VONAGE
//    case NetworkErrorCodes.Vonage.VonageApiError:
//        return Localizer.get("NetworkError.90001")
//        
//    default:
//        break
//    }
//    
//    return Localizer.get("NetworkError.0")
//    
//}
