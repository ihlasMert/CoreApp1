import UIKit
import CoreData
var noteList = [Note]()
class NoteTableView: UITableViewController{
    
    
    var firstLoad = true
    override func viewDidLoad() {
        if (firstLoad){
            firstLoad = false
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
            do{
                let _results: NSArray = try context.fetch(request) as NSArray
                for _result in _results {
                    let note = _result as! Note
                    noteList.append(note)
                }
            }catch{
                print("Fetch Failed")
            }
        }
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let noteCell = tableView.dequeueReusableCell(withIdentifier: "noteCellID") as! NoteCell
        
        let thisNote: Note!
        thisNote = noteList[indexPath.row]
        noteCell.titleLabel.text = thisNote.title
        noteCell.descLabel.text = thisNote.desc
        
        
        return noteCell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteList.count
    }
    override func viewDidAppear(_ animated: Bool){
        tableView.reloadData()
        
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "EditNote", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "EditNote"){
            let indexPath = tableView.indexPathForSelectedRow!
            let notDetail = segue.destination as? NotDetailVC
            let selectedNote: Note!
            selectedNote  = noteList[indexPath.row]
            notDetail!.selectedNote = selectedNote
            tableView.deselectRow(at: indexPath, animated: true)
            
        }
    }
}
