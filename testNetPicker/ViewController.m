//
//  ViewController.m
//  testNetPicker
//
//  Created by 赵诣 on 16/3/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "AFNetworkHandler.h"
#import "FirstPageModel.h"

//适配
#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeigth ([UIScreen mainScreen].bounds.size.height)

@interface ViewController ()<UIPickerViewDelegate, UIPickerViewDataSource>
{
    NSInteger _row;
    NSInteger _province;
    NSInteger _city;
    NSInteger _district;
    
    BOOL _isAddress;
    BOOL _isShow;
    
    NSInteger _writeRowInProvince;
    NSInteger _writeRowInCity;
    NSInteger _writeRowInDistrict;
    
}
@property (nonatomic, retain) NSString *region_id;
@property (nonatomic, retain) NSString *region_id_city;

@property (weak, nonatomic) IBOutlet UIButton *buttonPicker;
//picker
@property (nonatomic, retain) UIPickerView *pickerView;

//data
@property (nonatomic, retain) NSMutableArray *arrProvince;
@property (nonatomic, retain) NSMutableArray *arrCity;
@property (nonatomic, retain) NSMutableArray *arrDiscrict;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getDataWithProvince];
}


#pragma mark - 所在地区点击方法
- (IBAction)buttonAction:(id)sender {
    _isShow = YES;
    _isAddress = !_isAddress;
    if (_isAddress) {
        self.pickerView.hidden = NO;
    } else {
        self.pickerView.hidden = YES;
    }
}

#pragma mark - 省市区数据
//省
- (void)getDataWithProvince
{
    [AFNetworkHandler GETWithAFNByURL:@"http://api.superwallet.com.cn/loanapp/check_region?id=1" completion:^(id result) {
        
        self.arrProvince = [NSMutableArray array];
        NSArray *arr = [result objectForKey:@"list"];
        self.arrProvince = [FirstPageModel arrayWithModelByArray:arr];
        
        
        [self createPickView];
        
        
    }];
}
//市
- (void)getDataWithCity
{
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", @"http://api.superwallet.com.cn/loanapp/check_region?id=", self.region_id];
    
    [AFNetworkHandler GETWithAFNByURL:strUrl completion:^(id result) {
        
        self.arrCity = [NSMutableArray array];
        NSArray *arr = [result objectForKey:@"list"];
        self.arrCity = [FirstPageModel arrayWithModelByArray:arr];
        
        [self getDataWithDistrict];
        [self.pickerView reloadAllComponents];
        
    }];
}
//区
- (void)getDataWithDistrict
{
    
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", @"http://api.superwallet.com.cn/loanapp/check_region?id=", [self.arrCity[_row] region_id]];
    
    [AFNetworkHandler GETWithAFNByURL:strUrl completion:^(id result) {
        
        self.arrDiscrict = [NSMutableArray array];
        NSArray *arr = [result objectForKey:@"list"];
        self.arrDiscrict = [FirstPageModel arrayWithModelByArray:arr];
        
        [self.pickerView reloadAllComponents];
        
    }];
}


#pragma mark - 创建PickerView
- (void)createPickView
{
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, ScreenHeigth - 250, ScreenWidth, 250)];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    [self.view addSubview:self.pickerView];
    self.pickerView.hidden = YES;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        
        return self.arrProvince.count;
        
    } else if (component == 1) {
        
        return self.arrCity.count;
    } else {
        
        return self.arrDiscrict.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if (component == 0){
        
        return [self.arrProvince[row] region_name];
        
        
    } else if (component == 1){
        
        
        return [self.arrCity[row] region_name];
        
    } else {
        
        
        return [self.arrDiscrict[row] region_name];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            
            _row = 0;
            self.region_id = [self.arrProvince[row] region_id];
            [self getDataWithCity];
            
            [self.pickerView selectRow:0 inComponent:1 animated:YES];
            [self.pickerView reloadComponent:1];
            
            [self.pickerView selectRow:0 inComponent:2 animated:YES];
            [self.pickerView reloadComponent:2];
            
            _writeRowInProvince = row;
            
            if (_isShow) {
                _province = row;
                [self.buttonPicker setTitle:[NSString stringWithFormat:@"%@%@%@", [self.arrProvince[_province] region_name], @"", @""] forState:(UIControlStateNormal)];
                
            }
            
            break;
        case 1:
            
            //            self.region_id_city = [self.arrCity[row] region_id];
            _row = row;
            [self getDataWithDistrict];
            
            [self.pickerView selectRow:0 inComponent:2 animated:YES];
            [self.pickerView reloadComponent:2];
            
            if (!row) {
                _writeRowInCity = 0;
            } else {
                _writeRowInCity = row;
            }
            
            if (_isShow) {
                _city = row;
                [self.buttonPicker setTitle:[NSString stringWithFormat:@"%@%@%@", [self.arrProvince[_province] region_name], [self.arrCity[_city] region_name], @""] forState:(UIControlStateNormal)];
                
            }
            
            break;
        case 2:
            
            _writeRowInDistrict = row;
            
            if (_isShow) {
                
                if (self.arrCity.count == 1) {
                    
                    
                    _city = 0;
                }
                _district = row;
                
                [self.buttonPicker setTitle:[NSString stringWithFormat:@"%@%@%@", [self.arrProvince[_province] region_name], [self.arrCity[_city] region_name], [self.arrDiscrict[_district] region_name]] forState:(UIControlStateNormal)];
            }
            
            break;
        default:
            break;
    }
}






@end
