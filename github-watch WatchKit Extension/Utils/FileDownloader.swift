import Foundation

/// Taken from https://stackoverflow.com/a/56580009
/// Authors: https://stackoverflow.com/users/10422074/endless and https://stackoverflow.com/users/6479704/bijender-singh-shekhawat
class FileDownloader
{
    static func loadFileSync(url: URL, completion: @escaping (String?, Error?) -> Void)
    {
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let destinationUrl = documentsUrl.appendingPathComponent(url.lastPathComponent)
        
        if FileManager().fileExists(atPath: destinationUrl.path)
        {
            print("File already exists [\(destinationUrl.path)]")
            completion(destinationUrl.path, nil)
        }
        else if let dataFromURL = NSData(contentsOf: url)
        {
            if dataFromURL.write(to: destinationUrl, atomically: true)
            {
                print("file saved [\(destinationUrl.path)]")
                completion(destinationUrl.path, nil)
            }
            else
            {
                print("error saving file")
                let error = NSError(domain: "Error saving file", code: 1001, userInfo: nil)
                completion(destinationUrl.path, error)
            }
        }
        else
        {
            let error = NSError(domain: "Error downloading file", code: 1002, userInfo: nil)
            completion(destinationUrl.path, error)
        }
    }
    
    static func loadFileAsync(url: URL, completion: @escaping (String?, Error?) -> Void)
    {
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let destinationUrl = documentsUrl.appendingPathComponent("\(Int.random(in: 0 ... Int.max))_" + url.lastPathComponent)
        
        if FileManager().fileExists(atPath: destinationUrl.path)
        {
            print("File already exists [\(destinationUrl.path)]")
            completion(destinationUrl.path, nil)
        }
        else
        {
            let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            let task = session.dataTask(with: request, completionHandler:
                {
                    data, response, error in
                    if error == nil
                    {
                        if let response = response as? HTTPURLResponse
                        {
                            if response.statusCode == 200
                            {
                                if let data = data
                                {
                                    if let _ = try? data.write(to: destinationUrl, options: Data.WritingOptions.atomic)
                                    {
                                        completion(destinationUrl.path, error)
                                    }
                                    else
                                    {
                                        completion(destinationUrl.path, error)
                                    }
                                }
                                else
                                {
                                    completion(destinationUrl.path, error)
                                }
                            }
                            else
                            {
                                completion(destinationUrl.path, "\(response.statusCode)")
                            }
                        }
                    }
                    else
                    {
                        completion(destinationUrl.path, error)
                    }
                })
            task.resume()
        }
    }
}
