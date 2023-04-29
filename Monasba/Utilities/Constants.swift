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

//Auth CONTROLLERS
let LOGIN_VCID = "login"



//Home Controllers
let TYPE_VCID = "type"
let SORT_VCID = "sort"
let COUNTRY_VCIID = "country_list"
let CITIES_VCIID = "city_list"
let CITY_VCIID = "cities"

let NO_INTERNET_CONNECTION = "No internet connection".localize
let SERVER_ERROR = "server error ... try again later".localize



class Constants {
    static let MAIN_DOMAIN = "http://bluezone-web.com/"
    static let DOMAIN = MAIN_DOMAIN + "api/"
    static let IMAGE_URL = MAIN_DOMAIN + "image/"
    
    
    //Hoome
    static let HOME_PRODUCTS_URL = DOMAIN + "prods_by_filter"
    static let GET_CATEGORIES_URL = DOMAIN + "categories"
    static let GET_SUB_CATEGORIES_URL = DOMAIN + "sub_category"

    
    //UTILITIES
    static let COUNTRIES_URL = DOMAIN + "countries"
    static let CITIES_URL = DOMAIN + "cities_by_country_id"

    
    static var COUNTRIES = [Country]()
    static var CITIES = [Country]()

    
}
