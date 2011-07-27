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
* File Name   : EmbossedButton.qml
*
* Created     : 15 June 2011
*
*--------------------------------------------------------
* 1.0 - First open source release
*
*/

import Qt 4.7

Rectangle {
   id: embossedButton

   property color focusColor: "orange"
   property int focusBorderWidth: 3
   property color focusBorderColor: "blue"
   property string text: "undefined"
   property int fontPointSize: 14
   property bool pressed: false
   property color baseColor: "#22A"
   color: "transparent"

   signal clicked()

   state: "normal"
   radius: 5

   BorderImage {
      source: "qrc:/qmls/pics/embossed-button-overlay-62x62.png"
      border.left: 6
      border.right: 6
      border.top: 6
      border.bottom: 6
      smooth: true

      anchors.fill: parent
      anchors.margins: -1
   }
   Text {
      text: parent.text
      color: "white"
      styleColor: "black"
      style: Text.Sunken

      font.family: "Helvetica"
      font.pointSize: parent.fontPointSize
      font.bold: true
      anchors.centerIn: parent
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
       embossedButton.clicked();
   }

   MouseArea {
      anchors.fill: parent
      onPressed: { parent.pressed = true; }
      onReleased: { parent.pressed = false; }
      onClicked: {
          parent.forceActiveFocus();
          parent.clicked();
      }
   }

   states: [
   State {
      name: "pressed"
      when: embossedButton.pressed
      PropertyChanges { target: embossedButton; color: Qt.darker(embossedButton.baseColor); }
   },
   State {
      name: "normal"
      when: !embossedButton.pressed
      PropertyChanges { target: embossedButton; color: embossedButton.baseColor; }
   }
   ]
}
