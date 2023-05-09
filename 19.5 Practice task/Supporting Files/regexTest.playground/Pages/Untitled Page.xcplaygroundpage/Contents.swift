import RegexBuilder

var regex = Regex {
    One(.anyOf("1,2"))
    Repeat(count: 3) {
        .digit
    }
}


var regex2 = Regex {
    OneOrMore(
        ChoiceOf{
            CharacterClass(.word)
            CharacterClass(.whitespace)
            "-"
            "'"
        }
    )
}


//let match = " ".matches(of: regex2)
//
//print(match.count)
//print("-------")
//for i in match {
//    print(i.output)
//}
//
//let wholeMatch = "asdasd09".wholeMatch(of: regex2)
//
//if let wholeMatch = wholeMatch {
//    print(wholeMatch.0)
//} else {
//    print("not match")
//}

let firstMatch = "2999".firstMatch(of: regex)

if let firstMatch = firstMatch {
    print(firstMatch.0)
} else {
    print("not match")
}

