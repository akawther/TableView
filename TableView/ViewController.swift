
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var loadMore: UIRefreshControl!
    
    var labels = ["A","B","C","D","E","F","G","H","I","J","K"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadMore = UIRefreshControl()
        self.loadMore.attributedTitle = NSAttributedString(string: "Pull to reload more")
        self.loadMore.addTarget(self, action: #selector(ViewController.loadMoreChats), for: .valueChanged)
        self.tableView.addSubview(self.loadMore)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func loadMoreChats() {
        DispatchQueue.main.async(execute: {() -> Void in
            self.tableView.beginUpdates()
            self.labels.insert("3", at: 0)
            self.labels.insert("2", at: 0)
            self.labels.insert("1", at: 0)
            let indexPaths = [
                IndexPath(row: 0, section: 0),
                IndexPath(row: 1, section: 0),
                IndexPath(row: 2, section: 0),
            ]
            self.tableView.insertRows(at: indexPaths, with: .top)
            self.tableView.endUpdates()
            self.loadMore.endRefreshing()
            
            self.tableView.beginUpdates()
            let indexPath = IndexPath(row: 3, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
            self.tableView.endUpdates()
        })
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as! customCellTableViewCell
        
        cell.label.text = labels[indexPath.row]
        return cell
    }

}

