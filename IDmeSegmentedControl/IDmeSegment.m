//
//  IDmeSegment.m
//  IDmeSegmentedControl
//
//  Created by Arthur Sabintsev on 7/2/14.
//  Copyright (c) 2014 Arthur Ariel Sabintsev. All rights reserved.
//

#import "IDmeSegment.h"
#import "IDmeSegmentedControl.h"

NSString * const kIDmeSegmentCornerRadius       = @"segmentCornerRadius";
NSString * const kIDmeSegmentFont               = @"segmentFont";
NSString * const kIDmeSegmentResultsFont        = @"segmentResultsFonts";

@interface IDmeSegment ()


@property (nonatomic, assign) SegmentType segmentType;
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, strong) UIView *infoView;
@property (nonatomic, assign) CGFloat separator;
@property (nonatomic, assign) CGFloat padding;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSDictionary *appearance;
@property (nonatomic, strong) UIColor *activeColor;
@property (nonatomic, strong) UIColor *passiveColor;
@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation IDmeSegment

#pragma mark - Initialization
- (instancetype)initWithFrame:(CGRect)frame
                  segmentType:(SegmentType)segmentType
                   appearance:(NSDictionary *)appearance
                     andTitle:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupWithSegmentType:segmentType
                        appearance:appearance
                          andTitle:title];
    }
    
    return self;
}

#pragma mark - Setup
- (void)setupWithSegmentType:(SegmentType)segmentType
                  appearance:(NSDictionary *)appearance
                    andTitle:(NSString *)title
{
    _segmentType = segmentType;
    _appearance = appearance;
    _title = title;
    [self setupAppearance];
    [self setupMaskForSegmentType];
    [self setupSubviews];
}

- (void)setupAppearance
{
    _cornerRadius = [_appearance[kIDmeSegmentCornerRadius] floatValue];
    _activeColor = _appearance[kIDmeSegmentedControlActiveColor];
    _passiveColor = _appearance[kIDmeSegmentedControlPassiveColor];;
    _separator = 2.0f;
}

- (void)setupMaskForSegmentType
{
    CGSize cornerRadii = CGSizeMake(_cornerRadius, _cornerRadius);
    switch (_segmentType) {
        case SegmentTypeLeft: {
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                           byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerBottomLeft)
                                                                 cornerRadii:cornerRadii];
            CAShapeLayer *maskLayer = [CAShapeLayer new];
            maskLayer.frame = [self bounds];
            maskLayer.path = [maskPath CGPath];
            maskLayer.masksToBounds = YES;
            self.layer.mask = maskLayer;
        } break;
            
        case SegmentTypeMiddle: {
            // No corner radius masking needed.
        } break;
            
        case SegmentTypeRight: {
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                           byRoundingCorners:(UIRectCornerTopRight | UIRectCornerBottomRight)
                                                                 cornerRadii:cornerRadii];
            CAShapeLayer *maskLayer = [CAShapeLayer new];
            maskLayer.frame = [self bounds];
            maskLayer.path = [maskPath CGPath];
            maskLayer.masksToBounds = YES;
            self.layer.mask = maskLayer;
        } break;
    }
}

- (void)setupSubviews
{
    [self setupButton];
    [self setupTextLabel];
    [self setupInfoView];
    [self selectSegment:NO];
}

- (void)setupButton
{
    [self setBackgroundColor:_passiveColor];
    [self.layer setBorderWidth:0.5f];
    [self.layer setBorderColor:[_activeColor CGColor]];
}

- (void)setupTextLabel
{
    NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:_title attributes:@{kIDmeSegmentResultsFont : _appearance[kIDmeSegmentResultsFont]}];
    CGFloat textWidth = attributedTitle.size.width;
    
    _padding = (CGRectGetWidth(self.frame) - textWidth - _separator - (2 * _separator + CGRectGetHeight(self.frame)/2.0f))/2.0f;
    
    _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(_padding,
                                                           CGRectGetMinY(self.frame),
                                                           textWidth,
                                                           CGRectGetHeight(self.frame))];
    
    [_textLabel setText:_title];
    [_textLabel setFont:_appearance[kIDmeSegmentFont]];
    [_textLabel setTextAlignment:NSTextAlignmentCenter];
    [_textLabel setBackgroundColor:[UIColor clearColor]];
    [_textLabel setTextColor:_activeColor];
    [_textLabel setAdjustsFontSizeToFitWidth:YES];
    [_textLabel setMinimumScaleFactor:0.50];
    [_textLabel setLineBreakMode:NSLineBreakByClipping];
    [self addSubview:_textLabel];
}

- (void)setupInfoView
{
    CGFloat infoViewSquareLength = 2 * _separator + CGRectGetHeight(self.frame)/2.0f;
    CGRect infoViewRect = CGRectMake(2 * _separator + CGRectGetMinX(_textLabel.frame) + CGRectGetWidth(_textLabel.frame),
                                     - _separator + CGRectGetHeight(self.frame)/4.0f,
                                     infoViewSquareLength,
                                     infoViewSquareLength);
    _infoView = [[UIView alloc] initWithFrame:infoViewRect];
    [_infoView.layer setCornerRadius:_cornerRadius];
    [_infoView.layer setMasksToBounds:YES];
    [_infoView.layer setBorderWidth:1.0f];
    [self addSubview:_infoView];
    
    // activityView
    _infoActivity = [[UIActivityIndicatorView alloc] initWithFrame:infoViewRect];
    [_infoActivity setTransform:CGAffineTransformMakeScale(0.75, 0.75)];
    [_infoActivity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [_infoActivity setTintColor:_activeColor];
    [_infoActivity setHidesWhenStopped:YES];
    [self addSubview:_infoActivity];
    
    // label
    _infoLabel = [[UILabel alloc] initWithFrame:infoViewRect];
    [_infoLabel setFont:_appearance[kIDmeSegmentResultsFont]];
    [_infoLabel setTransform:CGAffineTransformMakeScale(0.75, 0.75)];
    [_infoLabel setTextAlignment:NSTextAlignmentCenter];
    [_infoLabel setTextColor:_passiveColor];
    [_infoLabel setTintColor:_activeColor];
    [_infoLabel setAdjustsFontSizeToFitWidth:YES];
    [_infoLabel setMinimumScaleFactor:0.50];
    [self addSubview:_infoLabel];
}

#pragma mark - Helpers
- (void)selectSegment:(BOOL)selected
{
    if (selected) {
        [self setSelected:YES];
        self.backgroundColor = _activeColor;
        _textLabel.textColor = _passiveColor;
        _infoView.layer.borderColor = [_passiveColor CGColor];
        _infoView.backgroundColor = _passiveColor;
        _infoActivity.color = _activeColor;
        _infoLabel.tintColor = _activeColor;
        _infoLabel.textColor = _activeColor;
    } else {
        [self setSelected:NO];
        self.backgroundColor = _passiveColor;
        _textLabel.textColor = _activeColor;
        _infoView.layer.borderColor = [_activeColor CGColor];
        _infoView.backgroundColor = _activeColor;
        _infoActivity.color = _passiveColor;
        _infoLabel.tintColor = _passiveColor;
        _infoLabel.textColor = _passiveColor;
    }
}

#pragma mark - UIResponder
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    // New selected state is inverse of current selected state, which is stored in control's isSelected accessor
    BOOL newSelectedState = ![self isSelected];
    [self selectSegment:newSelectedState];
    
    // Notify delegate of changed state
    [self.delegate segmentSelectedStateDidChange:self];
}

@end
