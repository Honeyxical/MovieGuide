func arrayToString(array: [String]) -> String {
    if array.isEmpty {
        return ""
    }
    var result = ""
    for counter in 0...array.count - 1 {
        result.append(array[counter] + " ")
    }
    return result
}

func genresToString(array: [Generes], count: Int) -> String {
    if array.isEmpty {
        return ""
    }

    var result = ""

    for counter in 0...array.count - 1 {
        guard let genreName = array[counter].name else { continue }
        if counter == count {
            result.append(genreName)
            continue
        }
        result.append(genreName + ", ")
    }
    return result
}

func actorsToString(array: [Person], count: Int) -> String {
    var result = ""

    let count = count > array.count ? array.count : count

    for counter in 0...count {
        guard let name = array[counter].enName ?? array[counter].name else { continue }
        if counter == count {
            result.append(name)
            continue
        }
        result.append(name + ", ")
    }
    return result
}
