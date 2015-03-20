//
//  ViewController.m
//  YMCityPicker
//
//
#define WIDTH  self.view.bounds.size.width
#define HEIGHT self.view.bounds.size.height
#import "ViewController.h"
#import "YMUtils.h"
@interface ViewController ()

@end

@implementation ViewController
{
    NSInteger row1;
    NSInteger row2;
    NSInteger row3;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    row1 = 0;
    row2 = 0;
    row3 = 0;
    self.cityLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, WIDTH, 40)];
    self.cityLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.cityLabel];
    
    self.cityPicker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 200, WIDTH, 180)];
    self.cityPicker.tag = 0;
    self.cityPicker.delegate = self;
    self.cityPicker.dataSource = self;
    self.cityPicker.showsSelectionIndicator = YES;
    [self.view addSubview:self.cityPicker];
    self.cityPicker.backgroundColor = [UIColor lightGrayColor];
    
}

//返回显示的列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (pickerView == self.cityPicker)
    {
        return 2;
    }
    else
    {
        return 1;
    }
}

//返回当前列显示的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0)
    {
        return [YMUtils getCityData].count;
    }
    else if (component == 1)
    {
        NSArray *array = [YMUtils getCityData][row1][@"children"];
        if ((NSNull*)array != [NSNull null])
        {
            return array.count;
        }
        return 0;
    }
    else
    {
        NSArray *array = [YMUtils getCityData][row1][@"children"];
        if ((NSNull*)array != [NSNull null])
        {
            NSArray *array1 = [YMUtils getCityData][row1][@"children"][row2][@"children"];
            if ((NSNull*)array1 != [NSNull null])
            {
                return array1.count;
            }
            return 0;
        }
        return 0;
    }
}

//设置当前行的内容
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(component == 0)
    {
        return [YMUtils getCityData][row][@"name"];
    }
    else if (component == 1)
    {
        return [YMUtils getCityData][row1][@"children"][row][@"name"];
    }
    
    return nil;
}

//选择的行数
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0)
    {
        row1 = row;
        row2 = 0;
        row3 = 0;
        [self.cityPicker reloadComponent:1];
    }
    else if (component == 1)
    {
        row2 = row;
        row3 = 0;
    }
    else
    {
        row3 = row;
    }
    NSInteger cityRow1 = [self.cityPicker selectedRowInComponent:0];
    NSInteger cityRow2 = [self.cityPicker selectedRowInComponent:1];
    NSMutableString *str = [[NSMutableString alloc]init];
    [str appendString:[YMUtils getCityData][cityRow1][@"name"]];
    NSArray *array = [YMUtils getCityData][cityRow1][@"children"];
    if ((NSNull*)array != [NSNull null])
    {
        [str appendString:[NSString stringWithFormat:@"-%@",[YMUtils getCityData][cityRow1][@"children"][cityRow2][@"name"]]];
    }
    self.cityLabel.text = str;
}

//每行显示的文字样式
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, 30)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.backgroundColor = [UIColor clearColor];
    if (component == 0)
    {
        titleLabel.text = [YMUtils getCityData][row][@"name"];
    }
    else if (component == 1)
    {
        titleLabel.text = [YMUtils getCityData][row1][@"children"][row][@"name"];
    }
    
    return titleLabel;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
