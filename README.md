# HPCalendar
HPCalendar is an intuitive tool that enable users to effortlessly choose either a single date or a date range. Moreover, it seamlessly integrates customizable events conforming to the HPEvent protocol, allowing users to organize events.

<p align="center">
    <img src="https://github.com/HsuehPeng/HPCalendar/assets/94298439/477b13ca-bb94-413b-bff3-725c45aa90cf" width="400" height="840" />
</p>


## Installation
#### Cocoapods
```
In progress
```

#### Swift Package Manager
```
In progress
```

## Usage

<p align="center">
    <img src="https://github.com/HsuehPeng/HPCalendar/assets/94298439/2becda5a-de6c-483d-9605-d4b27177dfdb" width="300" height="630" />
    <img src="https://github.com/HsuehPeng/HPCalendar/assets/94298439/7abc22f2-ad93-4bb1-bb92-d7da62abeed3" width="300" height="630" />
</p>


#### Initialization
To create an HPCalendar, you must begin by initializing a Swift Calendar type. The locale you assign to this calendar will directly influence the format in which dates are displayed within the HPCalendar.
```Swift
let hpcalendar: HPCalendar = {
    var calendar = Calendar(identifier: .gregorian)
    calendar.locale = Locale(identifier: "en_US")
    calendar.timeZone = .gmt
    // After initializing a Swift Calendar type, you can then create a instance of HPCalendar.
    let hpCalendar = HPCalendar(calendar: calendar)
    return hpCalendar
}()
```

Once you create an instance of HPCalendar, you can use it to make a HPCalendarView. Within this view, you have the option to make either a singleSelection or rangeSelection HPCalendar.
```Swift
lazy var calendarView = hpcalendar.makeCalendar(frame: .zero, calendarType: .singleSelection)
lazy var calendarView = hpcalendar.makeCalendar(frame: .zero, calendarType: .rangeSelection)
```
#### Event Feature
For those interested in utilizing the event feature, Create a struct or class than conforms to HPEvent, and inject events on creation.
```Swift
struct DemoEvent: HPEvent {
	let title: String
	let date: Date
	let duration: Int
}

lazy var calendarView = hpcalendar.makeCalendar(frame: .zero, calendarType: .singleSelection, with: [
  DemoEvent(title: "", date: Date(), duration: 1),
  DemoEvent(title: "", date: Date().addingTimeInterval(86400), duration: 2),
  DemoEvent(title: "", date: Date().addingTimeInterval(604800), duration: 3),
  DemoEvent(title: "", date: Date().addingTimeInterval(2629743), duration: 4),
  DemoEvent(title: "", date: Date().addingTimeInterval(2829743), duration: 5),
])
```
#### Result
Remember to conform to the delegate protocol to recieve the selected result
```Swift
override func viewDidLoad() {
  super.viewDidLoad()
				
  hpcalendar.singleDelegate = self // or hpcalendar.rangeDelegate = self
}

func calendar(didSelectDate result: SingleSelectionResult) {
  // Do anything with the result
}

func calendar(didSelectDateRange result: RangeSelectionResult) {
  // Do anything with the result
}
```

> Note: The timezone of the date from the result is in UTC.

## Layout
There are two options for setting the UI layout. First is to use frame to set the layout, second is use NSLayoutConstraint. The example below is the second option.
```Swift
view.addSubview(calendarView)
calendarView.translatesAutoresizingMaskIntoConstraints = false
NSLayoutConstraint.activate([
  calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
  calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
  calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
  calendarView.heightAnchor.constraint(equalToConstant: 350)
])
```

## UIConfiguration
If you wish to customize the appearance of the HPCalendar, you can specify certain properties. More options will be available in the future!
```Swift
hpCalendar.appearance.calendarBackgroundColor = .green
hpCalendar.appearance.calendarHeaderColor = .green
hpCalendar.appearance.selectinoColor = .green
hpCalendar.appearance.eventDotColor = .green
```

## Architecture
<p align="center">
    <img src="https://github.com/HsuehPeng/HPCalendar/assets/94298439/ec675e75-5841-4836-9531-53d32c09686a" width="600" height="600" />
</p>
