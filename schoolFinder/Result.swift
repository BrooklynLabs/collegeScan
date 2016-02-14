//
//  Result.swift
//  schoolFinder
//
//  Created by Jonathan Yu on 2/12/16.
//  Copyright © 2016 Jonathan Yu. All rights reserved.
//

import Foundation
import ObjectMapper

class Result: Mappable {
    
    var ID: String?
    var NAME: String?
    var CITY: String?
    var STATE: String?
    var ZIP_CODE: String?
    var SCHOOL_URL: String?
    var OWNERSHIP: String?
    var LOCALE: String?
    var REGION_ID: String?
    var RELIGIOUS: String?
    var OPERATING: String?
    var SIZE: String?
    var ONLINE_ONLY: String?
    var WOMEN_ONLY: String?
    var MEN_ONLY: String?
    var MINORITY_SERVING: String?
    var PREDOMINANT_DEGREE: String?
    var HIGHEST_DEGREE: String?
    var UNDER_INVESTIGATION: String?
    var NET_PRICE: String?
    var NET_PRICE_BY_INCOME: String?
    var COMPLETION_RATE: String?
    var RETENTION_RATE: String?
    var REPAYMENT_RATE: String?
    var AVERAGE_TOTAL_DEBT: String?
    var MONTHLY_LOAN_PAYMENT: String?
    var AID_PERCENTAGE: String?
    var PELL_PERCENTAGE: String?
    var MEDIAN_EARNINGS: String?
    var EARNINGS_GT_25K: String?
    var PROGRAM_PERCENTAGE: String?
    var PROGRAM_OFFERED: String?
    var DEGREE_OFFERED: String?
    var PART_TIME_SHARE: String?
    var FEMALE_SHARE: String?
    var RACE_ETHNICITY: String?
    var AGE_ENTRY: String?
    var ACT_25TH_PCTILE: String?
    var ACT_75TH_PCTILE: String?
    var ACT_MIDPOINT: String?
    var SAT_CUMULATIVE_AVERAGE: String?
    var SAT_READING_25TH_PCTILE: String?
    var SAT_READING_75TH_PCTILE: String?
    var SAT_READING_MIDPOINT: String?
    var SAT_MATH_25TH_PCTILE: String?
    var SAT_MATH_75TH_PCTILE: String?
    var SAT_MATH_MIDPOINT: String?
    var SAT_WRITING_25TH_PCTILE: String?
    var SAT_WRITING_75TH_PCTILE: String?
    var SAT_WRITING_MIDPOINT: String?
    var NET_PRICE_CALC_URL: String?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        ID <- map["id"]
        NAME <- map["school.name", nested: false]
        CITY <- map["school.city", nested: false]
        STATE <- map["school.state", nested: false]
        ZIP_CODE <- map["school.zip", nested: false]
        SCHOOL_URL <- map["school.school_url", nested: false]
        OWNERSHIP <- map["school.ownership", nested: false]
        LOCALE <- map["school.locale", nested: false]
        REGION_ID <- map["school.region_id", nested: false]
        RELIGIOUS <- map["school.religious_affiliation", nested: false]
        OPERATING <- map["school.operating", nested: false]
        SIZE <- map["2013.student.size", nested: false]
        ONLINE_ONLY <- map["school.online_only", nested: false]
        WOMEN_ONLY <- map["school.women_only", nested: false]
        MEN_ONLY <- map["school.men_only", nested: false]
        MINORITY_SERVING <- map["school.minority_serving", nested: false]
        PREDOMINANT_DEGREE <- map["school.degrees_awarded.predominant", nested: false]
        HIGHEST_DEGREE <- map["school.degrees_awarded.highest", nested: false]
        UNDER_INVESTIGATION <- map["school.under_investigation", nested: false]
        NET_PRICE <- map["2013.cost.avg_net_price.overall", nested: false]
        NET_PRICE_BY_INCOME <- map["2013.cost.net_price", nested: false]
        COMPLETION_RATE <- map["2013.completion.rate_suppressed.overall", nested: false]
        RETENTION_RATE <- map["2013.student.retention_rate", nested: false]
        REPAYMENT_RATE <- map["2013.repayment.3_yr_repayment_suppressed.overall", nested: false]
        AVERAGE_TOTAL_DEBT <- map["2013.aid.median_debt_suppressed.completers.overall", nested: false]
        MONTHLY_LOAN_PAYMENT <- map["2013.aid.median_debt_suppressed.completers.monthly_payments", nested: false]
        AID_PERCENTAGE <- map["2013.aid.federal_loan_rate", nested: false]
        PELL_PERCENTAGE <- map["2013.aid.pell_grant_rate", nested: false]
        MEDIAN_EARNINGS <- map["2011.earnings.10_yrs_after_entry.median", nested: false]
        EARNINGS_GT_25K <- map["2011.earnings.6_yrs_after_entry.percent_greater_than_25000", nested: false]
        PROGRAM_PERCENTAGE <- map["2013.academics.program_percentage", nested: false]
        PROGRAM_OFFERED <- map["2013.academics.program", nested: false]
        DEGREE_OFFERED <- map["2013.academics.program_available", nested: false]
        PART_TIME_SHARE <- map["2013.student.part_time_share", nested: false]
        FEMALE_SHARE <- map["2013.student.demographics.female_share", nested: false]
        RACE_ETHNICITY <- map["2013.student.demographics.race_ethnicity", nested: false]
        AGE_ENTRY <- map["2013.student.demographics.age_entry", nested: false]
        ACT_25TH_PCTILE <- map["2013.admissions.act_scores.25th_percentile.cumulative", nested: false]
        ACT_75TH_PCTILE <- map["2013.admissions.act_scores.75th_percentile.cumulative", nested: false]
        ACT_MIDPOINT <- map["2013.admissions.act_scores.midpoint.cumulative", nested: false]
        SAT_CUMULATIVE_AVERAGE <- map["2013.admissions.sat_scores.average.overall", nested: false]
        SAT_READING_25TH_PCTILE <- map["2013.admissions.sat_scores.25th_percentile.critical_reading", nested: false]
        SAT_READING_75TH_PCTILE <- map["2013.admissions.sat_scores.75th_percentile.critical_reading", nested: false]
        SAT_READING_MIDPOINT <- map["2013.admissions.sat_scores.midpoint.critical_reading", nested: false]
        SAT_MATH_25TH_PCTILE <- map["2013.admissions.sat_scores.25th_percentile.math", nested: false]
        SAT_MATH_75TH_PCTILE <- map["2013.admissions.sat_scores.75th_percentile.math", nested: false]
        SAT_MATH_MIDPOINT <- map["2013.admissions.sat_scores.midpoint.math", nested: false]
        SAT_WRITING_25TH_PCTILE <- map["2013.admissions.sat_scores.25th_percentile.writing", nested: false]
        SAT_WRITING_75TH_PCTILE <- map["2013.admissions.sat_scores.75th_percentile.writing", nested: false]
        SAT_WRITING_MIDPOINT <- map["2013.admissions.sat_scores.midpoint.writing", nested: false]
        NET_PRICE_CALC_URL <- map["school.price_calculator_url", nested: false]
    }
    
}