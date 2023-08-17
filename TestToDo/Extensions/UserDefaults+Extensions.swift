import Foundation

extension UserDefaults {
    func clearAll() {
        for dict in self.dictionaryRepresentation() {
            self.removeObject(forKey: dict.key)
        }
    }
    
    func set(tasks: [TaskItem]) {
        guard let encoded = try? JSONEncoder().encode(tasks) else { return }
        UserDefaults.standard.setValue(encoded, forKey: "tasks")
        UserDefaults.standard.synchronize()
    }
    
    func getTasks() -> [TaskItem] {
        guard let data = UserDefaults.standard.value(forKey: "tasks") as? Data else {
            return []
        }

        do {
            let tasks = try JSONDecoder().decode([TaskItem].self, from: data)
            return tasks
        } catch {
            return []
        }
    }
    
    func deleteItem(at index: Int) {
        var tasks = getTasks()
        guard index >= 0, index < tasks.count else { return }
        tasks.remove(at: index)
        set(tasks: tasks)
    }
}
