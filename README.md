# HTDial
## Show
![demoImg](https://github.com/runThor/HTDial/raw/master/Other/demo.png)
## Usage
```Objective-C
// ViewController.m

#import "HTDialView.h"

HTDialView *dialView = [[HTDialView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
dialView.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1];
[dialView setCenter:CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2)];
dialView.minValue = 0;
dialView.maxValue = 100;
dialView.firstSeparationValue = 30;
dialView.secondSeparationValue = 60;
[dialView pointValue:50];
[self.view addSubview:dialView];
```
