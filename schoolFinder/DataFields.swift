//
//  DatatFields.swift
//  schoolFinder
//
//  Created by Jonathan Yu on 2/11/16.
//  Copyright © 2016 Jonathan Yu. All rights reserved.
//

import Foundation

struct DataFields {
    let ID =                   "id"
    let NAME =                 "school.name"
    let CITY =                 "school.city"
    let STATE =                "school.state"
    let ZIP_CODE =             "school.zip"
    
    let SCHOOL_URL =           "school.school_url"
    
    let OWNERSHIP =            "school.ownership"
    let LOCALE =               "school.locale"
    let REGION_ID =            "school.region_id"
    
    let RELIGIOUS =            "school.religious_affiliation"
    let OPERATING =            "school.operating"
    
    let SIZE =                 "2013.student.size"
    let ONLINE_ONLY =          "school.online_only"
    
    let WOMEN_ONLY =           "school.women_only"
    let MEN_ONLY =             "school.men_only"
//    let MINORITY_SERVING =     "school.minority_serving"
    
    let PREDOMINANT_DEGREE =   "school.degrees_awarded.predominant"
    let HIGHEST_DEGREE =   "school.degrees_awarded.highest"
    let UNDER_INVESTIGATION =  "school.under_investigation"
    
    // net price
    let NET_PRICE =            "2013.cost.avg_net_price.overall"
//    let NET_PRICE_BY_INCOME =  "2013.cost.net_price"
    
    // completion rate
    let COMPLETION_RATE =      "2013.completion.rate_suppressed.overall"
    
//    let RETENTION_RATE =       "2013.student.retention_rate"
    
    let REPAYMENT_RATE =       "2013.repayment.3_yr_repayment_suppressed.overall"
    
    let AVERAGE_TOTAL_DEBT =   "2013.aid.median_debt_suppressed.completers.overall"
    let MONTHLY_LOAN_PAYMENT = "2013.aid.median_debt_suppressed.completers.monthly_payments"
    
    let AID_PERCENTAGE =       "2013.aid.federal_loan_rate"
    let PELL_PERCENTAGE =      "2013.aid.pell_grant_rate"
    
    let MEDIAN_EARNINGS =      "2011.earnings.10_yrs_after_entry.median"
    
    let EARNINGS_GT_25K =      "2011.earnings.6_yrs_after_entry.percent_greater_than_25000"
    
//    let PROGRAM_PERCENTAGE =   "2013.academics.program_percentage"
//    let PROGRAM_OFFERED =      "2013.academics.program"
//    let DEGREE_OFFERED =       "2013.academics.program_available"
    
    let PART_TIME_SHARE =      "2013.student.part_time_share"
    let FEMALE_SHARE =         "2013.student.demographics.female_share"
//    let RACE_ETHNICITY =       "2013.student.demographics.race_ethnicity"
//    let AGE_ENTRY =            "2013.student.demographics.age_entry"
    
    let ACT_25TH_PCTILE =      "2013.admissions.act_scores.25th_percentile.cumulative"
    let ACT_75TH_PCTILE =      "2013.admissions.act_scores.75th_percentile.cumulative"
    let ACT_MIDPOINT =         "2013.admissions.act_scores.midpoint.cumulative"
    
    let SAT_CUMULATIVE_AVERAGE =   "2013.admissions.sat_scores.average.overall"
    
    let SAT_READING_25TH_PCTILE =  "2013.admissions.sat_scores.25th_percentile.critical_reading"
    let SAT_READING_75TH_PCTILE =  "2013.admissions.sat_scores.75th_percentile.critical_reading"
    let SAT_READING_MIDPOINT =     "2013.admissions.sat_scores.midpoint.critical_reading"
    
    let SAT_MATH_25TH_PCTILE =     "2013.admissions.sat_scores.25th_percentile.math"
    let SAT_MATH_75TH_PCTILE =     "2013.admissions.sat_scores.75th_percentile.math"
    let SAT_MATH_MIDPOINT =        "2013.admissions.sat_scores.midpoint.math"
    
    let SAT_WRITING_25TH_PCTILE =  "2013.admissions.sat_scores.25th_percentile.writing"
    let SAT_WRITING_75TH_PCTILE =  "2013.admissions.sat_scores.75th_percentile.writing"
    let SAT_WRITING_MIDPOINT =     "2013.admissions.sat_scores.midpoint.writing"
    
    let NET_PRICE_CALC_URL =       "school.price_calculator_url"
    
    var key = "lcz2bpUX38zm1juJmF8PgtPvRNi6PKC0ecdDoEuX"
    
    static func print_all_properties(mirror: _MirrorType) -> String {
        var exportProperties = "id"
        for i in 1..<mirror.count {
            let (_, childMirror) = mirror[i]
            let value = childMirror.value
            exportProperties += ",\(value)"
        }
        
        return exportProperties
    }
    
    func print_minimum_properties_with_query(query: [String: String]) -> [String: String] {
        var propertiesExport = print_minimum_properties()
        query.forEach { propertiesExport[$0] = $1 }
        
        return propertiesExport
    }
    
    func print_minimum_properties() -> [String: String] {
        let properties = ID + "," + NAME + "," + CITY + "," + SCHOOL_URL + "," + OWNERSHIP
        return ["fields": properties, "school.operating": "1", "api_key": key]
    }
    
    func operating_only() -> [String: String] {
        return ["school.operating": "1"]
    }
}