//
//  Constants.swift
//  Sla
//
//  Created by Amal Elgalant on 3/25/20.
//  Copyright © 2020 Amal Elgalant. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

//STORYBOARD
let Auth_STORYBOARD = "Auth"
let MAIN_STORYBOARD = "Main"
let ADVS_STORYBOARD = "Advs"
let PROFILE_STORYBOARD = "Profile"
let CATEGORRY_STORYBOARD = "Category"

//Auth Controllers
let LOGIN_VCID = "login"
let SIGNUP_VCID = "register"
let SIGNUP_CODE_VCID = "verify_email"

let FORGET_PASSWORD_VCID = "forget_passworrd"
let FORGET_VERIFY_CODE_VCID = "verify_phone"
let RESET_PASSWORD_VCID = "reset_password"



//Home Controllers
let TYPE_VCID = "type"
let SORT_VCID = "sort"
let COUNTRY_VCIID = "country_list"
let CITIES_VCIID = "city_list"
let CITY_VCIID = "cities"
let STATE_VCID = "state_list"
let CATEGORIES_VCID = "categories"


let NO_INTERNET_CONNECTION = "No internet connection".localize
let SERVER_ERROR = "server error ... try again later".localize

//Advs Controllers
let ADDADVS_VCID = "AddAdvsVC"
let PICKUP_MEDIA_POPUP_VCID = "PickupMediaPopupVC"
let SUCCESS_ADDING_VCID = "SuccessAddingVC"

//Profile Controllers

let OTHER_USER_PROFILE_VCID = "OtherUserProfileVC"



//Constants

class Constants {
    static let MAIN_DOMAIN = "http://bluezone-web.com/"
    static let DOMAIN = MAIN_DOMAIN + "api/"
    static let IMAGE_URL = MAIN_DOMAIN + "image/"
    
    
    //Home
    static let HOME_PRODUCTS_URL = DOMAIN + "prods_by_filter"
    static let GET_CATEGORIES_URL = DOMAIN + "categories"
    static let GET_SUB_CATEGORIES_URL = DOMAIN + "sub_category"
    
    //Auth
    //signup
    static let LOGIN_URL = DOMAIN + "login"
    static let SIGN_UP_URL = DOMAIN + "signup"
    static let SIGN_UP_VERIFY_URL = DOMAIN + "verification"
    static let SIGN_UP_RESEND_CODE_URL = DOMAIN + "resend_code"
    static let CHECK_USER_URL = DOMAIN + "check-user"
    static let RESET_PASSWORD_URL = DOMAIN + "forgot-password"

    //forgot-password
    //UTILITIES
    static let COUNTRIES_URL = DOMAIN + "countries"
    static let CITIES_URL = DOMAIN + "cities_by_country_id"
    static let STATE_URL = DOMAIN + "region_by_city_id"

    static var COUNTRIES = [Country]()
    static var CITIES = [Country]()
    static var STATUS = [Country]()

    
}
