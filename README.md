# flutter_unity

Essa descrição abaixo é no build.grade que vai dentro do plugin

dependencies {
   // implementation project(':unityLibrary')
   // implementation(name: 'unity-classes', ext:'jar')

    implementation project(':UnityExport')
    //Remember to add unity jar from unity export as a module dependency and add the module below
    implementation project(':unity-classes')

...
}

------


Link do video tutorial
https://www.youtube.com/watch?v=REeJmCNTfMc

Baixe o plugin e o exemplo pelo plugin oficial la tem um demo dentro da pasta exemple
https://pub.dev/packages/flutter_unity_widget

Para mim a versão que deu certo é flutter_unity_widget: 4.1.0 
e Usei o Unity 2019.4.34
