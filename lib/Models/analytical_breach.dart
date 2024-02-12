// To parse this JSON data, do
//
//     final analyticaBreach = analyticaBreachFromJson(jsonString);

import 'dart:convert';

AnalyticaBreach analyticaBreachFromJson(String str) => AnalyticaBreach.fromJson(json.decode(str));


class AnalyticaBreach {
    BreachMetrics? breachMetrics;
    BreachesSummary? breachesSummary;
    ExposedBreaches? exposedBreaches;
    List<dynamic>? exposedPastes;
    dynamic pasteMetrics;
    PastesSummary? pastesSummary;

    AnalyticaBreach({
        this.breachMetrics,
        this.breachesSummary,
        this.exposedBreaches,
        this.exposedPastes,
        this.pasteMetrics,
        this.pastesSummary,
    });

    factory AnalyticaBreach.fromJson(Map<String, dynamic> json) => AnalyticaBreach(
        breachMetrics: BreachMetrics.fromJson(json["BreachMetrics"]),
        breachesSummary: BreachesSummary.fromJson(json["BreachesSummary"]),
        exposedBreaches: ExposedBreaches.fromJson(json["ExposedBreaches"]),
        exposedPastes: json["ExposedPastes"]['pastes_details'],
        pasteMetrics: json["PasteMetrics"],
        pastesSummary: PastesSummary.fromJson(json["PastesSummary"]),
    );

    // Map<String, dynamic> toJson() => {
    //     "BreachMetrics": breachMetrics.toJson(),
    //     "BreachesSummary": breachesSummary.toJson(),
    //     "ExposedBreaches": exposedBreaches.toJson(),
    //     "ExposedPastes": exposedPastes,
    //     "PasteMetrics": pasteMetrics,
    //     "PastesSummary": pastesSummary.toJson(),
    // };
}

class BreachMetrics {
    List<dynamic>? getDetails;
    List<List<List<dynamic>>>? industry;
    List<PasswordsStrength>? passwordsStrength;
    List<Risk>? risk;
    List<XposedDatum>? xposedData;
    List<Map<String, int>>? yearwiseDetails;

    BreachMetrics({
        this.getDetails,
        this.industry,
        this.passwordsStrength,
        this.risk,
        this.xposedData,
        this.yearwiseDetails,
    });

    factory BreachMetrics.fromJson(Map<String, dynamic> json) => BreachMetrics(
        getDetails: List<dynamic>.from(json["get_details"].map((x) => x)),
        industry: List<List<List<dynamic>>>.from(json["industry"].map((x) => List<List<dynamic>>.from(x.map((x) => List<dynamic>.from(x.map((x) => x)))))),
        passwordsStrength: List<PasswordsStrength>.from(json["passwords_strength"].map((x) => PasswordsStrength.fromJson(x))),
        risk: List<Risk>.from(json["risk"].map((x) => Risk.fromJson(x))),
        xposedData: List<XposedDatum>.from(json["xposed_data"].map((x) => XposedDatum.fromJson(x))),
        yearwiseDetails: List<Map<String, int>>.from(json["yearwise_details"].map((x) => Map.from(x).map((k, v) => MapEntry<String, int>(k, v)))),
    );

    // Map<String, dynamic> toJson() => {
    //     "get_details": List<dynamic>.from(getDetails.map((x) => x)),
    //     "industry": List<dynamic>.from(industry.map((x) => List<dynamic>.from(x.map((x) => List<dynamic>.from(x.map((x) => x)))))),
    //     "passwords_strength": List<dynamic>.from(passwordsStrength.map((x) => x.toJson())),
    //     "risk": List<dynamic>.from(risk.map((x) => x.toJson())),
    //     "xposed_data": List<dynamic>.from(xposedData.map((x) => x.toJson())),
    //     "yearwise_details": List<dynamic>.from(yearwiseDetails.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
    // };
}

class PasswordsStrength {
    int? easyToCrack;
    int? plainText;
    int? strongHash;
    int? unknown;

    PasswordsStrength({
        this.easyToCrack,
        this.plainText,
        this.strongHash,
        this.unknown,
    });

    factory PasswordsStrength.fromJson(Map<String, dynamic> json) => PasswordsStrength(
        easyToCrack: json["EasyToCrack"],
        plainText: json["PlainText"],
        strongHash: json["StrongHash"],
        unknown: json["Unknown"],
    );

    Map<String, dynamic> toJson() => {
        "EasyToCrack": easyToCrack,
        "PlainText": plainText,
        "StrongHash": strongHash,
        "Unknown": unknown,
    };
}

class Risk {
    String? riskLabel;
    int? riskScore;

    Risk({
        this.riskLabel,
        this.riskScore,
    });

    factory Risk.fromJson(Map<String, dynamic> json) => Risk(
        riskLabel: json["risk_label"],
        riskScore: json["risk_score"],
    );

    Map<String, dynamic> toJson() => {
        "risk_label": riskLabel,
        "risk_score": riskScore,
    };
}

class XposedDatum {
    List<XposedDatumChild>? children;

    XposedDatum({
        this.children,
    });

    factory XposedDatum.fromJson(Map<String, dynamic> json) => XposedDatum(
        children: List<XposedDatumChild>.from(json["children"].map((x) => XposedDatumChild.fromJson(x))),
    );

    // Map<String, dynamic> toJson() => {
    //     "children": List<dynamic>.from(children.map((x) => x.toJson())),
    // };
}

class XposedDatumChild {
    List<ChildChild>? children;
    String? colname;
    String? name;

    XposedDatumChild({
        this.children,
        this.colname,
        this.name,
    });

    factory XposedDatumChild.fromJson(Map<String, dynamic> json) => XposedDatumChild(
        children: List<ChildChild>.from(json["children"].map((x) => ChildChild.fromJson(x))),
        colname: json["colname"],
        name: json["name"],
    );

    // Map<String, dynamic> toJson() => {
    //     "children": List<dynamic>.from(children.map((x) => x.toJson())),
    //     "colname": colname,
    //     "name": name,
    // };
}

class ChildChild {
    Colname? colname;
    String? group;
    String? name;
    int? value;

    ChildChild({
        this.colname,
        this.group,
        this.name,
        this.value,
    });

    factory ChildChild.fromJson(Map<String, dynamic> json) => ChildChild(
        colname: colnameValues.map[json["colname"]],
        group: json["group"],
        name: json["name"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "colname": colnameValues.reverse[colname],
        "group": group,
        "name": name,
        "value": value,
    };
}

enum Colname {
    LEVEL3
}

final colnameValues = EnumValues({
    "level3": Colname.LEVEL3
});

class BreachesSummary {
    String? site;

    BreachesSummary({
        this.site,
    });

    factory BreachesSummary.fromJson(Map<String, dynamic> json) => BreachesSummary(
        site: json["site"],
    );

    Map<String, dynamic> toJson() => {
        "site": site,
    };
}

class ExposedBreaches {
    List<BreachesDetail>? breachesDetails;

    ExposedBreaches({
        this.breachesDetails,
    });

    factory ExposedBreaches.fromJson(Map<String, dynamic> json) => ExposedBreaches(
        breachesDetails: List<BreachesDetail>.from(json["breaches_details"].map((x) => BreachesDetail.fromJson(x))),
    );

    // Map<String, dynamic> toJson() => {
    //     "breaches_details": List<dynamic>.from(breachesDetails.map((x) => x.toJson())),
    // };
}

class BreachesDetail {
    String? breach;
    String? details;
    String? domain;
    String ?industry;
    String? logo;
    String? passwordRisk;
    String? references;
    Searchable? searchable;
    Searchable? verified;
    String? xposedData;
    String? xposedDate;
    int? xposedRecords;

    BreachesDetail({
        this.breach,
        this.details,
        this.domain,
        this.industry,
        this.logo,
        this.passwordRisk,
        this.references,
        this.searchable,
        this.verified,
        this.xposedData,
        this.xposedDate,
        this.xposedRecords,
    });

    factory BreachesDetail.fromJson(Map<String, dynamic> json) => BreachesDetail(
        breach: json["breach"],
        details: json["details"],
        domain: json["domain"],
        industry: json["industry"],
        logo: json["logo"],
        passwordRisk: json["password_risk"],
        references: json["references"],
        searchable: searchableValues.map[json["searchable"]],
        verified: searchableValues.map[json["verified"]],
        xposedData: json["xposed_data"],
        xposedDate: json["xposed_date"],
        xposedRecords: json["xposed_records"],
    );

    Map<String, dynamic> toJson() => {
        "breach": breach,
        "details": details,
        "domain": domain,
        "industry": industry,
        "logo": logo,
        "password_risk": passwordRisk,
        "references": references,
        "searchable": searchableValues.reverse[searchable],
        "verified": searchableValues.reverse[verified],
        "xposed_data": xposedData,
        "xposed_date": xposedDate,
        "xposed_records": xposedRecords,
    };
}

enum Searchable {
    NO,
    YES
}

final searchableValues = EnumValues({
    "No": Searchable.NO,
    "Yes": Searchable.YES
});

class PastesSummary {
    int? cnt;
    String? domain;
    String? tmpstmp;

    PastesSummary({
        this.cnt,
        this.domain,
        this.tmpstmp,
    });

    factory PastesSummary.fromJson(Map<String, dynamic> json) => PastesSummary(
        cnt: json["cnt"],
        domain: json["domain"],
        tmpstmp: json["tmpstmp"],
    );

    Map<String, dynamic> toJson() => {
        "cnt": cnt,
        "domain": domain,
        "tmpstmp": tmpstmp,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
