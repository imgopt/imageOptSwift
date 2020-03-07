# imageOptClient - Swift
imageOpt client library for iOS, to construct parameterized imageOpt url from plain imageSet URL created at [Image CDN][1]

For more information please see [Image CDN][1]

## Installation with CocoaPods

[CocoaPods](http://cocoapods.org/) is a dependency manager for Objective-C and Swift, which automates and simplifies the process of using 3rd-party libraries in your projects. See the [Get Started](http://cocoapods.org/#get_started) section for more details.

#### Podfile
```
pod 'imageOptClient'
```

## Documentation
### constructURL with imageView
```
func constructURL(imageURL:String, imageView:UIImageView, crop:Bool,
                  completionHandler: @escaping (_ imageOptURL: URL?) -> Void)
```                           
Function to construct an imageOpt URL with query parameters, given an imageSet URL created at [Image CDN][1] and an imageView. This function waits for imageView size to be finalized, then constructs parameterized imageOpt URL using the given imageSet URL, imageView Size & crop preference and finally calls completionHandler with that URL.

USE THIS FUNCTION WHEN SIZE IS NOT KNOWN/FINALIZED AT THE TIME OF CALLING.


```
/* Parameters:
 *   imageURL : specifies the url of the imageSet to be loaded
 *   imageView : specifies the image view into which the image will loaded/displayed
 *   crop : whether or not, the image can be cropped if needed to match the requested size
 *   completionHandler: completion block will be called with parameterized imageOpt url
 */
```
### constructURL with imageView and current system locale/language
```
func constructURL(imageURL:String, imageView:UIImageView, 
                  crop:Bool, useSystemLocale:Bool,
                  completionHandler: @escaping (_ imageOptURL: URL?) -> Void)
```                           
Function to construct an imageOpt URL with query parameters, given an imageSet URL created at [Image CDN][1] and an imageView. This function waits for imageView size to be finalized, then constructs parameterized imageOpt URL using the given imageSet URL, imageView Size, crop preference & current locale/language of the device and finally calls completionHandler with that URL.

USE THIS FUNCTION WHEN SIZE IS NOT KNOWN/FINALIZED AT THE TIME OF CALLING.


```
/* Parameters:
 *   imageURL : specifies the url of the imageSet to be loaded
 *   imageView : specifies the image view into which the image will loaded/displayed
 *   crop : whether or not, the image can be cropped if needed to match the requested size
 *   useSystemLocale: specifies that system locale/language to be used
 *   completionHandler: completion block will be called with parameterized imageOpt url
 */
```
### constructURL with imageView and explicit locale parameter
```
func constructURL(imageURL:String, imageView:UIImageView, 
                  crop:Bool, locale:Locale,
                  completionHandler: @escaping (_ imageOptURL: URL?) -> Void)
```                           
Function to construct an imageOpt URL with query parameters, given an imageSet URL created at [Image CDN][1], an imageView and locale. This function waits for imageView size to be finalized, then constructs parameterized imageOpt URL using the given imageSet URL, imageView Size, crop preference & locale preference and finally calls completionHandler with that URL.

USE THIS FUNCTION WHEN SIZE IS NOT KNOWN/FINALIZED AT THE TIME OF CALLING.


```
/* Parameters:
 *   imageURL : specifies the url of the imageSet to be loaded
 *   imageView : specifies the image view into which the image will loaded/displayed
 *   crop : whether or not, the image can be cropped if needed to match the requested size
 *   locale : specifies the preferred language of the image
 *   completionHandler: completion block will be called with parameterized imageOpt url
 */
```
### constructURL with imageSize
```
func constructURL(imageURL:String, imageSize:CGSize, crop:Bool ) -> URL?
```
Function to construct an imageOpt URL with query parameters, given an imageSet URL created at [Image CDN][1] and imageSize. This function constructs and returns parameterized imageOpt URL using the given imageSet URL, imageSize and crop preference.

USE THIS FUNCTION WHEN SIZE IS KNOWN/FINALIZED AT THE TIME OF CALLING.

```
/* Parameters:
 *   imageURL : specifies the url of the imageSet to be loaded
 *   imageSize : specifies the image size to be loaded/displayed
 *   crop : whether or not, the image can be cropped if needed to match the requested size
 *
 * Returns:
 *   imageOptURL : imageOpt url with query parameters, it can be used to fetch the required image
 */
```
### constructURL with imageSize and current system locale/language
```
func constructURL(imageURL:String, imageSize:CGSize, 
                       crop:Bool, useSystemLocale:Bool) -> URL?
```
Function to construct an imageOpt URL with query parameters, given an imageSet URL created at [Image CDN][1] and imageSize. This function constructs and returns parameterized imageOpt URL using the given imageSet URL, imageSize, crop preference and current locale/language of the device.

USE THIS FUNCTION WHEN SIZE IS KNOWN/FINALIZED AT THE TIME OF CALLING.

```
/* Parameters:
 *   imageURL : specifies the url of the imageSet to be loaded
 *   imageSize : specifies the image size to be loaded/displayed
 *   crop : whether or not, the image can be cropped if needed to match the requested size
 *   useSystemLocale: specifies that system locale/language to be used
 *
 * Returns:
 *   imageOptURL : imageOpt url with query parameters, it can be used to fetch the required image
 */
```
### constructURL with imageSize and explicit locale parameter
```
func constructURL(imageURL:String, imageSize:CGSize, 
                       crop:Bool, locale:Locale) -> URL?
```
Function to construct an imageOpt URL with query parameters, given an imageSet URL created at [Image CDN][1], imageSize and locale. This function constructs and returns parameterized imageOpt URL using the given imageSet URL, imageSize, crop preference and locale preference.

USE THIS FUNCTION WHEN SIZE IS KNOWN/FINALIZED AT THE TIME OF CALLING.

```
/* Parameters:
 *   imageURL : specifies the url of the imageSet to be loaded
 *   imageSize : specifies the image size to be loaded/displayed
 *   crop : whether or not, the image can be cropped if needed to match the requested size
 *   locale : specifies the preferred language of the image
 *
 * Returns:
 *   imageOptURL : imageOpt url with query parameters, it can be used to fetch the required image
 */
```

## Usage - Swift

First add the import statement
```
import imageOptClient
```

A. Lets say you want to load an image inside custom UITableViewCell named CustomTableViewCell, this custom cell has an IBOutlet named customImageView, its final size is known only after the view is layed out.

```
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath as IndexPath) as! CustomTableViewCell

    //Assuming the presence of array named imageList with cell data about each image item
    if let cellData = imageList[indexPath.row] {

        ...

        //Assuming cellData has a parameter named imageURL which has the url of the image to be loaded in the cell
        if let imageURL = cellData["imageURL"] as? String {

            //Construct a imageOpt URL using the customImageView, since this is a table view we will prefer to crop the image
            imageOptClient.constructURL(imageURL: imageURL, imageView: cell.customImageView,
                                          crop: true, completionHandler: { imageOptURL in

    	        // Here we use SDWebImage to fetch, you can use any method of your choice,
    	        // just make sure standard cache control is enabled
                cell.customImageView.sd_setImage(with: imageOptURL, placeholderImage:UIImage(named: "placeholder"),
                                              options: .refreshCached, completed: nil)
            })
        }
    }
    return cell
}
```

B. Lets say you have a normal View Controller (not Collection/Table viewController), you also have an IBOutlet imageView and want to load an image into it

```
override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    // Use the URL of imageSet obtained from imageOpt.com, this can be directly used or fetched from backend server
    let imageURLString = "https://p1.imageopt.net/9zt-ct/q"

    // Get the imageOpt url with query parameters to be used to fetch the image
    // Lets say this is a details type of view, so we will prefer not to crop the image, hence set crop to false
    let imageOptURL = imageOptClient.constructURL(imageURL: imageURLString, imageSize: imageView.frame.size, crop: false)

    // Here we use SDWebImage to fetch, you can use any method of your choice,
    // just make sure standard cache control is enabled
    imageView.sd_setImage(with: imageOptURL, placeholderImage:UIImage(named: "placeholder"),
                       options: .refreshCached, completed: nil)
}        
```

C. Lets say you want to load an image inside UITableViewCell, image size is fixed and we want to load the image corresponding to system language.
```
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath as IndexPath) as! CustomTableViewCell

    //Assuming the presence of array named imageList with cell data about each image item
    if let cellData = imageList[indexPath.row] {

        ...

        //Assuming cellData has a parameter named imageURL which has the url of the image to be loaded in the cell
        if let imageURL = cellData["imageURL"] as? String {

            //Construct a imageOpt URL using the customImageView, since this is a table view we will prefer to crop the image
            let imageOptURL = imageOptClient.constructURL(imageURL: imageURLString, 
                         imageSize: CGSize(width: 200,height: 200), crop: true,
                         useSystemLocale: true)

            // Here we use SDWebImage to fetch, you can use any method of your choice,
            // just make sure standard cache control is enabled
            cell.imageView.sd_setImage(with: imageOptURL, placeholderImage:UIImage(named: "placeholder"),
                         options: .refreshCached, completed: nil)
        }
    }
    return cell
}
```

D. Lets say you have a normal View Controller (not Collection/Table viewController), you also have an IBOutlet imageView and want to load an image of specific language from viewDidLoad method

```
override func viewDidLoad() {
    super.viewDidLoad()

    // Use the URL of imageSet obtained from imageOpt.com, this can be directly used or fetched from backend server
    let imageURLString = "https://p1.imageopt.net/9zt-ct/q"

    // Create an instance of Locale and intialize it to say french language
    let locale = Locale(identifier: "fr")

    // Get the imageOpt url with query parameters to be used to fetch the image
    // Lets say this is a details type of view, so we will prefer not to crop the image, hence set crop to false
    imageOptClient.constructURL(imageURL: imageURL, imageView: self.imageView,
                                crop: false, locale: locale,
                                completionHandler: { imageOptURL in

    	 // Here we use SDWebImage to fetch, you can use any method of your choice,
    	 // just make sure standard cache control is enabled
         self.imageView.sd_setImage(with: imageOptURL, placeholderImage:UIImage(named: "placeholder"),
                                              options: .refreshCached, completed: nil)
    })
}
```


## Usage - ObjectiveC

First add the import statement
```
#import <imageOptClient-Swift.h>
```

A. Lets say you want to load an image inside custom UITableViewCell named CustomTableViewCell, this custom cell has an IBOutlet named customImageView, its final size is known only after the view is layed out.

```
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *tableIdentifier = @"MyTableCell";
    CustomTableViewCell *cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:tableIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = (CustomTableViewCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }

    //Assuming the presence of an array named imageURLList with imageOpt URL for each item
    NSString* imageURL = imageURLList[indexPath.row];

    //Construct a imageOpt URL using the customImageView, since this is a table view we will prefer to crop the image
    [imageOptClient constructURLWithImageURL:imageURL imageView:cell.customImageView crop:true 
        completionHandler: ^(NSURL* imageOptURL) {
    	        // Here we use SDWebImage to fetch, you can use any method of your choice,
    	        // just make sure standard cache control is enabled
              [cell.customImageView sd_setImageWithURL:imageOptURL
                                    placeholderImage:[UIImage imageNamed:@"placeholder.png"] 
                                    options:SDWebImageRefreshCached completed: nil];
    }];
    
    return cell;
}

```

B. Lets say you have a normal View Controller (not Collection/Table viewController), you also have an IBOutlet imageView and want to load an image into it

```
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    // Use the URL of imageSet obtained from imageOpt.com, this can be directly used or fetched from backend server
    NSString *imageURLString = @"https://p1.imageopt.net/9zt-ct/q";

    // Get the imageOpt url with query parameters to be used to fetch the image
    // Lets say this is a details type of view, so we will prefer not to crop the image, hence set crop to false
    NSURL *imageOptURL = [imageOptClient constructURLWithImageURL:imageURLString 
                                                        imageSize:self.imageView.frame.size crop:false];

    // Here we use SDWebImage to fetch, you can use any method of your choice,
    // just make sure standard cache control is enabled
    [self.imageView sd_setImageWithURL:imageOptURL 
                      placeholderImage:[UIImage imageNamed:@"placeholder.png"] 
                      options:SDWebImageRefreshCached completed: nil];

}
```

C. Lets say you want to load an image inside UITableViewCell, image size is fixed and we want to load the image corresponding to system language.

```
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *tableIdentifier = @"MyTableCell";
    CustomTableViewCell *cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:tableIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = (CustomTableViewCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }

    //Assuming the presence of an array named imageURLList with imageOpt URL for each item
    NSString* imageURL = imageURLList[indexPath.row];

    //Construct a imageOpt URL using fixed size 100x100, since this is a table view we will prefer to crop the image
    NSURL *imageOptURL = [imageOptClient constructURLWithImageURL:imageURLString 
                             imageSize:CGSizeMake(100, 100) crop:true, useSystemLocale:true];

    [cell.imageView sd_setImageWithURL:imageOptURL
                               placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                               options:SDWebImageRefreshCached completed: nil];

    return cell;
}
```

D. Lets say you have a normal View Controller (not Collection/Table viewController), you also have an IBOutlet imageView and want to load an image of specific language from viewDidLoad method

```
- (void)viewDidLoad {
    [super viewDidLoad];

    // Use the URL of imageSet obtained from imageOpt.com, this can be directly used or fetched from backend server
    NSString *imageURLString = @"https://p1.imageopt.net/9zt-ct/q";

    // Create an instance of NSLocale and intialize it to say french language
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"fr"];

    // Get the imageOpt url with query parameters to be used to fetch the image
    // Lets say this is a details type of view, so we will prefer not to crop the image, hence set crop to false
    [imageOptClient constructURLWithImageURL:imageURL imageView:self.imageView
                    crop:false locale:locale
        completionHandler: ^(NSURL* imageOptURL) {
    	        // Here we use SDWebImage to fetch, you can use any method of your choice,
    	        // just make sure standard cache control is enabled
              [self.imageView sd_setImageWithURL:imageOptURL
                                    placeholderImage:[UIImage imageNamed:@"placeholder.png"] 
                                    options:SDWebImageRefreshCached completed: nil];
    }];
}
```


License
--------

Copyright (c) 2019-20 imageOpt

Available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

 [1]: https://imageopt.com
