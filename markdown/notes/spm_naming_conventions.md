## Notes on SPM (SwiftPM) naming conventions
#### 2024-11-01

There are three strings that have implications for users of your swift package:

1. The location of the package, specifically the last path component of your package's URL.
   This is often the repo name, for example `swift-protobuf` in `https://github.com/apple/swift-protobuf`.

2. The name of the package. This is defined in the `name` field of the package's
   Package.swift file. For example, `swift-async-algorithms`
   [here](https://github.com/apple/swift-async-algorithms/blob/main/Package.swift#L6)

3. The product names within the package. This is what the user imports, e.g. `import AsyncAlgorithms`.

   A single package can have multiple product names. For example, when you add the `swift-nio`
   package to your Xcode project, Xcode pops this modal:

   <img src="https://pub-11c8cbbe4738445794179d4e215d89c0.r2.dev/spm_one.png">

   each of these is a product defined [here](https://github.com/apple/swift-nio/blob/main/Package.swift#L59).

Of these, product names have the most consensus on style: they should be PascalCase. Location
and package name do not have an agreed upon style (you'll find many variations by browsing
[a community package list](https://github.com/SwiftPackageIndex/PackageList/blob/main/packages.json)).

Selecting a naming scheme that works for you means understanding where these strings surface to
users.

### Where does the package location appear?

The package location is used in Xcode's `File > Add Package Dependencies` flow in two ways, one
expected and one unexpected.

Users find your package by searching for its full URL. Once found, Xcode uses the *last path
component* as the identifier in the recently used packages view. This is a potential confusion
point for your customers:

<img src="https://pub-11c8cbbe4738445794179d4e215d89c0.r2.dev/spm_two.png">

You can see here that Xcode is identifying this package as 'sdk', even though the name in the
Package.swift file is [OpenMeteoSDK](https://github.com/open-meteo/sdk/blob/main/Package.swift#L6).
Xcode is using the last path component of `https://github.com/open-meteo/sdk` as the identifier.

### Where does the package name appear?

The package name apears in the Xcode project tree (these are *not* the last path component of the
package's location).


<img src="https://pub-11c8cbbe4738445794179d4e215d89c0.r2.dev/spm_three.png">


### Where does the product name appear?

The product name is what your customers import, and is displayed in the `File > Add Package
Dependencies` flow as a list of possible products that your customers can add to their target.


In the image below I'm adding the `BitCollections` product to my `Deleteme` target. I can then
`import BitCollections` in my target's source.

<img src="https://pub-11c8cbbe4738445794179d4e215d89c0.r2.dev/spm_four.png">

Also, if you include your SPM package in another SPM package, the consumer will specify your
product name as follows:

<pre>
let package = Package(
    // ...
    dependencies: [
        .package(url: "https://github.com/apple/swift-async-algorithms", branch: "main")
    ],
    targets: [
        .executableTarget(
            name: "MyApp",
            dependencies: [
                .product(name: "AsyncAlgorithms", package: "swift-async-algorithms")
            ]
        ),
    ]
)
</pre>


#### What does Apple do?

Apple hosts their packages, in most cases, such that the last url component and the package
name match. These identifiers are formed using kebab-case, and start with the `swift-` prefix.
See [the results of this query](https://github.com/orgs/apple/repositories?q=swift-)
for all their packages that fit this format. Looking at `swift-async-algorithms`, one sees that
the last path component matches the [the package name](https://github.com/apple/swift-async-algorithms/blob/main/Package.swift),
while the product name is different: `SwiftAlgorithms`

An exception to this convention is the repo hosted at `apple/swift-protobuf`. In this case, the
last path component is `swift-protobuf`, and the name is `SwiftProtobuf`. The product name
matches the package name, so what users see in the Xcode project tree matches the string that
they import. This, to me, makes a lot of sense.


#### What am I going to do?
I'm going to host my packages with kebab-case last path components, prefixed with `swift`. E.g.
`aiproxypro/swift-aiproxy`. This gives users a clear identifier, `swift-aiproxy`,
in the `Add Package Dependencies` flow.

I'm also going to limit products to one per package, and make the product name and package name
match, both using PascalCase. That way, our customers can guess that the string they see in the
project tree is the string they use in their import statement: `import AIProxy`.

