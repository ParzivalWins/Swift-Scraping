import Foundation
let baseUrl = "http://www.instagram.com/"
let username = "martin_lasek"
let url = URL(string: baseUrl + username)!
let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
  guard let data = data else {
    print("data was nil")
    return
  }
  guard let htmlString = String(data: data, encoding: .utf8) else {
    print("couldn't cast data into String")
    return
  }
  print(htmlString)
  let leftSideString = """
  edge_followed_by":{"count":
  """
  let rightSideString = """
  },"followed_by_viewer
  """
  guard
    let leftSideRange = htmlString.range(of: leftSideString)
  else {
    print("couldn't find left range")
    return
  }
  guard
    let rightSideRange = htmlString.range(of: rightSideString)
  else {
    print("couldn't find right range")
    return
  }
  let rangeOfTheData = leftSideRange.upperBound..<rightSideRange.lowerBound
  let valueWeWantToGrab = htmlString[rangeOfTheData]
  print(valueWeWantToGrab) // prints the follower count: 19093
}
task.resume()
