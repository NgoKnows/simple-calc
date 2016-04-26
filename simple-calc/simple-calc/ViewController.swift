//
//  ViewController.swift
//  simple-calc
//
//  Created by Alex Ngo on 4/22/16.
//  Copyright © 2016 Alex Ngo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  var history: Array<String> = []
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if let destinationViewController = segue.destinationViewController as? HistoryViewController {
      destinationViewController.history = history
    }
  
  }
  
  func add(left: Int, right: Int)-> Int {
    return left + right
  }
  
  func sub(left: Int, right: Int)-> Int {
    return left - right
  }
  
  func mul(left: Int, right: Int)-> Int {
    return left * right
  }
  
  func div(left: Int, right: Int)-> Int {
    return Int(Float(left) / Float(right))
  }
  
  func mod(left: Int, right: Int)-> Int {
    return left % right
  }
  
  func count(vals: Array<String>)-> Int {
    return vals.count
  }
  
  func avg(vals: Array<String>)-> Int {
    var total = 0
    print(vals)
    for val in vals {
      total += Int(val)!
    }
    
    return Int(Float(total) / Float(vals.count))
  }
  
  func fact(vals: Array<String>)-> Int {
    var total = 1
    if Int(vals[0])! > 0 {
      for val in 1...Int(vals[0])! {
        total = total * val
      }
    }
    
    return total
  }
  
  func stringIsNumber(str: String) -> Bool {
    return Int(str) != nil
  }
  
  var currentOperation = ""
  
  @IBAction func numberButtonClick(sender: UIButton) {
    if (stringIsNumber(sender.currentTitle!)){
      currentOperation += sender.currentTitle!
    } else {
      currentOperation += " " + sender.currentTitle! + " "
    }
    operation.text = currentOperation
  }
  
  @IBOutlet weak var operation: UILabel!
  
  @IBAction func equalsClick(sender: UIButton) {
    let basicOperations: [String: (Int, Int) -> Int] = ["add": add, "subtract": sub, "multiply": mul, "divide": div, "mod": mod]
    let multiOperations: [String: (Array<String>) -> Int] = ["count": count, "average": avg, "fact": fact]
    
    let arguments = currentOperation.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()).componentsSeparatedByString(" ")
    if (arguments.count <= 1) {
      return
    }
    
    history.append(operation.text!)
    currentOperation = ""
    
    let selectedOperation = arguments[1]
    
    if (selectedOperation == "count" || selectedOperation == "average" || selectedOperation == "fact") {
      var values: [String] = []
      for index in 0...arguments.count - 1 {
        if (index % 2 == 0) {
          values.append(arguments[index])
        }
      }
      operation.text = String(multiOperations[arguments[1]]!(values))
    }
    else {
      operation.text = String(basicOperations[arguments[1]]!(Int(arguments[0])!, Int(arguments[2])!))
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

