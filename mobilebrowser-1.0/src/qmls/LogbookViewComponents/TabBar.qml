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
* File Name   : TabBar.qml
*
* Created     : 15 June 2011
*
*--------------------------------------------------------
* 1.0 - First open source release
*
*/

import Qt 4.7

import "../common"

// Tabs-Header
BorderImage {
   id: tabBar

   property int selectedTab: 0 // 0 is "bookmarks", 1 is "most visited", 2 is "history"

   source: "qrc:/qmls/pics/bar-bg-10x80.png"
   border.top: 1
   border.bottom: 1
   height: 70

   TopDropShadow {
      width: parent.width
      anchors.bottom: parent.top
      z: 2
   }

   TabButton {
      id: bookmarksTab
      imageSource: "qrc:/qmls/pics/bookmarks-tabicon-30x30.png"
      text: "Bookmarks"
      // Positioning
      anchors.left: parent.left
      width: parent.width/3
      height: parent.height
      selected: selectedTab == 0
      focus: selectedTab == 0

      KeyNavigation.up: bookmarks
      KeyNavigation.left: historyTab
      KeyNavigation.right: mostVisitedTab

      onTabButtonSelected: {
         selectedTab = 0;
         focus = true;
      }
   }

   TabButton {
      id: mostVisitedTab
      imageSource: "qrc:/qmls/pics/mostvisited-tabicon-30x30.png"
      text: "Most visited"
      // Positioning
      anchors.left: bookmarksTab.right
      width: parent.width/3
      height: parent.height
      selected: selectedTab == 1

      KeyNavigation.up: mostVisited
      KeyNavigation.left: bookmarksTab
      KeyNavigation.right: historyTab

      onTabButtonSelected: {
         selectedTab = 1;
         focus = true;
      }
   }

   TabButton {
      id: historyTab
      imageSource: "qrc:/qmls/pics/history-tabicon-30x30.png"
      text: "History"
      // Positioning
      anchors.left: mostVisitedTab.right
      width: parent.width/3
      height: parent.height
      selected: selectedTab == 2

      KeyNavigation.up: history
      KeyNavigation.left: mostVisitedTab
      KeyNavigation.right: bookmarksTab

      onTabButtonSelected: {
         selectedTab = 2;
         focus = true;
      }
   }

   onActiveFocusChanged: {
       if (activeFocus) {
           if (selectedTab == 0) {
               bookmarksTab.forceActiveFocus();
           }
           if (selectedTab == 1) {
               mostVisitedTab.forceActiveFocus();
           }
           if (selectedTab == 2) {
               historyTab.forceActiveFocus();
           }
       }
   }
}
