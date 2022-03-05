# flutter_unity

dependencies {
   // implementation project(':unityLibrary')
   // implementation(name: 'unity-classes', ext:'jar')

    implementation project(':UnityExport')
    //Remember to add unity jar from unity export as a module dependency and add the module below
    implementation project(':unity-classes')

...
}
