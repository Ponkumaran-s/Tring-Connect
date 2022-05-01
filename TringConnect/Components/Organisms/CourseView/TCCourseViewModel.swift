//
//  TCCourseViewModel.swift
//  TringConnect
//
//  Created by Ponkumar's Mac on 01/05/22.
//

import UIKit

class TCCourseViewModel {
    
    private var courseItem: TCCourseItem?

    var noOfCourseItems: Int {
        guard let courses = courseItem?.courses else { return 0 }
        return courses.count
    }
    
    var getSizeFotCourseItem: CGSize {
        CGSize(width: 187.0, height: 270.0)
    }
    
    var getTimestamp: String {
        courseItem?.timestamp ?? ""
    }
    
    var getCourseImpressions: TCLikesAndComments {
        courseItem?.likesAndComments ?? TCLikesAndComments()
    }
    
    func setCourseItem(_ homeItem: TCHomeItem?) {
        guard let item = homeItem as? TCCourseItem else {
            return
        }

        self.courseItem = item
    }
    
    func getCourseItem() -> TCCourseItem? {
        self.courseItem
    }
    
    func getCourse(at index: Int) -> TCCourse? {
        guard let courses = courseItem?.courses,
              index <= courses.count else { return nil }
        return courses[index]
    }
}
