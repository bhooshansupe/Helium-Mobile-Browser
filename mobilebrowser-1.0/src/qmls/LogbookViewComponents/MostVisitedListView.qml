/*--------------------------------------------------------
* Module Name : Helium Mobile Browser
* Version : 1.0
*
* Software Name : Helium Mobile Browser
* Version : 1.0
*
* Copyright (c) 2010 - 2011 France Telecom
* This software is distributed under the LGPL v2.1 license,
* the text of which is available at http://www.gnu.org/licenses/lgpl-2.1.html
* or see the "LICENSE.txt" file for more details.
*
*--------------------------------------------------------
* File Name   : MostVisitedListView.qml
*
* Created     : 15 June 2011
*
*--------------------------------------------------------
* 1.0 - First open source release
*
*/

import Qt 4.7

import "../common"

LogbookListView {
   delegate: delegateComponent

   // Define a delegate component.  A component will be
   // instantiated for each visible item in the list.
   Component {
      id: delegateComponent

      Rectangle {
         id: delegateUi
         width: (parent) ? parent.width : 800
         height: 70
         color: "#fff"

         property color focusColor: "orange"
         property int focusBorderWidth: 3
         property color focusBorderColor: "blue"

         BorderImage {
            source: "qrc:/qmls/pics/url-list-bg-10x60.png"
            border.top: 1
            anchors.fill: parent
         }

         Rectangle {
            id: delegateIcon
            height: parent.height-10
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.margins: 2
            width: height

            color: "#ddd"
            radius: 5

            Image {
               id: bookmarkIcon
               anchors.centerIn: parent
               width: 30
               height: 30
               smooth: true; asynchronous: true;
               source: "image://favicons/"+model.url
            }

            Image {
               id: isHomeIcon
               source: "qrc:/qmls/pics/home-icon-32x32.png"
               opacity: model.isHome ? 1 : 0
               anchors.top: parent.top
               anchors.topMargin: -3
               anchors.right: parent.right
               anchors.rightMargin: -3
               width: 25
               height: 25
               smooth: true
               z: 4
            }
         }

         Column {
            anchors.left: delegateIcon.right
            anchors.leftMargin: 3
            anchors.right: lastVisitTime.left
            anchors.rightMargin: 3
            anchors.verticalCenter: parent.verticalCenter
            Text {
               id: delegateTitle
               font.pointSize: 16
               font.bold: true
               color: "#000000"
               text: model.title
               elide: Text.ElideRight
               width: parent.width
            }
            Text {
               id: delegateUrl
               text: model.url
               font.pointSize: 14
               color: "#555555"
               elide: Text.ElideRight
               width: parent.width
            }
         }

         Column {
            id: lastVisitTime
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: 2
            Text {
               text: Qt.formatDateTime(model.lastVisit, "ddd d MMM yyyy")
               font.pointSize: 10; color: "#aaa";
            }
            Text {
               width: parent.width
               text: Qt.formatDateTime(model.lastVisit, "hh:mm:ss")
               font.pointSize: 10; color: "#aaa";
               horizontalAlignment: Text.AlignRight
            }
         }

         Rectangle {
            id: delegateUiHover
            opacity: 0
            anchors.fill: parent
            color: "#FF6600"
         }

         Rectangle {
            id: focuseRect
            anchors.fill: parent;
            anchors.margins: 3
            color: parent.focusColor
            border.color: parent.focusBorderColor
            border.width: parent.focusBorderWidth
            radius: 5
            opacity: 0
         }

         onActiveFocusChanged: {
             if (activeFocus) {
                 focuseRect.opacity = 0.2;
             } else {
                 focuseRect.opacity = 0;
             }
         }

         Keys.onSpacePressed: {
             if ( appcore ) {
                 appcore.currentUrl = model.url;
             }
         }

         MouseArea {
            anchors.fill: parent
            onPressed: { delegateUiHover.opacity = 0.4; }
            onClicked: { parent.forceActiveFocus(); }
            onReleased: { if ( appcore ) { appcore.currentUrl = model.url; } delegateUiHover.opacity = 0; }
            onExited: { delegateUiHover.opacity = 0; }
         }
      }
   }
}
