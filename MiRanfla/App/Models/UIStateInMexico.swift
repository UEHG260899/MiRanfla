//
//  UIStateInMexico.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 09/09/24.
//

import Foundation

enum UIStateInMexico: String, CaseIterable {
    case aguascalientes = "AGUASCALIENTES"
    case bajaCalifornia = "BAJA CALIFORNIA"
    case bajaCaliforniaSur = "BAJA CALIFORNIA SUR"
    case chihuahua = "CHIHUAHUA"
    case chiapas = "CHIAPAS"
    case campeche = "CAMPECHE"
    case cdmx = "CIUDAD DE MEXICO"
    case coahuila = "COAHUILA"
    case colima = "COLIMA"
    case durango = "DURANGO"
    case guerrero = "GUERRERO"
    case guanajuato = "GUANAJUATO"
    case hidalgo = "HIDALGO"
    case jalisco = "JALISCO"
    case michoacan = "MICHOACAN"
    case estadoDeMexico = "ESTADO DE MEXICO"
    case morelos = "MORELOS"
    case nayarit = "NAYARIT"
    case nuevoLeon = "NUEVO LEON"
    case oaxaca = "OAXACA"
    case puebla = "PUEBLA"
    case quintanaRoo = "QUINTANA ROO"
    case queretaro = "QUERETARO"
    case sinaloa = "SINALOA"
    case sanLuisPotosi = "SAN LUIS POTOSI"
    case sonora = "SONORA"
    case tabasco = "TABASCO"
    case tlaxcala = "TLAXCALA"
    case tamaulipas = "TAMAULIPAS"
    case veracruz = "VERACRUZ"
    case yucatan = "YUCATAN"
    case zacatecas = "ZACATECAS"
    #if targetEnvironment(simulator)
    case test = "Test"
    #endif
}

enum VerificationMonth: Int {
    case january = 1
    case february
    case march
    case april
    case may
    case june
    case july
    case august
    case september
    case october
    case november
    case december
}
