//
//  PlaceType.swift
//  PlacesApiTutorial
//
//  Created by Lucas Daniel Costa da Silva on 08/07/24.
//
import Foundation

struct Place: Identifiable {
  var id = UUID()
  var name: String
  var rating: Double
  var address: String
  var openNow: Bool
  var schedule: [String]
  var phoneNumber: String
  var overview: String
  var photo: String
  var wheelchairAccessibleEntrance: Bool
  
  init(id: UUID = UUID(), name: String, rating: Double, address: String, openNow: Bool, schedule: [String], phoneNumber: String, overview: String, photo: String, wheelchairAccessibleEntrance: Bool) {
    self.id = id
    self.name = name
    self.rating = rating
    self.address = address
    self.openNow = openNow
    self.schedule = schedule
    self.phoneNumber = phoneNumber
    self.overview = overview
    self.photo = photo
    self.wheelchairAccessibleEntrance = wheelchairAccessibleEntrance
  }
}
