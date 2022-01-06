//
//  ViewController.swift
//  CodeAPP
//
//  Created by ihlas on 6.01.2022.
//

import UIKit
import CoreData

class NotDetailVC: UIViewController {
    
    @IBOutlet var titleTF: UITextField!
    @IBOutlet var DescTV: UITextView!
    
    var selectedNote: Note? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (selectedNote != nil){
            titleTF.text = selectedNote?.title
            DescTV.text = selectedNote?.title
        }
    }
    
    
    @IBAction func saveAction(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
                if(selectedNote == nil)
                {
                    let entity = NSEntityDescription.entity(forEntityName: "Note", in: context)
                    let newNote = Note(entity: entity!, insertInto: context)
                    newNote.id = noteList.count as NSNumber
                    newNote.title = titleTF.text
                    newNote.desc = DescTV.text
                    do
                    {
                        try context.save()
                        noteList.append(newNote)
                        navigationController?.popViewController(animated: true)
                    }
                    catch
                    {
                        print("context save error")
                    }
                }
                else //edit
                {
                    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
                    do {
                        let results:NSArray = try context.fetch(request) as NSArray
                        for result in results
                        {
                            let note = result as! Note
                            if(note == selectedNote)
                            {
                                note.title = titleTF.text
                                note.desc = DescTV.text
                                try context.save()
                                navigationController?.popViewController(animated: true)
                            }
                        }
                    }
                    catch
                    {
                        print("Fetch Failed")
                    }
                }
            }
    
    @IBAction func DeletedNote(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
                
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
                do {
                    let results:NSArray = try context.fetch(request) as NSArray
                    for result in results
                    {
                        let note = result as! Note
                        if(note == selectedNote)
                        {
                          
                            try context.save()
                            navigationController?.popViewController(animated: true)
                        }
                    }
                }
                catch
                {
                    print("Fetch Failed")
                }
            }
            
        }
