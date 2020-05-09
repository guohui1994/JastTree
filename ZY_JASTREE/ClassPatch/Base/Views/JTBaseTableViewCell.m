//
//  JTBaseTableViewCell.m
//  ZY_JASTREE
//
//  Created by 郭军 on 2019/7/2.
//  Copyright © 2019 JG. All rights reserved.
//

#import "JTBaseTableViewCell.h"

@implementation JTBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self configUI];
        
    }
    return self;
}

- (void)configUI {};


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
