//
//  ContentView.swift
//  CalculatorP9
//
//  Created by Armando Shala on 05.05.23.
//
//

import SwiftUI

var result = 0.0
var firstNumber: Double?
var secondNumber: Double?
var firstNumberEntered = false
var secondNumberEntered = false
var operatorSymbol = ""

struct ContentView: View {
    @State private var result = 0.0
    var body: some View {
        VStack() {
            HStack {
                // Text("\(result, specifier: "%.0f")")
                Text(String(result))
                        .font(.system(size: 64))
                        .foregroundColor(.white)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 20)
            }
            Group {
                HStack {
                    ActionButton(text: "AC", result: $result)
                    ActionButton(text: "+/-", result: $result)
                    ActionButton(text: "%", result: $result)
                    OperatorButton(text: "/", result: $result)
                }
                HStack {
                    NumberButton(text: "7", result: $result)
                    NumberButton(text: "8", result: $result)
                    NumberButton(text: "9", result: $result)
                    OperatorButton(text: "*", result: $result)
                }
                HStack {
                    NumberButton(text: "4", result: $result)
                    NumberButton(text: "5", result: $result)
                    NumberButton(text: "6", result: $result)
                    OperatorButton(text: "-", result: $result)
                }
                HStack {
                    NumberButton(text: "1", result: $result)
                    NumberButton(text: "2", result: $result)
                    NumberButton(text: "3", result: $result)
                    OperatorButton(text: "+", result: $result)
                }
                HStack {
                    NumberButton(text: "0", result: $result)
                    NumberButton(text: ".", result: $result)
                    OperatorButton(text: "=", result: $result)
                            .frame(maxWidth: 210) // this fugly
                            .layoutPriority(1)
                }
            }
        }
                .frame(
                        minWidth: 0,
                        maxWidth: .infinity,
                        minHeight: 0,
                        maxHeight: .infinity,
                        alignment: .bottom
                )
                .background(Color.black)
    }
}

func buttonAction(text: String, result: Binding<Double>) {
    if (text == "AC") {
        firstNumber = nil
        secondNumber = nil
        firstNumberEntered = false
        result.wrappedValue = 0.0
    } else if (text == "+/-") {
        result.wrappedValue = result.wrappedValue * -1
    } else if (text == "%") {
        result.wrappedValue = result.wrappedValue / 100
    } else if (text == "=") {
        setNumberForCalculation(number: result.wrappedValue)
        result.wrappedValue = performCalculation()
    } else if (text == "+" || text == "-" || text == "*" || text == "/") {
        operatorSymbol = text
        firstNumberEntered = true
        setNumberForCalculation(number: result.wrappedValue)
    } else {
        if (text == ".") {
            return
        }
        result.wrappedValue = Double(firstNumberEntered && !secondNumberEntered ? text : String(result.wrappedValue).dropLast(2) + text)!
        secondNumberEntered = firstNumberEntered && !secondNumberEntered ? true : secondNumberEntered

//        if(firstNumberEntered && !secondNumberEntered){
//            result.wrappedValue = Double(text)!
//            secondNumberEntered = true
//        } else{
//            result.wrappedValue = Double(String(result.wrappedValue).dropLast(2) + text)!
//        }
    }
}

func setNumberForCalculation(number: Double) {
    if firstNumber == nil {
        firstNumber = number
    } else if secondNumber == nil {
        secondNumber = number
    }
}

func performCalculation() -> Double {
    firstNumberEntered = false // reset
    secondNumberEntered = false // reset

    let expressoin = NSExpression(format: "\(firstNumber!) \(operatorSymbol) \(secondNumber!)")
    if let subResult = expressoin.expressionValue(with: nil, context: nil) as? Double {
        return subResult
    } else {
        print("Error")
        return 0.0
    }
}

struct BaseButton: View {
    // button with rounded corners
    var text: String
    var backgroundcolor: Color
    @Binding var result: Double
    var body: some View {
        Button(action: { buttonAction(text: text, result: $result) }) {
            Text(text)
                    .font(.system(size: 32))
                    .foregroundColor(.white)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
        }
                .frame(height: 130)
                .background(backgroundcolor)
                .background(Color(red: 55 / 255, green: 55 / 255, blue: 55 / 255))
                .cornerRadius(0)
    }
}

struct NumberButton: View {
    var text: String
    @Binding var result: Double
    var body: some View {
        BaseButton(text: text, backgroundcolor: Color(red: 55 / 255, green: 55 / 255, blue: 55 / 255), result: $result)
    }
}

struct OperatorButton: View {
    var text: String
    @Binding var result: Double
    var size = 1
    var body: some View {
        BaseButton(text: text, backgroundcolor: .orange, result: $result)
    }
}

struct ActionButton: View {
    var text: String
    @Binding var result: Double
    var body: some View {
        BaseButton(text: text, backgroundcolor: Color(red: 155 / 255, green: 155 / 255, blue: 155 / 255), result: $result)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
