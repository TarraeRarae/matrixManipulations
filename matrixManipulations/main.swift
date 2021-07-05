//
//  main.swift
//  matrixManipulations
//
//  Created by TarraeRarae on 05.07.2021.
//

import Foundation

func initial() -> [[Int]] {
    print("Введите количество строк матрицы: ");
    let n : Int = Int(readLine() ?? "") ?? 0
    print("Введите количество столбцов матрицы: ");
    let m : Int = Int(readLine() ?? "") ?? 0
    var matr = Array(repeating: Array(repeating: 0, count: m), count: n)
    for i in 0..<n {
        for j in 0..<m {
            matr[i][j] = Int.random(in: -100...100)
        }
    }
    print("\nНачальная матрица:")
    printer(array:matr, n:n, m:m)
    return matr
}

func printer( array: [[Int]], n : Int, m : Int) {
    for i in 0..<n {
        for j in 0..<m {
            print(array[i][j], terminator: " ")
        }
        print("\n")
    }
}

func changeMax(array: inout [[Int]]) -> [[Int]] {
    var max : Int = Int.min
    var j1 : Int = 0;
    for i in 0..<array.count {
        for j in 0..<array[0].count {
            if (array[i][j] >= max) {
                max = array[i][j]
                j1 = j
            }
        }
        array[i][j1] = -1 * array[i][j1]
        max = Int.min
    }
    print("\nКонечная матрица: ")
    printer(array: array, n: array.count, m: array[0].count)
    return array
}

func changeColumns(array: inout [[Int]]) -> [[Int]] {
    //var changerColumns : Array<Int> = Array(repeating: 0, count: array[0].count)
    var changerColumns : Int = 0
    for i in 0..<array.count {
        changerColumns = array[i][0]
        array[i][0] = array[i][array[0].count-1]
        array[i][array[0].count-1] = changerColumns
    }
    print("\nКонечная матрица: ")
    printer(array: array, n: array.count, m: array[0].count)
    return array
}

func addZeroColumn(array: inout [[Int]]) -> [[Int]] {
    var maxArr : Array<Int> = []
    var max : Int = Int.min
    for i in 0..<array.count {
        for j in 0..<array[0].count {
            if (array[i][j] > max) {
                max = array[i][j]
            }
        }
    }
    for i in 0..<array.count {
        for j in 0..<array[0].count {
            if (array[i][j] == max) {
                if (!maxArr.contains(j)) {
                    maxArr.append(j)
                }
            }
        }
    }
    var step : Int = 0
    for i in 0..<array.count {
        for j in 0..<maxArr.count {
            array[i].insert(0, at: maxArr[j]+1+step)
            step = step + 1
        }
        step = 0
    }
    
    print("\nКонечная матрица: ")
    printer(array: array, n: array.count, m: array[0].count)
    return array
}

func deleteColumns(array: inout [[Int]]) -> [[Int]] {
    var negativeArr : Array<Int> = []
    for i in 0..<array.count {
        for j in 0..<array[0].count {
            if (array[i][j] < 0) {
                if (!negativeArr.contains(j)) {
                    negativeArr.append(j)
                }
            }
        }
    }
    negativeArr.sort()
    for i in 0..<array.count {
        for j in stride(from: negativeArr.count-1, to: -1, by: -1) {
            array[i].remove(at: negativeArr[j])
        }
    }
    print("Конечная матрица:")
    printer(array: array, n: array.count, m: array[0].count)
    return array
}

func MainMenu() {
    var matrix = [[Int]]()
    while (true) {
        print("1 – Заменить максимальный элемент каждой строки на противоположный")
        print("2 – Добавить столбец из нулей после столбцов с максимальным элементом")
        print("3 – Удалить столбцы с отрицательными элементами")
        print("4 – Поменять местами первый и последний столбцы")
        print("5 – Выход")
        print("Введите номер выбранного пункта меню")
        var someVar : Int = Int(readLine() ?? "") ?? 0
        switch someVar {
        case 1:
            matrix = initial()
            matrix = changeMax(array: &matrix)
            break
        case 2:
            matrix = initial()
            matrix = addZeroColumn(array: &matrix)
            break
        case 3:
            matrix = initial()
            matrix = deleteColumns(array: &matrix)
            break
        case 4:
            matrix = initial()
            matrix = changeColumns(array: &matrix)
            break
        case 5:
            return
        default:
            print("Такого пункта меню нет")
        }
    }
}

MainMenu()
