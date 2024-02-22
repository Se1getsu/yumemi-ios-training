//
//  Area.swift
//  ios-training
//
//  Created by 垣本 桃弥 on 2024/02/21.
//

import Foundation

/// 地域を表すエンティティ
public enum Area: String, CaseIterable, Codable {
    case sapporo = "Sapporo"
    case sendai = "Sendai"
    case niigata = "Niigata"
    case kanazawa = "Kanazawa"
    case tokyo = "Tokyo"
    case nagoya = "Nagoya"
    case osaka = "Osaka"
    case hiroshima = "Hiroshima"
    case kochi = "Kochi"
    case fukuoka = "Fukuoka"
    case kagoshima = "Kagoshima"
    case naha = "Naha"
    
    var description: String {
        switch self {
        case .sapporo:
            "札幌"
        case .sendai:
            "仙台"
        case .niigata:
            "新潟"
        case .kanazawa:
            "金沢"
        case .tokyo:
            "東京"
        case .nagoya:
            "名古屋"
        case .osaka:
            "大阪"
        case .hiroshima:
            "広島"
        case .kochi:
            "高知"
        case .fukuoka:
            "福岡"
        case .kagoshima:
            "鹿児島"
        case .naha:
            "那覇"
        }
    }
}
