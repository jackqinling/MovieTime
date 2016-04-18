//
//  SearchActorCell.m
//  ZQLHotMovieLine
//
//  Created by MacQin on 4/16/16.
//  Copyright © 2016 MS. All rights reserved.
//

#import "SearchActorCell.h"
#import "Masonry.h"
#import "PersonMovieModel.h"

@interface SearchActorCell ()
@property (nonatomic, strong) UIView * tableContentView;
@property (nonatomic, strong) UIImageView * postImageView;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * profeLabel;
@property (nonatomic, strong) UILabel * nameEnLabel;
@property (nonatomic, strong) UILabel * worksLabel;
@property (nonatomic, strong) UIImageView * heartImageView;
@property (nonatomic, strong) UILabel * heartLabel;

@end
@implementation SearchActorCell

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

- (void)setModel:(SearchPersonModel *)model{
    _model = model;
    self.nameLabel.text = _model.name;
    self.nameEnLabel.text = _model.nameEn;
    [self.postImageView setImageWithURL:[NSURL URLWithString:_model.img] placeholderImage:VRectangleHolder];
    self.profeLabel.text = _model.profession;
    if (_model.personMovies.count != 0) {
        NSMutableString * str = [NSMutableString string];
        for (PersonMovieModel * ps in _model.personMovies) {
            [str appendString:[NSString stringWithFormat:@"《%@》", ps.title]];
        }
        self.worksLabel.text = str;
    }
    self.heartImageView.image = [UIImage imageNamed:@"icon_red_heart"];
    if (![_model.loveDeep isEqualToString:@"-1"]) {
        self.heartImageView.hidden = NO;
        self.heartLabel.text = [NSString stringWithFormat:@"%@%@", _model.loveDeep, @"%"];
    }else{
        self.heartImageView.hidden = YES;
        self.heartLabel.text = @"";
    }
    
}
- (void)initContentView{
    //初始化
    _tableContentView = [[UIView alloc] init];
    
    _postImageView = [[UIImageView alloc] init];
    _nameLabel = [[UILabel alloc] init];
    _nameEnLabel = [[UILabel alloc] init];
    _profeLabel = [[UILabel alloc] init];
    _worksLabel = [[UILabel alloc] init];
    _heartImageView = [[UIImageView alloc] init];
    _heartLabel = [[UILabel alloc] init];
    //添加
    [self.contentView addSubview:_tableContentView];
    
    [_tableContentView addSubview:_postImageView];
    [_tableContentView addSubview:_nameLabel];
    [_tableContentView addSubview:_nameEnLabel];
    [_tableContentView addSubview:_profeLabel];
    [_tableContentView addSubview:_worksLabel];
    [_tableContentView addSubview:_heartImageView];
    [_tableContentView addSubview:_heartLabel];
    
    //设置属性
    _postImageView.contentMode = UIViewContentModeScaleAspectFit;
    _nameLabel.font = [UIFont systemFontOfSize:15];
    _nameEnLabel.font = [UIFont systemFontOfSize:13];
    _nameEnLabel.textColor = [UIColor grayColor];
    _profeLabel.font = [UIFont systemFontOfSize:14];
    _worksLabel.font = [UIFont systemFontOfSize:14];
    _worksLabel.numberOfLines = 0;
    _heartLabel.font = [UIFont systemFontOfSize:13];
    _heartLabel.textColor = [UIColor redColor];

    //设置约束
    WS(weakSelf);
    [_tableContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets = UIEdgeInsetsMake(0, 0, 0, 0);
    }];
    [_postImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.tableContentView.mas_top).offset(15);
        make.left.mas_equalTo(weakSelf.tableContentView.mas_left).offset(15);
        make.height.mas_equalTo(@(120));
        make.width.mas_equalTo(@(86));
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.postImageView.mas_top);
        make.left.mas_equalTo(weakSelf.postImageView.mas_right).offset(20);
        make.width.mas_lessThanOrEqualTo(@(ZScreenWidth - 146));
    }];
    [_nameEnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.nameLabel.mas_bottom).offset(8);
        make.left.mas_equalTo(weakSelf.nameLabel.mas_left);
        make.width.mas_lessThanOrEqualTo(@(ZScreenWidth - 146));
    }];
    [_profeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.nameEnLabel.mas_bottom).offset(8);
        make.left.mas_equalTo(weakSelf.nameEnLabel.mas_left);
        make.width.mas_lessThanOrEqualTo(@(ZScreenWidth - 146));
    }];
    [_worksLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.profeLabel.mas_bottom).offset(8);
        make.left.mas_equalTo(weakSelf.profeLabel.mas_left);
        make.width.mas_lessThanOrEqualTo(@(ZScreenWidth - 146));
    }];
    [_heartLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.tableContentView.mas_top).offset(15);
        make.right.mas_equalTo(weakSelf.tableContentView.mas_right).offset(-15);
    }];
    [_heartImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.heartLabel.mas_centerY);
        make.right.mas_equalTo(weakSelf.heartLabel.mas_left).offset(-2);
        make.width.mas_equalTo(@(20));
        make.height.mas_equalTo(@(18));
    }];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
