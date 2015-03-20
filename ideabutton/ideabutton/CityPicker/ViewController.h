//
//  ViewController.h
//  YMCityPicker
//
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIPickerViewDelegate ,UIPickerViewDataSource>
@property (nonatomic ,strong) UIPickerView *cityPicker;
@property (nonatomic ,strong) UILabel *cityLabel;
@end

