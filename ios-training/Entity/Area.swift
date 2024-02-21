//
//  Area.swift
//  ios-training
//
//  Created by 垣本 桃弥 on 2024/02/21.
//

import Foundation

/// 地域を表すエンティティ
public enum Area: String, CaseIterable, Codable {
    case Sapporo
    case Sendai
    case Niigata
    case Kanazawa
    case Tokyo
    case Nagoya
    case Osaka
    case Hiroshima
    case Kochi
    case Fukuoka
    case Kagoshima
    case Naha
    
    var description: String {
        switch self {
        case .Sapporo:
            "札幌"
        case .Sendai:
            "仙台"
        case .Niigata:
            "新潟"
        case .Kanazawa:
            "金沢"
        case .Tokyo:
            "東京"
        case .Nagoya:
            "名古屋"
        case .Osaka:
            "大阪"
        case .Hiroshima:
            "広島"
        case .Kochi:
            "高知"
        case .Fukuoka:
            "福岡"
        case .Kagoshima:
            "鹿児島"
        case .Naha:
            "那覇"
        }
    }
}
