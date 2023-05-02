import Foundation

func convertMTH(min: Int) -> String {
    var min = min
    var hours = 0
    
    repeat {
        hours += 1
        min = min - 60
    } while (min > 60);
    
    return String(hours) + "h" + String(min) + "m"
}

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

func genresStringToGenresObj(genres: [String]) -> [Generes] {
    var result: [Generes] = []
    for i in 0...genres.count - 1{
        result.append(Generes(name: genres[i]))
    }
    return result
}
