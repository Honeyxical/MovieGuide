func arrayToString(array: [String?]) -> String {
    if array.isEmpty{
        return ""
    }
    var result = ""
    for i in 0...array.count - 1{
        result.append(array[i]! + " ")
    }
    return result
}

func genresToString(array: [Generes], count: Int) -> String {
    if array.isEmpty {
        return ""
    }

    var result = ""

    for i in 0...array.count - 1 {
        if i == count{
            result.append(array[i].name!)
            continue
        }
        result.append(array[i].name! + ", ")
    }
    return result
}

func actorsToString(array: [Person], count: Int) -> String {
    var result = ""

    let count = count > array.count ? array.count : count

    for i in 0...count {
        if i == count{
            result.append(array[i].enName ?? array[i].name!)
            continue
        }
        result.append(array[i].enName ?? array[i].name!)
        result.append(", ")
    }
    return result
}
