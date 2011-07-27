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
* File Name   : BarIcon.qml
*
* Created     : 15 June 2011
*
*--------------------------------------------------------
* 1.0 - First open source release
*
*/

import Qt 4.7

Item {
   id: barIcon

   property string source: ""
   property color highlightColor: "#fff"
   property int hightlightBorderWidth: 0
   property color highlightBorderColor: "#fff"
   property color focusColor: "orange"
   property int focusBorderWidth: 3
   property color focusBorderColor: "blue"
   property int badgeValue: 0
   property color badgeColor: "red"

   signal clicked()

   opacity: enabled ? 1 : 0.2

   Image {
      anchors.centerIn: parent
      width: parent.height-30; height: parent.height-30; smooth: true;
      source: parent.source
      z: 2

      Rectangle {
         id: badge
         enabled: barIcon.badgeValue > 0
         opacity: (barIcon.badgeValue > 0) ? 1 : 0
         anchors.horizontalCenter: parent.right
         anchors.verticalCenter: parent.top
         gradient: Gradient {
            GradientStop { color: barIcon.badgeColor; position: 0;}
            GradientStop { color: Qt.darker(barIcon.badgeColor); position: 1; }
         }
         width: 20; height: 20;
         radius: 10;
         Text {
            id: badgeText
            text: (barIcon.badgeValue > 9) ? " + " : barIcon.badgeValue;
            anchors.centerIn: parent; color: "white";
            font.bold: true; font.pointSize: 12;
         }
//         effect: DropShadow { blurRadius: 20; offset.x: 0; offset.y: 0; }
      }
   }

   Rectangle {
      id: highlight
      anchors.fill: parent;
      anchors.margins: 3
      color: parent.highlightColor
      border.color: parent.highlightBorderColor
      border.width: parent.hightlightBorderWidth
      radius: 5
      opacity: 0
      z: 1
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
      z: 1
   }

   onActiveFocusChanged: {
       if (activeFocus) {
           focuseRect.opacity = 0.2;
       } else {
           focuseRect.opacity = 0;
       }
   }

   Keys.onSpacePressed: {
       if (barIcon.enabled) {
           barIcon.clicked();
       }
   }

   MouseArea {
       id: pressMouseArea;
       anchors.fill: parent;
       onClicked: {
           if (parent.enabled) {
               parent.forceActiveFocus();
               parent.clicked();
           }
       }
   }

   states: [
   State {
      name: "normal"; when: barIcon.enabled && !pressMouseArea.pressed;
      PropertyChanges { target: highlight; opacity: 0; }
   },
   State {
      name: "pressed"; when: barIcon.enabled && pressMouseArea.pressed;
      PropertyChanges { target: highlight; opacity: 0.2; }
   }
   ]
}
