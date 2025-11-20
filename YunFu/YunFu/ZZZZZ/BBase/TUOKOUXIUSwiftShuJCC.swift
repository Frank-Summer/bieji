
import SQLite3
import Foundation

class TUOKOUXIUSwiftShuJCC: NSObject {
    static let tukou_shuJuDL = TUOKOUXIUSwiftShuJCC()
    
    private var cache: [String: Data] = [:]
    private var db: OpaquePointer?
    private var dbPath: String = ""
    private let dbQueue = DispatchQueue(label: "com.TUOKOUXIUSwiftapp.dbQueue", attributes: [])
    
    private override init() {
        super.init()
        cache = [:]
        if openDatabase() {
            createTableIfNeeded()
        } else {
            print("Failed to dakai database, table creation skipped.")
        }
    }
    deinit {
        tukou_guanBShuJ()
    }
    
    private func openDatabase() -> Bool {
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        dbPath = (docDir as NSString).appendingPathComponent("TUOKOUXIUSwiftData.sqlite")
        
        if sqlite3_open(dbPath, &db) != SQLITE_OK {
            if let db = db {
                print("Failed to dakai database at \(dbPath), error: \(String(cString: sqlite3_errmsg(db)))")
            }
            return false
        }
//        print("Database opened successfully at \(dbPath)")
        return true
    }

    private func createTableIfNeeded() {
        let sql = "CREATE TABLE IF NOT EXISTS Config (key TEXT PRIMARY KEY, value BLOB)"
        var errMsg: UnsafeMutablePointer<Int8>?
        if sqlite3_exec(db, sql, nil, nil, &errMsg) != SQLITE_OK {
            if let err = errMsg {
                print("Failed to create table, error: \(String(cString: err))")
            }
        } else {
//            print("Table 'Config' created or already exists.")
        }
    }
    
    func tukou_guanBShuJ() {
        if db != nil {
            sqlite3_close(db)
            db = nil
        }
    }
    
    func tukou_setArrV(_ value: [Any], forKey key: String) {
        guard let data = try? JSONSerialization.data(withJSONObject: value, options: []) else {
            print("Failed to serialize array to JSON for key \(key)")
            return
        }

        cache[key] = data

        dbQueue.async { [weak self] in
            guard let self = self, let db = self.db else { return }

            let sql = "INSERT OR REPLACE INTO Config (key, value) VALUES (?, ?)"
            var stmt: OpaquePointer?

            if sqlite3_prepare_v2(db, sql, -1, &stmt, nil) != SQLITE_OK {
                print("Failed to prepare statement: \(String(cString: sqlite3_errmsg(db)))")
                return
            }

            let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)

            sqlite3_bind_text(stmt, 1, (key as NSString).utf8String, -1, SQLITE_TRANSIENT)
            sqlite3_bind_blob(stmt, 2, (data as NSData).bytes, Int32(data.count), SQLITE_TRANSIENT)

            if sqlite3_step(stmt) != SQLITE_DONE {
                print("Failed to insert/update key \(key), error: \(String(cString: sqlite3_errmsg(db)))")
            }

            sqlite3_finalize(stmt)
        }
    }
    
    func tukou_getArrKey(_ key: String) -> [Any]? {
        if let data = cache[key] {
            return try? JSONSerialization.jsonObject(with: data, options: []) as? [Any]
        }
        
        var result: [Any]?
        
        dbQueue.sync { [weak self] in
            guard let self = self, let db = self.db else { return }
            
            let sql = "SELECT value FROM Config WHERE key=?"
            var stmt: OpaquePointer?
            
            if sqlite3_prepare_v2(db, sql, -1, &stmt, nil) != SQLITE_OK {
                print("Failed to prepare statement: \(String(cString: sqlite3_errmsg(db)))")
                return
            }
            
            let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
            sqlite3_bind_text(stmt, 1, (key as NSString).utf8String, -1, SQLITE_TRANSIENT)
            
            if sqlite3_step(stmt) == SQLITE_ROW {
                if let blob = sqlite3_column_blob(stmt, 0) {
                    let size = sqlite3_column_bytes(stmt, 0)
                    let data = Data(bytes: blob, count: Int(size))
                    self.cache[key] = data
                    result = try? JSONSerialization.jsonObject(with: data, options: []) as? [Any]
                }
            }
            
            sqlite3_finalize(stmt)
        }
        
        return result
    }
    
    func tukou_delArrK(_ key: String) {
        cache.removeValue(forKey: key)
        
        dbQueue.async { [weak self] in
            guard let self = self, let db = self.db else { return }
            
            let sql = "DELETE FROM Config WHERE key = ?"
            var stmt: OpaquePointer?
            
            if sqlite3_prepare_v2(db, sql, -1, &stmt, nil) != SQLITE_OK {
                print("Failed to prepare delete statement: \(String(cString: sqlite3_errmsg(db)))")
                return
            }
            
            let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
            sqlite3_bind_text(stmt, 1, (key as NSString).utf8String, -1, SQLITE_TRANSIENT)
            
            if sqlite3_step(stmt) != SQLITE_DONE {
                print("Failed to delete key \(key), error: \(String(cString: sqlite3_errmsg(db)))")
            }
            
            sqlite3_finalize(stmt)
        }
    }
    
}
