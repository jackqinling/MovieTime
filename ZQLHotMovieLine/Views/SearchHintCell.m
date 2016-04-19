//
//  SearchHintCell.m
//  ZQLHotMovieLine
//
//  Created by MacQin on 4/19/16.
//  Copyright © 2016 MS. All rights reserved.
//

#import "SearchHintCell.h"


typedef enum : NSUInteger {
    Movie = 1,
    Cinema,
} Type;
@interface SearchHintCell ()
@property (nonatomic, strong) UILabel * name;
@property (nonatomic, strong) UILabel * type;//contenttype
@property (nonatomic, strong) UILabel * enn;
@property (nonatomic, strong) UILabel * des;//address 和  type
@property (nonatomic, strong) UIView * tableContent;
@property (nonatomic, strong) UIImageView * cover;
@end
@implementation SearchHintCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initContentView];
    }
    return self;
}

- (void)setModel:(SearchHintModel *)model {
    _model = model;
    switch ([_model.type intValue]) {
        case Movie: {
            [self.cover setImageWithURL:[NSURL URLWithString:_model.cover] placeholderImage:VRectangleHolder];
            NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@(%@)[%@]", _model.titlecn, _model.year, @"影片"]];
            [str setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14], NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(str.length - 4, 4)];
            self.name.attributedText = str;
            self.enn.text = _model.titlecn;
            self.des.text = [NSString stringWithFormat:@"%@ %@", _model.locationName, _model.movieType];
        }
            break;
        case Cinema: {
            [self.cover setImageWithURL:[NSURL URLWithString:_model.cover] placeholderImage:VRectangleHolder];
            NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@[%@]", _model.name, @"影院"]];
            [str setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14], NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(str.length - 4, 4)];
            self.name.attributedText = str;
            self.enn.text = @" ";
            self.des.text = _model.address;
        }
            break;
        default:
            break;
    }
}
- (void)initContentView {
    //生成
    _tableContent = [[UIView alloc] init];
    
    _name = [[UILabel alloc] init];
    _enn = [[UILabel alloc] init];
    _des = [[UILabel alloc] init];
    _cover = [[UIImageView alloc] init];
    _type = [[UILabel alloc] init];
    
    //添加
    [self.contentView addSubview:_tableContent];
    
    [_tableContent addSubview:_name];
    [_tableContent addSubview:_enn];
    [_tableContent addSubview:_des];
    [_tableContent addSubview:_cover];
    
    //属性
    _name.font = [UIFont systemFontOfSize:15];
    _enn.font = [UIFont systemFontOfSize:13];
    _enn.textColor = [UIColor grayColor];
    _des.font = [UIFont systemFontOfSize:14];
    
    //约束
    WS(ws);
    [_tableContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets = UIEdgeInsetsMake(0, 0, 0, 0);
    }];
    
    [_cover mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.tableContent.mas_left).offset(15);
        make.top.mas_equalTo(ws.mas_top).offset(15);
        make.width.equalTo(@(60));
        make.height.equalTo(@(80));
    }];
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.cover.mas_right).offset(15);
        make.top.mas_equalTo(ws.cover.mas_top);
        make.width.mas_lessThanOrEqualTo(@(ZScreenWidth - 85));
    }];
    [_enn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.cover.mas_right).offset(15);
        make.top.mas_equalTo(ws.name.mas_bottom).offset(10);
        make.width.mas_lessThanOrEqualTo(@(ZScreenWidth - 85));
    }];
    [_des mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.cover.mas_right).offset(15);
        make.top.mas_equalTo(ws.enn.mas_bottom).offset(8);
        make.width.mas_lessThanOrEqualTo(@(ZScreenWidth - 85));
    }];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
