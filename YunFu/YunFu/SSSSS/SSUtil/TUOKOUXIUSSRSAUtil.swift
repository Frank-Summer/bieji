
import Foundation


class TUOKOUXIUSSRSAUtil: NSObject {
    static func tukou_encWithRSA(_ rsaKey: UnsafeMutablePointer<RSA>?,
                                            plainData: Data,
                                        isPublicKey: Bool) -> Data? {
        guard let rsaKey = rsaKey else {
            print("RSA key is NULL")
            return nil
        }
        let rsaLen = Int(RSA_size(rsaKey))
        let blockSize = rsaLen - 11
        let totalLength = plainData.count
        let blockCount = Int(ceil(Double(totalLength) / Double(blockSize)))
        
        var resultData = Data()

        for i in 0..<blockCount {
            let offset = i * blockSize
            let segmentSize = min(blockSize, totalLength - offset)
            let range = offset..<(offset + segmentSize)
            let segment = plainData.subdata(in: range)

            var encrypted = [UInt8](repeating: 0, count: rsaLen)
            let input = [UInt8](segment)

            let encLen: Int32
            if isPublicKey {
                encLen = RSA_public_encrypt(Int32(segmentSize), input, &encrypted, rsaKey, RSA_PKCS1_PADDING)
            } else {
                encLen = RSA_private_encrypt(Int32(segmentSize), input, &encrypted, rsaKey, RSA_PKCS1_PADDING)
            }

            if encLen >= 0 {
                resultData.append(encrypted, count: Int(encLen))
            } else {
                print("Encryption failed at block \(i)")
                return nil
            }
        }

        return resultData
    }
    static func tukou_decWithRSA(_ rsaKey: UnsafeMutablePointer<RSA>?,
                                            cipherData: Data,
                                            isPublicKey: Bool) -> Data? {
        guard let rsaKey = rsaKey else { return nil }

        let rsaLen = Int(RSA_size(rsaKey))
        let totalLength = cipherData.count
        let blockSize = rsaLen
        let blockCount = Int(ceil(Double(totalLength) / Double(blockSize)))

        var resultData = Data()

        for i in 0..<blockCount {
            let offset = i * blockSize
            let segmentSize = min(blockSize, totalLength - offset)
            let range = offset..<(offset + segmentSize)
            let segment = cipherData.subdata(in: range)

            var decrypted = [UInt8](repeating: 0, count: rsaLen)
            let input = [UInt8](segment)

            let decLen: Int32
            if isPublicKey {
                decLen = RSA_public_decrypt(Int32(segmentSize), input, &decrypted, rsaKey, RSA_PKCS1_PADDING)
            } else {
                decLen = RSA_private_decrypt(Int32(segmentSize), input, &decrypted, rsaKey, RSA_PKCS1_PADDING)
            }

            if decLen >= 0 {
                resultData.append(decrypted, count: Int(decLen))
            }
        }
        return resultData
    }
}
