# weather_app

A useful project to learn how to develop basic UI in flutter.
Easy to understand if your have dart concepts especially in classes and constructors.

## Getting Started

1. I just have an appBar that has a title which is centered and an iconButton which is an actions property of AppBar().
2. Next I just have a body property of scaffold and in there I have a column widget since everything is stacked on top of each other.
3. The first component is a card with a blur effect and an elevation to make it look nice.
4. For the weather forecast cards, I have created a separate folder and re-used the card widget to reduce amount of code in my main file.
5. The same goes for additional information which is not an iteration of cards

## You're new to flutter ?

Don't worry at this point I am also learning how flutter works.
Resources that I have found useful -[video: Video tutorial for project](https://www.youtube.com/watch?v=BiOSCpV-lts&list=PLrNZoM9ig7xg0gfndzZkAE8ywefLcTj3r&index=14)

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Data Fetching

1. Visit the -[flutter packaged](pub.dev) website and look for http.
2. Add the version you copied to the dependencies in pubspec.yaml file
3. Got to the main weather file and create a function to fetch data
4. Make sure to have the latest version of dart installed
5. Create an account on open weather website and wait for them to give you a key via email
6. use Listview.builder to build your UI on the weather forecast it allows lazy loading and hence better performance
7. In order to correctly handle the date to a readable format. we are using a package from pub.dev calles [intl](https://pub.dev/packages/intl)
