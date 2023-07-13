func arrayToString(array: [String?]) -> String {
    if array.isEmpty {
        return ""
    }
    var result = ""
    for counter in 0...array.count - 1 {
        result.append(array[counter]! + " ")
    }
    return result
}

func genresToString(array: [Generes], count: Int) -> String {
    if array.isEmpty {
        return ""
    }

    var result = ""

    for counter in 0...array.count - 1 {
        if counter == count {
            result.append(array[counter].name!)
            continue
        }
        result.append(array[counter].name! + ", ")
    }
    return result
}

func actorsToString(array: [Person], count: Int) -> String {
    var result = ""

    let count = count > array.count ? array.count : count

    for counter in 0...count {
        if counter == count {
            result.append(array[counter].enName ?? array[counter].name!)
            continue
        }
        result.append(array[counter].enName ?? array[counter].name!)
        result.append(", ")
    }
    return result
}
