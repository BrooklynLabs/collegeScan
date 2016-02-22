//
//  FieldTransform.swift
//  schoolFinder
//
//  Created by Jonathan Yu on 2/17/16.
//  Copyright © 2016 Jonathan Yu. All rights reserved.
//

import Foundation
import ObjectMapper

public class FieldTransform: TransformType {
    public typealias Object = String
    public typealias JSON = String
    
    public init() {}
    
    public func transformFromJSON(value: AnyObject?) -> String? {
        if let valueInt = value as? Int {
            return String(valueInt)
        }
        
        if let valueDouble = value as? Double {
            return String(valueDouble)
        }
        
        return "Not Found"
    }
    
    public func transformToJSON(value: String?) -> String? {
        return nil
    }
    
}

public class DollarTransform: TransformType {
    public typealias Object = String
    public typealias JSON = String
    
    public init() {}
    
    public func transformFromJSON(value: AnyObject?) -> String? {
        
        if let valueDouble = value as? Double {
            let dollarFormatter = NSNumberFormatter()
            dollarFormatter.numberStyle = .CurrencyStyle
            return dollarFormatter.stringFromNumber(valueDouble)
        }
        
        return "Not Found"
    }
    
    public func transformToJSON(value: String?) -> String? {
        return nil
    }
    
}

public class YesNoTransform: TransformType {
    public typealias Object = String
    public typealias JSON = String
    
    public init() {}
    
    public func transformFromJSON(value: AnyObject?) -> String? {
        
        if let valueDouble = value as? Double {
            if valueDouble == 1.0 {
                return "yes"
            } else {
                return "no"
            }
        }
        
        return "Not Found"
    }
    
    public func transformToJSON(value: String?) -> String? {
        return nil
    }
}

public class PercentTransform: TransformType {
    public typealias Object = String
    public typealias JSON = String
    
    public init() {}
    
    public func transformFromJSON(value: AnyObject?) -> String? {
        
        if let valueDouble = value as? Double {
            let percentFormatter = NSNumberFormatter()
            percentFormatter.numberStyle = .PercentStyle
            return percentFormatter.stringFromNumber(valueDouble)
        }
        
        return "Not Found"
    }
    
    public func transformToJSON(value: String?) -> String? {
        return nil
    }
}

public class RegionTransform: TransformType {
    public typealias Object = String
    public typealias JSON = String
    let regions: [String: String] = [
        "1": "New England (CT, ME, MA, NH, RI, VT)",
        "2": "Mid East (DE, DC, MD, NJ, NY, PA)",
        "3": "Great Lakes (IL, IN, MI, OH, WI)",
        "4": "Plains (IA, KS, MN, MO, NE, ND, SD)",
        "5": "Southeast (AL, AR, FL, GA, KY, LA, MS, NC, SC, TN, VA, WV)",
        "6": "Southwest (AZ, NM, OK, TX)",
        "7": "Rocky Mountains (CO, ID, MT, UT, WY)",
        "8": "Far West (AK, CA, HI, NV, OR, WA)",
        "9": "Outlying Areas (AS, FM, GU, MH, MP, PR, PW, VI)",
        "11": "City: Large (population of 250,000 or more)",
        "12": "City: Midsize (population of at least 100,000 but less than 250,000)",
        "13": "City: Small (population less than 100,000)",
        "21": "Suburb: Large (outside principal city, in urbanized area with population of 250,000 or more)",
        "22": "Suburb: Midsize (outside principal city, in urbanized area with population of at least 100,000 but less than 250,000)",
        "23": "Suburb: Small (outside principal city, in urbanized area with population less than 100,000)",
        "31": "Town: Fringe (in urban cluster up to 10 miles from an urbanized area)",
        "32": "Town: Distant (in urban cluster more than 10 miles and up to 35 miles from an urbanized area)",
        "33": "Town: Remote (in urban cluster more than 35 miles from an urbanized area)",
        "41": "Rural: Fringe (rural territory up to 5 miles from an urbanized area or up to 2.5 miles from an urban cluster)",
        "42": "Rural: Distant (rural territory more than 5 miles but up to 25 miles from an urbanized area or more than 2.5 and up to 10 miles from an urban cluster)",
        "43": "Rural: Remote (rural territory more than 25 miles from an urbanized area and more than 10 miles from an urban cluster)"
    ]
    
    public init() {}
    
    public func transformFromJSON(value: AnyObject?) -> String? {
        
        if let value = value as? Int {
            if let foundRegion = regions[String(value)] {
                return foundRegion
            } 
        }
        
        return "Not Found"
    }
    
    public func transformToJSON(value: String?) -> String? {
        return nil
    }
}

public class SizeReligionTransform: TransformType {
    public typealias Object = String
    public typealias JSON = String
    let sizeReligions: [String: String] = [
        "1": "Very small 2-year (confers associate’s degrees, FTE enrollment less than 500)",
        "2": "Small 2-year (confers associate’s degrees, FTE enrollment 500 to 1,999)",
        "3": "Medium 2-year (confers associate’s degrees, FTE enrollment 2000 to 4,999)",
        "4": "Large 2-year (confers associate’s degrees, FTE enrollment 5000 to 9,999)",
        "5": "Very large 2-year (confers associate’s degrees, FTE enrollment 10,000 or more)",
        "6": "Very small 4-year, primarily nonresidential (confers bachelor’s degrees, FTE enrollment less than 1,000, less than 25 percent of degree-seeking undergraduates live on campus and/or less than 50 percent attend full time)",
        "7": "Very small 4-year, primarily residential (confers bachelor’s degrees, FTE enrollment less than 1,000, 25 to 49 percent of degree-seeking undergraduates live on campus and at least 50 percent attend full time)",
        "8": "Very small 4-year, highly residential (confers bachelor’s degrees, FTE enrollment less than 1,000, at least 50 percent of degree-seeking undergraduates live on campus and at least 80 percent attend full time)",
        "9": "Small 4-year, primarily nonresidential (confers bachelor’s degrees, FTE enrollment 1,000 to 2,999, less than 25 percent of degree-seeking undergraduates live on campus and/or less than 50 percent attend full time)",
        "10": "Small 4-year, primarily residential (confers bachelor’s degrees, FTE enrollment 1,000 to 2,999, 25 to 49 percent of degree-seeking undergraduates live on campus and at least 50 percent attend full time)",
        "11": "Small 4-year, highly residential (confers bachelor’s degrees, FTE enrollment 1,000 to 2,999, at least 50 percent of degree-seeking undergraduates live on campus and at least 80 percent attend full time)",
        "12": "Medium 4-year, primarily nonresidential (confers bachelor’s degrees, FTE enrollment 3,000 to 9,999, less than 25 percent of degree-seeking undergraduates live on campus and/or less than 50 percent attend full time)",
        "13": "Medium 4-year, primarily residential (confers bachelor’s degrees, FTE enrollment 3,000 to 9,999, 25 to 49 percent of degree-seeking undergraduates live on campus and at least 50 percent attend full time)",
        "14": "Medium 4-year, highly residential (confers bachelor’s degrees, FTE enrollment 3,000 to 9,999, at least 50 percent of degree-seeking undergraduates live on campus and at least 80 percent attend full time)",
        "15": "Large 4-year, primarily nonresidential (confers bachelor’s degrees, FTE enrollment over 9,999, less than 25 percent of degree-seeking undergraduates live on campus and/or less than 50 percent attend full time)",
        "16": "Large 4-year, primarily residential (confers bachelor’s degrees, FTE enrollment over 9,999, 25 to 49 percent of degree-seeking undergraduates live on campus and at least 50 percent attend full time)",
        "17": "Large 4-year, highly residential (confers bachelor’s degrees, FTE enrollment over 9,999, at least 50 percent of degree-seeking undergraduates live on campus and at least 80 percent attend full time)",
        "18": "Not applicable, special-focus institution",
        "-1": "Not reported",
        "-2": "Not applicable",
        "22": "American Evangelical Lutheran Church",
        "24": "African Methodist Episcopal Zion Church",
        "27": "Assemblies of God Church",
        "28": "Brethren Church",
        "30": "Roman Catholic",
        "33": "Wisconsin Evangelical Lutheran Synod",
        "34": "Christ and Missionary Alliance Church",
        "35": "Christian Reformed Church",
        "36": "Evangelical Congregational Church",
        "37": "Evangelical Covenant Church of America",
        "38": "Evangelical Free Church of America",
        "39": "Evangelical Lutheran Church",
        "40": "International United Pentecostal Church",
        "41": "Free Will Baptist Church",
        "42": "Interdenominational",
        "43": "Mennonite Brethren Church",
        "44": "Moravian Church",
        "45": "North American Baptist",
        "47": "Pentecostal Holiness Church",
        "48": "Christian Churches and Churches of Christ",
        "49": "Reformed Church in America",
        "50": "Episcopal Church, Reformed",
        "51": "African Methodist Episcopal",
        "52": "American Baptist",
        "53": "American Lutheran",
        "54": "Baptist",
        "55": "Christian Methodist Episcopal",
        "57": "Church of God",
        "58": "Church of Brethren",
        "59": "Church of the Nazarene",
        "60": "Cumberland Presbyterian",
        "61": "Christian Church (Disciples of Christ)",
        "64": "Free Methodist",
        "65": "Friends",
        "66": "Presbyterian Church (USA)",
        "67": "Lutheran Church in America",
        "68": "Lutheran Church - Missouri Synod",
        "69": "Mennonite Church",
        "71": "United Methodist",
        "73": "Protestant Episcopal",
        "74": "Churches of Christ",
        "75": "Southern Baptist",
        "76": "United Church of Christ",
        "77": "Protestant, not specified",
        "78": "Multiple Protestant Denomination",
        "79": "Other Protestant",
        "80": "Jewish",
        "81": "Reformed Presbyterian Church",
        "84": "United Brethren Church",
        "87": "Missionary Church Inc",
        "88": "Undenominational",
        "89": "Wesleyan",
        "91": "Greek Orthodox",
        "92": "Russian Orthodox",
        "93": "Unitarian Universalist",
        "94": "Latter Day Saints (Mormon Church)",
        "95": "Seventh Day Adventists",
        "97": "The Presbyterian Church in America",
        "99": "Other (none of the above)",
        "100": "Original Free Will Baptist",
        "101": "Ecumenical Christian",
        "102": "Evangelical Christian",
        "103": "Presbyterian"
    ]
    
    public init() {}
    
    public func transformFromJSON(value: AnyObject?) -> String? {
        
        if let value = value as? Int {
            if let foundSizeReligion = sizeReligions[String(value)] {
                return foundSizeReligion
            }
        }
        
        return "Not Found"
    }
    
    public func transformToJSON(value: String?) -> String? {
        return nil
    }
}

public class DegreeTransform: TransformType {
    public typealias Object = String
    public typealias JSON = String
    let sizeReligions: [String: String] = [
        "0": "Unknown",
        "1": "Certificate",
        "2": "Associates Degree",
        "3": "Bachelor Degree",
        "4": "Post-Bach Degree"
    ]
    
    public init() {}
    
    public func transformFromJSON(value: AnyObject?) -> String? {
        
        if let value = value as? Int {
            if let foundSizeReligion = sizeReligions[String(value)] {
                return foundSizeReligion
            }
        }
        
        return "Not Found"
    }
    
    public func transformToJSON(value: String?) -> String? {
        return nil
    }
}