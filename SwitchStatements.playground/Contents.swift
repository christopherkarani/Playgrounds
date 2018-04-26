import Foundation

var str = "Hello World I am Chris"

switch true {
case str.localizedCaseInsensitiveContains("do"):
    print("We want a break from this")
case str.localizedCaseInsensitiveContains("Hello"):
    print("Found")
    fallthrough
case str.localizedCaseInsensitiveContains("World"):
    print("found World")
    fallthrough
case str.localizedCaseInsensitiveContains("Chris"):
    print("We found Chris too")
default:
    print("Nothing Found")
}


