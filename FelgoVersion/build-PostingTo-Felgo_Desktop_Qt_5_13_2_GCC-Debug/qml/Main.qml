import Felgo 3.0
import QtQuick 2.0

import "pages"

App {
    id: root

    Loader {
        id: pageloader
        sourceComponent: loginP
    }

    Navigation {

        NavigationItem {

        }

        NavigationItem {

        }
    }

    /* pages Component */
    Component {id: loginP; LoginPage{} }
    Component {id: mainP; MainPage{} }
    Component {id: chatP; ChatPage{} }


}
