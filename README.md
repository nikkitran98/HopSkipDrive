# HopSkipDrive

**HopSkipDrive** is a rider-sharing app for students. Drivers can view upcoming trips and trip details.


<img width="453" alt="Screenshot 2024-02-05 at 1 36 32 PM" src="https://github.com/nikkitran98/HopSkipDrive/assets/15794929/5161f333-299b-419b-87d5-8866f0993980">
<img width="453" alt="Screenshot 2024-02-05 at 1 36 37 PM" src="https://github.com/nikkitran98/HopSkipDrive/assets/15794929/60dd5a6f-3599-438f-9bb9-e14b7509baf1">
<img width="453" alt="Screenshot 2024-02-05 at 1 36 40 PM" src="https://github.com/nikkitran98/HopSkipDrive/assets/15794929/1138ba68-b521-4cd6-a1a3-a4f62cd6aaed">


![HopSkipDrive](https://github.com/nikkitran98/HopSkipDrive/assets/15794929/c2b678c9-c3a9-4ddf-b150-8aa30c0de46a)

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Features
The following **required** functionality is completed:
- [x] The app shows a rides screen with trip header and trip card
- [x] The app shows a ride details screen with a map, repeating series status, address list and trip status
- [x] Upon pressing the cancel button in the ride details screen, a configurable confirmation alert is shown to the user

## Credits

- [MapKit](https://developer.apple.com/documentation/mapkit/) - Applie's map framework

## Notes/Areas of Improvement
If given additional time, I would create more reusable components such as UILabels that were often reused through out the app. I'd also utilize lazy vars in the scenario where we have variables that we only compute them when they are needed. I'd also make the models be decodable and convert from json formatting to Apple's camelCase formatting. Lastly, I'd heavily improve the layout of the app by making views be dynamically sized.

## License
Copyright [2024] [Nikki Tran]

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
