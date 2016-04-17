//
//  SearchMovieCell.m
//  ZQLHotMovieLine
//
//  Created by MacQin on 4/16/16.
//  Copyright © 2016 MS. All rights reserved.
//

#import "SearchMovieCell.h"
#import "Masonry.h"
#import "UIColor+categoryColor.h"

#define POSTHEIGHT
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self

@interface SearchMovieCell ()

@property (nonatomic, strong) UIView * tableContentView;
@property (nonatomic, strong) UIImageView * postImageView;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * aliasLabel;
@property (nonatomic, strong) UILabel * categoryLabel;
@property (nonatomic, strong) UILabel * nationLabel;
@property (nonatomic, strong) UIButton * buyButton;

@property (nonatomic, strong) UIView * scoreView;
@property (nonatomic, strong) UILabel * scoreLabel;

@end
@implementation SearchMovieCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //初始化
        [self settingContentView];
    }
    
    return self;
}

- (void)settingContentView{
    //初始化
    self.tableContentView = [[UIView alloc] init];
    self.postImageView = [[UIImageView alloc] init];
    self.titleLabel = [[UILabel alloc] init];
    self.nameLabel = [[UILabel alloc] init];
    self.nationLabel = [[UILabel alloc] init];
    self.aliasLabel = [[UILabel alloc] init];
    self.categoryLabel = [[UILabel alloc] init];
    self.buyButton = [[UIButton alloc] init];
    
    self.scoreView = [[UIView alloc] init];
    self.scoreLabel = [[UILabel alloc] init];
    
    //添加
    [self.contentView addSubview:_tableContentView];
    [self.scoreView addSubview:_scoreLabel];
    [_tableContentView addSubview:_scoreView];
    [_tableContentView addSubview:_titleLabel];
    [_tableContentView addSubview:_postImageView];
    [_tableContentView addSubview:_nameLabel];
    [_tableContentView addSubview:_categoryLabel];
    [_tableContentView addSubview:_buyButton];
    [_tableContentView addSubview:_aliasLabel];
    [_tableContentView addSubview:_nationLabel];
    
    //设置属性
    self.scoreView.backgroundColor = [UIColor greenBack];
    self.scoreLabel.font = [UIFont systemFontOfSize:10];
    self.scoreLabel.textColor = [UIColor whiteColor];
    
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.numberOfLines = 0;
    self.nameLabel.font = [UIFont systemFontOfSize:11];
    self.nameLabel.textColor = [UIColor lightGrayColor];
    self.aliasLabel.font = [UIFont systemFontOfSize:11];
    self.aliasLabel.textColor = [UIColor lightGrayColor];
    self.categoryLabel.font = [UIFont systemFontOfSize:12];
    self.nationLabel.font = [UIFont systemFontOfSize:12];
    
    //设置约束
    WS(weakSelf);
    [_tableContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [_postImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.tableContentView.mas_top).offset(15);
        make.left.mas_equalTo(weakSelf.tableContentView.mas_left).offset(15);
        make.width.mas_equalTo(@(40));
        make.height.mas_equalTo(@(80));
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.postImageView.mas_top);
        make.left.mas_equalTo(weakSelf.postImageView.mas_right).offset(10);
        make.right.mas_greaterThanOrEqualTo(weakSelf.tableContentView.mas_right).offset(-25);
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.titleLabel.mas_left);
        make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).offset(-10);
        make.right.mas_greaterThanOrEqualTo(weakSelf.tableContentView.mas_right).offset(-10);
    }];
    [_aliasLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.titleLabel.mas_left);
        make.top.mas_equalTo(weakSelf.nameLabel.mas_bottom).offset(-5);
        make.right.mas_greaterThanOrEqualTo(weakSelf.tableContentView.mas_right).offset(-10);
    }];
    [_categoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.titleLabel.mas_left);
        make.top.mas_equalTo(weakSelf.aliasLabel.mas_bottom).offset(-5);
        
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.titleLabel.mas_left);
        make.top.mas_equalTo(weakSelf.categoryLabel.mas_bottom).offset(-5);
    }];
    
    
    [_scoreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.titleLabel.mas_right).offset(8);
        make.width.mas_equalTo(@(15));
        make.height.mas_equalTo(@(12));
    }];
    [_scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(weakSelf.scoreView.center);
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
