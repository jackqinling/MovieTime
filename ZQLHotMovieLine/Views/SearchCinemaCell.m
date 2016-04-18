//
//  SearchCinemaCell.m
//  ZQLHotMovieLine
//
//  Created by MacQin on 4/16/16.
//  Copyright © 2016 MS. All rights reserved.
//

#import "SearchCinemaCell.h"
#import "Masonry.h"
#import <objc/runtime.h>
#import "CinemaFeatureModel.h"

@interface SearchCinemaCell ()
@property (nonatomic, strong) UIView * tableContentView;
@property (nonatomic, strong) UILabel * name;
@property (nonatomic, strong) UILabel * address;
@property (nonatomic, strong) UILabel * distance;
@property (nonatomic, strong) UIImageView * heartImageView;
@property (nonatomic, strong) UILabel * heartLabel;

@property (nonatomic, strong) NSMutableArray * hasArray;

@end
@implementation SearchCinemaCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initContentView];
    }
    return self;
}

- (void)setModel:(SearchCinemaModel *)model{
    _model = model;
    self.name.text = _model.name;
    self.address.text = _model.address;
    self.heartImageView.image = [UIImage imageNamed:@"icon_red_heart"];
    self.heartLabel.text = [NSString stringWithFormat:@"%@%@", _model.loveDeep, @"%"];
    [self.heartImageView setHidden:![_model.loveDeep integerValue]];
    [self.heartLabel setHidden:![_model.loveDeep integerValue]];
    NSArray * imageNames = @[@"v10_small_Feature3D", @"v10_small_FeatureIMAX", @"v10_small_VIP", @"v10_small_park", @"v10_small_serviceTicket", @"v10_small_wifi"];
    if (_model.feature) {
        NSArray * attr = [SearchCinemaCell attributesWithClass:[CinemaFeatureModel class]];
        NSMutableArray * shows = [NSMutableArray array];
        for (int i = 0; i < 6; i++) {
            if ([[_model.feature valueForKey:attr[i]] boolValue]) {
                [shows addObject:imageNames[i]];
            }
        }
        for (int i = 0; i < shows.count; i++) {
            [self.hasArray[i] setImage:[UIImage imageNamed:shows[i]]];
            [self.hasArray[i] setHidden:NO];
        }
        for (int i = (int)shows.count; i < 6 ; i++) {
            [self.hasArray[i] setHidden:YES];
        }
    }
}

+ (NSArray *)attributesWithClass:(Class)classname{
    
    unsigned int count = 0;
    
    NSMutableArray * names = [NSMutableArray array];
    
    //获取类型classname  的所有属性
    objc_property_t * plist =   class_copyPropertyList(classname, &count);
    
    for (int i = 0 ; i < count; i ++) {
        //获取属性
        objc_property_t property = plist[i];
        //获取属性名字符串
        const char * str =  property_getName(property);
        
        NSString * name = [[NSString alloc] initWithUTF8String:str];//通过c字符串创建OC字符串
        [names addObject:name];
        
    }
    
    return names;
    
    
}

- (void)initContentView{
    //初始化
    _tableContentView = [[UIView alloc] init];
    _name = [[UILabel alloc] init];
    _address = [[UILabel alloc] init];
    _distance = [[UILabel alloc] init];
    _hasArray = [NSMutableArray arrayWithCapacity:6];
    for (int i = 0; i < 6; i++) {
        UIImageView * imageView = [[UIImageView alloc] init];
        [_hasArray addObject:imageView];
        [_tableContentView addSubview:imageView];
    }
    _heartImageView = [[UIImageView alloc] init];
    _heartLabel = [[UILabel alloc] init];
    
    //添加
    [self.contentView addSubview:_tableContentView];
    
    [_tableContentView addSubview:_name];
    [_tableContentView addSubview:_address];
    [_tableContentView addSubview:_distance];
    [_tableContentView addSubview:_heartImageView];
    [_tableContentView addSubview:_heartLabel];
    
    //设置属性
    _name.font = [UIFont systemFontOfSize:15];
    _address.font = [UIFont systemFontOfSize:13];
    _address.textColor = [UIColor grayColor];
    _address.numberOfLines = 0;
    _distance.font = [UIFont systemFontOfSize:12];
    _distance.textColor = [UIColor grayColor];
    _heartLabel.font = [UIFont systemFontOfSize:13];
    _heartLabel.textColor = [UIColor redColor];
    
    //设置约束
    WS(_ws);
    [_tableContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets = UIEdgeInsetsMake(0, 0, 0, 0);
    }];
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_ws.tableContentView.mas_top).offset(15);
        make.left.mas_equalTo(_ws.tableContentView.mas_left).offset(15);
    }];
    [_address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_ws.name.mas_bottom).offset(8);
        make.left.mas_equalTo(_ws.tableContentView).offset(15);
        make.width.mas_lessThanOrEqualTo(@(ZScreenWidth - 30));
    }];
    [_distance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_ws.name.mas_bottom).offset(10);
        make.right.mas_equalTo(_ws.tableContentView.mas_right).offset(10);
    }];
    [_heartLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_ws.tableContentView.mas_right).offset(-10);
        make.top.mas_equalTo(_ws.tableContentView.mas_top).offset(16);
    }];
    [_heartImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_ws.heartLabel.mas_left).offset(-2);
        make.centerY.mas_equalTo(_ws.heartLabel.mas_centerY);
        make.width.mas_equalTo(@(20));
        make.height.mas_equalTo(@(18));
    }];
    
    for (int i = 0; i < 6; i++) {
        UIImageView * imageView = _hasArray[i];
        if (i == 0) {
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(_ws.tableContentView.mas_bottom).offset(-15);
                make.left.mas_equalTo(_ws.tableContentView.mas_left).offset(15);
                make.width.mas_equalTo(@(20));
                make.height.mas_equalTo(@(20));
            }];
        }else{
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(_ws.tableContentView.mas_bottom).offset(-15);
                make.left.mas_equalTo([_hasArray[i - 1] mas_right]).offset(5);
                make.width.mas_equalTo(@(20));
                make.height.mas_equalTo(@(20));
            }];
        }
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
