# Live Broadcast

Live Broadcast with Agora.io

## Requirements
* iOS 12+
* Xcode 12+
* Swift 5.3+

## Installation Live Stream

Implement http://agora.io by adding AgoraRtcKit, AgoraRtmKit, AgoraUIKit_iOS, AgoraVideoSwiftUI

### SPM
If you didn't find any of these kit in project please download package through `Package.swift`.
```swift
dependencies: [
    .package(url: "https://github.com/AgoraIO/AgoraRtcEngine_iOS")
]
```

## Usage

### UIKit
Adding functionality in `AgoraVideoCanvasView.swift` using `AgoraVideoCanvasView`.

### SwiftUI
To present `AgoraVideoCanvasView` on SwiftUI, you need to call a `AgoraUIKit` representable. Check [https://github.com/baquer/Agora-SwiftUI] out for details.


#### Manage UI 
 1. Did some changes in UI as for sutable for Agora
 
 
<!--## What's next-->
<!--- [x] Sample Project.-->
<!--- [x] SwiftUI representable code example. -->
<!--- [x] Support below iOS 13.-->
  
---

## Live Stream
- [x] Implementation http://agora.io
- [x] Changes in Design Code 
<!--Developed with 🖤 at [Kuldip]-->

##  (4-Apr)
- [x] Before going live Host have to set title and topic  
- [x] While toggle camera resolve crash
- [x] Add all selected icons in View like (flash, flip, timer, etc) 
- [x] Resolve Font issues in all app 
- [x] Redesign Comment text box and manage Comment box on keyboard
- [x] Add imoji icon where user can open keyboard to direct send imoji
- [x] The content "go live to followers" set to be white 

## end of 4th apr

## (12th Apr)

### Bug Fixed

- [x] User can now save title on tapping screen
- [x] limit added in choosing topic to 3
- [x] Used the attached camera flip button from figma 
- [x] Share by sms, whatsapp etc added
- [x] Keyword filter button added when you click on settings save and cancel buttons
- [x] Q&A added in LiveStreamingView and notification icon will add when value implemented

## New Work
- [x] Developed Api for title, topics, settings sent you zip file please upload it.

### 1. `Example.com/api/v1/setting` (Setting api)
=>Response {
    "comment":"EDee",
    "liveGift":true,
    "keyword":["12121"],
    "email":"dkmen@gmail.com"
}

### 2. `Example.com/api/v1/store` (go live with api)
=> Response {
    "title":"EDee",
    "goLive":true,
    "topic":["12121"],
    "email":"dkmen@gmail.com"
}


- [x] Manage design of `LiveViewersView.swift`
- [x] Agora 1 to 1 call now working, for testing you can "go live" from App then come here `https://webdemo.agora.io/basicVideoCall/index.html` and put
AppID = `3a654ca59f8a438c83d3600168ea6aa8`
Token = `007eJxTYBBvluEP1okTnHKtoDMnK9Hrv2DgjwkntR+WTtDQTDbIs1JgME40MzVJTjS1TLNINDG2SLYwTjE2MzAwNLNITTRLTLToLTRNaQhkZMiNkGdiZIBAEJ+VIS8ktbiEgQEAXBQb8g==`
ChannelName = "nTest"

## end of 12th Apr
