//
//  ZHPickView.m
//  ZHpickView
//
//  Created by liudianling on 14-11-18.
//  Copyright (c) 2014年 赵恒志. All rights reserved.
//
#define ZHToobarHeight 35
#import "ZHPickView.h"

@interface ZHPickView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,copy)NSString *plistName;
@property(nonatomic,strong)NSArray *plistArray;
@property(nonatomic,assign)BOOL isLevelArray;
@property(nonatomic,assign)BOOL isLevelString;
@property(nonatomic,assign)BOOL isLevelDic;
@property(nonatomic,assign)BOOL isDatePicker;
@property(nonatomic,assign)BOOL isYearMonthPicker;
@property(nonatomic,assign)BOOL isYearMonthPickerWithNow;
@property(nonatomic,strong)NSDictionary *levelTwoDic;
@property(nonatomic,strong)UIToolbar *toolbar;
@property(nonatomic,strong)UIPickerView *pickerView;
@property(nonatomic,strong)UIView *backView;
@property(nonatomic,strong)UIDatePicker *datePicker;
@property(nonatomic,assign)NSDate *defaulDate;
@property(nonatomic,assign)BOOL isHaveNavControler;
@property(nonatomic,assign)NSInteger pickeviewHeight;
@property(nonatomic,copy)NSString *resultString;
@property(nonatomic,strong)NSMutableArray *componentArray;
@property(nonatomic,strong)NSMutableArray *dicKeyArray;
@property(nonatomic,copy)NSMutableArray *state;
@property(nonatomic,copy)NSMutableArray *city;
@end

@implementation ZHPickView
{
    
    NSMutableArray *yearArray;
    NSArray *monthArray;
    NSMutableArray *monthMutableArray;
    NSMutableArray *DaysMutableArray;
    NSMutableArray *DaysArray;
    NSString *currentMonthString;
    
    NSInteger selectedYearRow;
    NSInteger selectedMonthRow;
    NSInteger selectedDayRow;
    
    BOOL firstTimeLoad;
    
    NSInteger m;
    int year;
    int month;
    int day;
    
}

-(NSArray *)plistArray{
    if (_plistArray==nil) {
        _plistArray=[[NSArray alloc] init];
    }
    return _plistArray;
}

-(NSArray *)componentArray{

    if (_componentArray==nil) {
        _componentArray=[[NSMutableArray alloc] init];
    }
    return _componentArray;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpToolBar];
        
    }
    return self;
}


-(instancetype)initPickviewWithPlistName:(NSString *)plistName isHaveNavControler:(BOOL)isHaveNavControler{
    
    self=[super init];
    if (self) {
        _plistName=plistName;
        self.plistArray=[self getPlistArrayByplistName:plistName];
        [self setUpPickView];
        [self setFrameWith:isHaveNavControler];
    }
    return self;
}
-(instancetype)initPickviewWithArray:(NSArray *)array isHaveNavControler:(BOOL)isHaveNavControler{
    self=[super init];
    if (self) {
        self.plistArray=array;
        [self setArrayClass:array];
        [self setUpPickView];
        [self setFrameWith:isHaveNavControler];
    }
    return self;
}

-(instancetype)initDatePickviewWithHaveNavControler:(BOOL)isHaveNavControler
{
    self = [super init];
    if (self) {
        
        self.isDatePicker = YES;
        _isLevelDic=NO;
        _isLevelString=NO;
        _isLevelArray=NO;
        
        m=0;
        firstTimeLoad = YES;
        NSDate *date = [NSDate date];
        
        // Get Current Year
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy"];
        
        NSString *currentyearString = [NSString stringWithFormat:@"%@",
                                       [formatter stringFromDate:date]];
        year =[currentyearString intValue];
        
        
        // Get Current  Month
        
        [formatter setDateFormat:@"MM"];
        
        currentMonthString = [NSString stringWithFormat:@"%ld",(long)[[formatter stringFromDate:date]integerValue]];
        month=[currentMonthString intValue];
        
        // Get Current  Date
        
        [formatter setDateFormat:@"dd"];
        NSString *currentDateString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
        
        day =[currentDateString intValue];
        
        yearArray = [[NSMutableArray alloc]init];
        monthMutableArray = [[NSMutableArray alloc]init];
        DaysMutableArray= [[NSMutableArray alloc]init];
        for (int i = 1970; i <= year ; i++)
        {
            [yearArray addObject:[NSString stringWithFormat:@"%d",i]];
            
        }
        
        
        // PickerView -  Months data
        
        
        monthArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"];
        
        for (int i=1; i<month+1; i++) {
            [monthMutableArray addObject:[NSString stringWithFormat:@"%d",i]];
        }
        DaysArray = [[NSMutableArray alloc]init];
        
        for (int i = 1; i <= 31; i++)
        {
            [DaysArray addObject:[NSString stringWithFormat:@"%d",i]];
            
        }
        for (int i = 1; i <day+1; i++)
        {
            [DaysMutableArray addObject:[NSString stringWithFormat:@"%d",i]];
            
        }
        
        [self setUpPickView];
        [self setFrameWith:isHaveNavControler];
        
        // 设置初始默认值
        [self.pickerView selectRow:20 inComponent:0 animated:YES];
        [self.pickerView selectRow:0 inComponent:1 animated:YES];
        [self.pickerView selectRow:0 inComponent:2 animated:YES];
        
    }
    return self;
}

-(instancetype)initDatePickviewWithHaveNavControler:(BOOL)isHaveNavControler
                                    isYearMonthType:(BOOL)isYearMonth
                             isYearMonthTypeWithNow:(BOOL)isYearMonthWithNow
{
    self = [super init];
    if (self) {
        
        _isYearMonthPicker = isYearMonth;
        _isYearMonthPickerWithNow = isYearMonthWithNow;
        _isDatePicker = NO;
        _isLevelDic=NO;
        _isLevelString=NO;
        _isLevelArray=NO;
        
        m=0;
        firstTimeLoad = YES;
        NSDate *date = [NSDate date];
        
        // Get Current Year
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy"];
        
        NSString *currentyearString = [NSString stringWithFormat:@"%@",
                                       [formatter stringFromDate:date]];
        year =[currentyearString intValue];
        
        
        // Get Current  Month
        
        [formatter setDateFormat:@"MM"];
        
        currentMonthString = [NSString stringWithFormat:@"%ld",(long)[[formatter stringFromDate:date]integerValue]];
        month=[currentMonthString intValue];
        
//        // Get Current  Date
//        
//        [formatter setDateFormat:@"dd"];
//        NSString *currentDateString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
//        
//        day =[currentDateString intValue];
        
        yearArray = [[NSMutableArray alloc]init];
        monthMutableArray = [[NSMutableArray alloc]init];
//        DaysMutableArray= [[NSMutableArray alloc]init];
        for (int i = 1970; i <= year ; i++)
        {
            [yearArray addObject:[NSString stringWithFormat:@"%d",i]];
            
        }
        
        if (isYearMonthWithNow) {
            [yearArray addObject:@"至今"];
        }
        
        
        // PickerView -  Months data
        
        
        monthArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"];
        
        for (int i=1; i<month+1; i++) {
            [monthMutableArray addObject:[NSString stringWithFormat:@"%d",i]];
        }
//        DaysArray = [[NSMutableArray alloc]init];
        
//        for (int i = 1; i <= 31; i++)
//        {
//            [DaysArray addObject:[NSString stringWithFormat:@"%d",i]];
//            
//        }
//        for (int i = 1; i <day+1; i++)
//        {
//            [DaysMutableArray addObject:[NSString stringWithFormat:@"%d",i]];
//            
//        }
        
        [self setUpPickView];
        [self setFrameWith:isHaveNavControler];
        
        // 设置初始默认值
        [self.pickerView selectRow:20 inComponent:0 animated:YES];
        [self.pickerView selectRow:0 inComponent:1 animated:YES];
//        [self.pickerView selectRow:0 inComponent:2 animated:YES];
        
    }
    return self;
}


/*
-(instancetype)initDatePickWithDate:(NSDate *)defaulDate datePickerMode:(UIDatePickerMode)datePickerMode isHaveNavControler:(BOOL)isHaveNavControler{
    
    self=[super init];
    if (self) {
        
        _defaulDate=defaulDate;
        [self setUpDatePickerWithdatePickerMode:(UIDatePickerMode)datePickerMode];
        
        [self setFrameWith:isHaveNavControler];
    }
    return self;
}
*/

-(NSArray *)getPlistArrayByplistName:(NSString *)plistName{
    
    NSString *path= [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
    NSArray * array=[[NSArray alloc] initWithContentsOfFile:path];
    [self setArrayClass:array];
    return array;
}

-(void)setArrayClass:(NSArray *)array{
    _dicKeyArray=[[NSMutableArray alloc] init];
    for (id levelTwo in array) {
        
        if ([levelTwo isKindOfClass:[NSArray class]]) {
            _isLevelArray=YES;
            _isLevelString=NO;
            _isLevelDic=NO;
            _isDatePicker = NO;
            _isYearMonthPickerWithNow = NO;
            _isYearMonthPicker = NO;
        }else if ([levelTwo isKindOfClass:[NSString class]]){
            _isLevelString=YES;
            _isLevelArray=NO;
            _isLevelDic=NO;
            _isDatePicker = NO;
            _isYearMonthPicker = NO;
            _isYearMonthPickerWithNow = NO;
        }else if ([levelTwo isKindOfClass:[NSDictionary class]])
        {
            _isLevelDic=YES;
            _isLevelString=NO;
            _isLevelArray=NO;
            _levelTwoDic=levelTwo;
            _isDatePicker = NO;
            _isYearMonthPicker = NO;
            _isYearMonthPickerWithNow = NO;
            [_dicKeyArray addObject:[_levelTwoDic allKeys] ];
        }
    }
}

-(void)setFrameWith:(BOOL)isHaveNavControler{
    CGFloat toolViewX = 0;
    CGFloat toolViewH = _pickeviewHeight+ZHToobarHeight;
    CGFloat toolViewY ;
    if (isHaveNavControler) {
        toolViewY= [UIScreen mainScreen].bounds.size.height-toolViewH-50;
    }else {
        toolViewY= [UIScreen mainScreen].bounds.size.height-toolViewH;
    }
    CGFloat toolViewW = [UIScreen mainScreen].bounds.size.width;
    self.frame = CGRectMake(toolViewX, toolViewY, toolViewW, toolViewH);
}

-(void)setUpPickView{
    
    UIPickerView *pickView=[[UIPickerView alloc] init];
    pickView.backgroundColor=[UIColor whiteColor];
    _pickerView=pickView;
    pickView.delegate=self;
    pickView.dataSource=self;
    pickView.frame=CGRectMake(0, ZHToobarHeight, [UIScreen mainScreen].bounds.size.width, pickView.frame.size.height);

    _pickeviewHeight=pickView.frame.size.height;
    
    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _backView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    [self addSubview:pickView];
}


/*
-(void)setUpDatePickerWithdatePickerMode:(UIDatePickerMode)datePickerMode{
    UIDatePicker *datePicker=[[UIDatePicker alloc] init];
    datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    datePicker.datePickerMode = datePickerMode;
    datePicker.backgroundColor = [UIColor clearColor];
    if (_defaulDate) {
        [datePicker setDate:_defaulDate];
    }
    _datePicker=datePicker;
    datePicker.frame=CGRectMake(0, ZHToobarHeight, datePicker.frame.size.width, datePicker.frame.size.height);
    _pickeviewHeight=datePicker.frame.size.height;
    [self addSubview:datePicker];
}
*/
  
-(void)setUpToolBar{
    _toolbar=[self setToolbarStyle];
    [self setToolbarWithPickViewFrame];
    [self addSubview:_toolbar];
}
-(UIToolbar *)setToolbarStyle{
    UIToolbar *toolbar=[[UIToolbar alloc] init];
    
    UIBarButtonItem *leftSpace = [[UIBarButtonItem alloc]initWithCustomView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, toolbar.frame.size.height)]];
    
    UIBarButtonItem *lefttem=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(remove)];
    
    UIBarButtonItem *centerSpace=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(doneClick)];
    
    UIBarButtonItem *rightSpace = [[UIBarButtonItem alloc]initWithCustomView:[[UIView alloc] initWithFrame:CGRectMake(toolbar.frame.size.width-10, 0, 10, toolbar.frame.size.height)]];;
    
    toolbar.items=@[leftSpace,lefttem,centerSpace,right,rightSpace];
    
    return toolbar;
}
-(void)setToolbarWithPickViewFrame{
    _toolbar.frame=CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, ZHToobarHeight);
}

#pragma mark piackView 数据源方法
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    NSInteger component;
    if (_isLevelArray) {
        component=_plistArray.count;
    } else if (_isLevelString){
        component=1;
    }else if(_isLevelDic){
        component=[_levelTwoDic allKeys].count*2;
    }else if(_isDatePicker){
        component = 3;
    }else if(_isYearMonthPicker || _isYearMonthPickerWithNow){
        component = 2;
    }
    return component;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSArray *rowArray=[[NSArray alloc] init];
    if (_isLevelArray) {
        rowArray=_plistArray[component];
    }else if (_isLevelString){
        rowArray=_plistArray;
    }else if (_isLevelDic){
        NSInteger pIndex = [pickerView selectedRowInComponent:0];
        NSDictionary *dic=_plistArray[pIndex];
        for (id dicValue in [dic allValues]) {
                if ([dicValue isKindOfClass:[NSArray class]]) {
                    if (component%2==1) {
                        rowArray=dicValue;
                    }else{
                        rowArray=_plistArray;
                    }
            }
        }
    }else if(_isDatePicker){
        if (component == 0)
        {
            return [yearArray count];
            
        }
        else if (component == 1)
        {
            NSInteger selectRow =  [pickerView selectedRowInComponent:0];
            int n;
            n= year-1970;
            if (selectRow==n) {
                return [monthMutableArray count];
            }else
            {
                return [monthArray count];
                
            }
        }
        else
        {
            NSInteger selectRow1 =  [pickerView selectedRowInComponent:0];
            int n;
            n= year-1970;
            NSInteger selectRow =  [pickerView selectedRowInComponent:1];
            
            if (selectRow==month-1 &selectRow1==n) {
                
                return day;
                
            }else{
                
                if (selectedMonthRow == 0 || selectedMonthRow == 2 || selectedMonthRow == 4 || selectedMonthRow == 6 || selectedMonthRow == 7 || selectedMonthRow == 9 || selectedMonthRow == 11)
                {
                    return 31;
                }
                else if (selectedMonthRow == 1)
                {
                    int yearint = [[yearArray objectAtIndex:selectedYearRow]intValue ];
                    
                    if(((yearint %4==0)&&(yearint %100!=0))||(yearint %400==0)){
                        return 29;
                    }
                    else
                    {
                        return 28; // or return 29
                    }
                }
                else
                {
                    return 30;
                }
                
                
            }
            
        }

    }else if(_isYearMonthPicker || _isYearMonthPickerWithNow){
        if (component == 0)
        {
            return [yearArray count];
            
        }
        else if (component == 1)
        {
            NSInteger selectRow =  [pickerView selectedRowInComponent:0];
            int n;
            n= year-1970;
            if (selectRow==n) {
                return [monthMutableArray count];
            }else if(selectRow == n+1){
                return 0;//选中“至今”
            }else
            {
                return [monthArray count];
                
            }
        }

    }
    return rowArray.count;
}

#pragma mark UIPickerViewdelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *rowTitle=nil;
    if (_isLevelArray) {
        rowTitle=_plistArray[component][row];
    }else if (_isLevelString){
        rowTitle=_plistArray[row];
    }else if (_isLevelDic){
        NSInteger pIndex = [pickerView selectedRowInComponent:0];
        NSDictionary *dic=_plistArray[pIndex];
        if(component%2==0)
        {
            rowTitle=_dicKeyArray[row][component];
        }
        for (id aa in [dic allValues]) {
           if ([aa isKindOfClass:[NSArray class]]&&component%2==1){
                NSArray *bb=aa;
                if (bb.count>row) {
                    rowTitle=aa[row];
                }
                
            }
        }
    }else if(_isDatePicker){
        if (component == 0)
        {
            rowTitle =  [yearArray objectAtIndex:row]; // Year
        }
        else if (component == 1)
        {
            rowTitle =  [monthArray objectAtIndex:row];  // Month
        }
        else if (component == 2)
        {
            rowTitle =  [DaysArray objectAtIndex:row]; // Date
            
        }

    }else if(_isYearMonthPicker || _isYearMonthPickerWithNow){
        if (component == 0)
        {
            rowTitle =  [yearArray objectAtIndex:row]; // Year
        }
        else if (component == 1)
        {
            rowTitle =  [monthArray objectAtIndex:row];  // Month
        }
    }
    return rowTitle;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (_isLevelDic&&component%2==0) {
        
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }
    if (_isLevelString) {
        _resultString=_plistArray[row];
        
    }else if (_isLevelArray){
        _resultString=@"";
        if (![self.componentArray containsObject:@(component)]) {
            [self.componentArray addObject:@(component)];
        }
        for (int i=0; i<_plistArray.count;i++) {
            if ([self.componentArray containsObject:@(i)]) {
                NSInteger cIndex = [pickerView selectedRowInComponent:i];
                _resultString=[NSString stringWithFormat:@"%@%@",_resultString,_plistArray[i][cIndex]];
            }else{
                _resultString=[NSString stringWithFormat:@"%@%@",_resultString,_plistArray[i][0]];
                          }
        }
    }else if (_isLevelDic){
        if (component==0) {
          _state                    = _dicKeyArray[row][0];
        }else{
            NSInteger cIndex          = [pickerView selectedRowInComponent:0];
            NSDictionary *dicValueDic = _plistArray[cIndex];
            NSArray *dicValueArray    = [dicValueDic allValues][0];
            if (dicValueArray.count>row) {
                _city =dicValueArray[row];
            }
        }
    }else if(_isDatePicker){
        m=row;
        
        if (component == 0)
        {
            selectedYearRow = row;
            [self.pickerView reloadAllComponents];
        }
        else if (component == 1)
        {
            selectedMonthRow = row;
            [self.pickerView reloadAllComponents];
        }
        else if (component == 2)
        {
            selectedDayRow = row;
            
            [self.pickerView reloadAllComponents];
            
        }

    }else if(_isYearMonthPicker || _isYearMonthPickerWithNow){
        if (component == 0)
        {
            selectedYearRow = row;
            [self.pickerView reloadAllComponents];
        }
        else if (component == 1)
        {
            selectedMonthRow = row;
            [self.pickerView reloadAllComponents];
        }

    }
}

-(void)remove{
    
//    [self removeFromSuperview];
    [_backView removeFromSuperview];
}
-(void)show{
    [_backView addSubview:self];
    [[UIApplication sharedApplication].keyWindow addSubview:_backView];

}
-(void)doneClick
{
    if (_pickerView) {
        
        if (_resultString) {
           
        }else{
            if (_isLevelString) {
                _resultString=[NSString stringWithFormat:@"%@",_plistArray[0]];
            }else if (_isLevelArray){
                _resultString=@"";
                for (int i=0; i<_plistArray.count;i++) {
                    _resultString=[NSString stringWithFormat:@"%@%@",_resultString,_plistArray[i][0]];
                }
            }else if (_isLevelDic){
                
                if (_state==nil) {
                     _state =_dicKeyArray[0][0];
                }
                if (_city==nil){
                    NSInteger cIndex = [_pickerView selectedRowInComponent:0];
                    NSDictionary *dicValueDic=_plistArray[cIndex];
                    _city=[dicValueDic allValues][0][0];
                    
                }
              _resultString=[NSString stringWithFormat:@"%@%@",_state,_city];
            }else if (_isDatePicker) {
                
                //        _resultString=[NSString stringWithFormat:@"%@",_datePicker.date];
                
                _resultString = [NSString stringWithFormat:@"%@/%@/%@ ",[yearArray objectAtIndex:[self.pickerView selectedRowInComponent:0]],[monthArray objectAtIndex:[self.pickerView selectedRowInComponent:1]],[DaysArray objectAtIndex:[self.pickerView selectedRowInComponent:2]]];
            }else if(_isYearMonthPicker || _isYearMonthPickerWithNow){
                if([[yearArray objectAtIndex:[self.pickerView selectedRowInComponent:0]]isEqualToString:@"至今"]){
                    _resultString = @"至今";
                }else{
                _resultString = [NSString stringWithFormat:@"%@/%@ ",[yearArray objectAtIndex:[self.pickerView selectedRowInComponent:0]],[monthArray objectAtIndex:[self.pickerView selectedRowInComponent:1]]];
                }
            }
        }
    }
    if ([self.delegate respondsToSelector:@selector(toobarDonBtnHaveClick:resultString:)]) {
        [self.delegate toobarDonBtnHaveClick:self resultString:_resultString];
    }
    
    [_backView removeFromSuperview];
}

/**
 *设置pickerView字体大小
 */
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        //adjustsFontSizeToFitWidth property to YES
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor whiteColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
    }

    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    
    return pickerLabel;
}

/**
 *  设置PickView的颜色
 */
-(void)setPickViewColor:(UIColor *)color{
    _pickerView.backgroundColor=color;
}
/**
 *  设置toobar的文字颜色
 */
-(void)setTintColor:(UIColor *)color{
    
    _toolbar.tintColor=color;
}
/**
 *  设置toobar的背景颜色
 */
-(void)setToolbarTintColor:(UIColor *)color{
    
    _toolbar.barTintColor=color;
}
-(void)dealloc{
    
    //NSLog(@"销毁了");
}
@end
