import UIKit

class HistoryViewController: UIViewController {
  var history: Array<String>?
    @IBOutlet weak var historyText: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    historyText.text = history!.joinWithSeparator("\n")
  }
}