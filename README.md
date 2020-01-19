# ImageCacher

ImageCacher is a lightweight framework with the sole purpose of caching images



## Features

- [x] Download an image from a remote server and caches it on disk

- [x] Disk operations are performed in background
- [x] Thread-safe
- [x] Out-of-the-box animations and allows you to create your own
- [x] Unit tested



##Roadmad

Here are more features that would be nice to have were out of the scope of this project

- [ ] Memory Layer using NSCache

- [ ] Expiration policy: Even though at the moment the files are being stored at `Library/Caches` and they will get removed eventually by the OS, would be nice to offer a way of defining the expiration date of a file.

- More customization

  - [ ] Animation duration

  - [ ] Provide custom [Storage](https://github.com/robertofrontado/ImageCacher/blob/master/ImageCacher/Sources/Storage.swift#L15)

  - [ ] Provide custom [Fetcher](https://github.com/robertofrontado/ImageCacher/blob/master/ImageCacher/Sources/Fetcher.swift#L11)

    

## Considerations

- DiskStorage stores the images in `Library/Caches` which gets clean up automatically when the OS needs to free up some space.

- The [Storage]() protocol allows you to create a custom storage mechanism, like a memory layer (but it was outside of the scope of this project).

- ObjectAssociation from Objc: I used this to be able to cancel previous requests.

  

## Getting Started

####Installation

Cocoapods * - Coming soon*

Carthage *- Coming soon*

PackageManager *- Coming soon*

####Usage

```swift
imageView.imgc_loadImage(from: url, placeholder: placeholder)
```

For more information please check [imgc_loadImage(from:placeholder:animation:completion)](https://github.com/robertofrontado/ImageCacher/blob/develop/ImageCacher/Sources/UIImageView%2BImageCacher.swift#L27)



## SampleApp

You can always check the [SampleApp]() to see how to integrate ImageCacher with your application.



SampleApp is divided in 2 layers, data and presentation

#### Data

This module is called data because its sole purpose is to manage data.

This layer consists on:

- [Foundation](): base classes that are going to be used in modules
- [Modules]()
  - API Targets: used to define every endpoint
  - Repositories: used to comunicate with the api and parse the response into an object (typesafe)

####Presentation

This is where all the UI logic is placed. It was implemented by using MVVM.

This layer consists on:

- [Foundation](): base classes that are going to be used in modules
- [Modules]()
  - ViewController: in charge of the UI.
  - ViewModel: business logic (Mainly fetches data from the repositories and notifies to whatever is listening about the changes in the data).



## Author

This framework was developed by Robeto Frontado.

For more information you can check his [GitHub](https://github.com/robertofrontado) or [LinkedIn](https://www.linkedin.com/in/robertofrontado/)