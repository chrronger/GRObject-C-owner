//
//  ViewController.m
//  GRObject-C-owner
//
//  Created by sen on 2016/9/22.
//  Copyright © 2016年 sen. All rights reserved.
//

#import "ViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>


#define viewWidth self.connectView.frame.size.width
#define viewHeight self.connectView.frame.size.height

//蓝牙功能

@interface ViewController ()<CBCentralManagerDelegate,CBPeripheralDelegate>
{
    BOOL isScaning;
}
//蓝牙设备管理
@property(nonatomic,strong)CBCentralManager *manager;
//扫描到的设备
@property(nonatomic,strong)NSMutableArray *devices;
@property(nonatomic,strong)UIButton *searchButton;
@property(nonatomic,strong)UIImageView *connectView;
@property(nonatomic,strong)UILabel *searchLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"搜索设备";
    //self.view.backgroundColor = Color(15, 86, 84, 1);
    [self.view addSubview:self.searchButton];
    [self.view addSubview:self.searchLabel];
   
    
    self.devices = [NSMutableArray array];
    
}

- (UIButton *)searchButton
{
    if (!_searchButton) {
        
       // _searchButton =[UIButton buttonWithTitle:@"开始搜索" titleFont:17.0 titleColor:[UIColor whiteColor] target:self action:@selector(searchDev)];
       // _searchButton.frame = CGRectMake((WIDTH-viewWidth)/2, CGRectGetMaxY(self.searchLabel.frame)+70,viewWidth,40);
        _searchButton.layer.borderWidth = 2;
        //_searchButton.layer.borderColor = Color(51, 120, 110, 1).CGColor;
        _searchButton.layer.cornerRadius = 20;
        _searchButton.layer.masksToBounds = YES;
        //        _searchButton.clipsToBounds = YES;
       // _searchButton.backgroundColor = Color(15, 77, 79, 1);
        
    }
    return _searchButton;
}
- (UIImageView *)connectView
{
    if (!_connectView) {
        _connectView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"blankpage_image_Sleep"]];
       // _connectView.frame = CGRectMake((WIDTH-200)/2,50,200,200);
        [self.view addSubview:_connectView];
        
        //        UILabel *contentLabel = [UILabel labelWithText:@"" fontSize:15 textColor:[UIColor blackColor] alignment:NSTextAlignmentLeft];
        //        contentLabel.frame = CGRectMake(30, titleLabel.frame.size.height, viewWidth-30*2, viewHeight-70);
        ////        [contentLabel sizeToFit];
        //        contentLabel.numberOfLines = 0;
        //        [_connectView addSubview:contentLabel];
        
    }
    return _connectView;
}

- (UILabel *)searchLabel
{
    if (!_searchLabel) {
        //_searchLabel = [UILabel labelWithText:@"搜索附近蓝牙设备" fontSize:15 textColor:Color(105, 156, 155, 1) alignment:NSTextAlignmentCenter];
        //_searchLabel.frame = CGRectMake((WIDTH-200)/2,CGRectGetMaxY(self.connectView.frame)+25,200, 30);
        
    }
    return _searchLabel;
}

//开始搜索
- (void)searchDev
{
    self.manager = [[CBCentralManager alloc]initWithDelegate:self queue:nil];
    
    self.searchButton.hidden = YES;
    self.searchLabel.text = @"正在搜索附近蓝牙设备...";
    //UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10,HEIGHT-130, WIDTH-20, 1)];
    //line.backgroundColor = Color(51, 120, 110, 1);
   // [self.view addSubview:line];
    
}

#pragma mark - CBCentralManagerDelegate
//主设备状态改变，在初始化CBCentralManager的适合会打开设备，只有当设备正确打开后才能使用
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    switch(central.state)
    {
            
        case CBCentralManagerStateUnknown:
            
            NSLog(@">>>CBCentralManagerStateUnknown");
            
            break;
            
        case CBCentralManagerStateResetting:
            
            NSLog(@">>>CBCentralManagerStateResetting");
            
            break;
            
        case CBCentralManagerStateUnsupported:
            
            NSLog(@">>>CBCentralManagerStateUnsupported");
            
            break;
            
        case CBCentralManagerStateUnauthorized:
            
            NSLog(@">>>CBCentralManagerStateUnauthorized");
            
            break;
            
        case CBCentralManagerStatePoweredOff:
            
            NSLog(@">>>CBCentralManagerStatePoweredOff");
            
            break;
            
        case CBCentralManagerStatePoweredOn:
            
            NSLog(@">>>CBCentralManagerStatePoweredOn");
            //第一个参数nil就是扫描周围所有的外设
            [self.manager scanForPeripheralsWithServices:nil options:nil];
            isScaning = YES;
            //self.manager.isScanning / stopScan;
            break;
            
        default:
            
            break;
    }
}
//发现外设
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSLog(@"当扫描到设备:%@",peripheral.name);
    //设置连接规则，我设置的是**开头的设备   一个主设备最多能连7个外设，每个外设最多只能给一个主设备连接,连接成功，失败，断开会进入各自的delegate
    if ([peripheral.name hasPrefix:@"A"]){
        [self.manager connectPeripheral:peripheral options:nil];
    }
}
//连接成功
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSLog(@">>>连接到名称为（%@）的设备-成功",peripheral.name);
    [peripheral setDelegate:self];
    
}

//连接失败
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@">>>连接到名称为（%@）的设备-失败,原因:%@",[peripheral name],[error localizedDescription]);
}

//断开
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@">>>外设连接断开连接 %@: %@\n", [peripheral name], [error localizedDescription]);
    //停止扫描
    [self.manager stopScan];
    //断开连接
    [self.manager cancelPeripheralConnection:peripheral];
}


#pragma mark - peripheraldelegate
//扫描外设Services
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    [peripheral discoverServices:nil];
    
    
}

//扫描每个service的Characteristics
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    //  NSLog(@">>>扫描到服务：%@",peripheral.services);
    
    if (error)
        
    {
        
        NSLog(@">>>Discovered services for %@ with error: %@", peripheral.name, [error localizedDescription]);
        
        return;
        
    }
    
    for (CBService *service in peripheral.services) {
        
        NSLog(@"%@",service.UUID);
        [peripheral discoverCharacteristics:nil forService:service];
        
    }
    
}



- (void)viewDidDisappear:(BOOL)animated
{
    //退出界面停止扫描
    [super viewDidDisappear:YES];
    if (isScaning) {
        isScaning = NO;
        [self.manager stopScan];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
