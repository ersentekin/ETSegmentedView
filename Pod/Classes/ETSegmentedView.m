//
//  ETSegmentedView.m
//  Pods
//
//  Created by Ersen Tekin on 30/03/15.
//
//

#import "ETSegmentedView.h"

#define kButtonsViewHeight 35

@implementation ETSegmentedView

@synthesize titles = _titles;
@synthesize arrayTitleButtons = _arrayTitleButtons;
@synthesize arrayTitleLabels = _arrayTitleLabels;
@synthesize viewButtons = _viewButtons;
@synthesize buttonTabHeight = _buttonTabHeight;
@synthesize selectionColor = _selectionColor;
@synthesize nonSelectionColor = _nonSelectionColor;
@synthesize delegate = _delegate;
@synthesize currentIndex = _currentIndex;
@synthesize viewSelection = _viewSelection;
@synthesize scrollViewContent = _scrollViewContent;
@synthesize contents = _contents;

-(id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [self setup];
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setup];
    }
    
    return self;
}

-(void)setup {
    
    // default values
    
    _arrayTitleButtons = [NSMutableArray new];
    _arrayTitleLabels = [NSMutableArray new];
    selfFrame = self.frame;
    _buttonTabHeight = kButtonsViewHeight;
    _currentIndex = 0;
    isScrollingAnimationActive = NO;
    lastContentX = 0;
    
    CGRect rectViewButtons = CGRectMake(0, 0, self.frame.size.width, kButtonsViewHeight);
    _viewButtons = [[UIView alloc] initWithFrame:rectViewButtons];
    [_viewButtons setBackgroundColor:_nonSelectionColor];
    [_viewButtons.layer setBorderColor:[UIColor colorWithWhite:0.8 alpha:1].CGColor];
    [_viewButtons.layer setCornerRadius:4.0f];
    [_viewButtons.layer setBorderWidth:1.0f];
    _viewButtons.clipsToBounds = YES;
    [self addSubview:_viewButtons];
    
}

-(void)setContents:(NSArray *)contents {
    
    _contents = [contents copy];
    
    if (_arrayTitleButtons.count <= 0) {
        
        [self createSelectionView];
        [self createButtonBar];
        [self createContentScrollView];
    }
    
}

-(void)setSelectionColor:(UIColor *)selectionColor {
    _selectionColor = selectionColor;
    [_selectionColor getRed:&selRed green:&selGreen blue:&selBlue alpha:&selAlpha];
}

-(void)setNonSelectionColor:(UIColor *)nonSelectionColor {
    _nonSelectionColor = nonSelectionColor;
    [_nonSelectionColor getRed:&nonRed green:&nonGreen blue:&nonBlue alpha:&nonAlpha];
}

-(void)createButtonBar {
    
    // remove buttons if exists on view
    
    if (_arrayTitleButtons.count > 0) {
        for (UIButton* btn in _arrayTitleButtons) {
            if ([btn.superview isEqual:_viewButtons]) {
                [btn removeFromSuperview];
            }
            
        }
        
        [_arrayTitleButtons removeAllObjects];
    }
    
    // create new buttons
    
    for (int i = 0; i < _titles.count; i++) {
        
        CGRect rectBtnTitle = CGRectMake(i * (selfFrame.size.width / _titles.count), 0, (selfFrame.size.width / _titles.count), _buttonTabHeight);
        UIButton* btnTitle = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnTitle setFrame:rectBtnTitle];
        [btnTitle setTitle:@"" forState:UIControlStateNormal];
        [btnTitle addTarget:self action:@selector(btnTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel* lblTitle = [[UILabel alloc] initWithFrame:rectBtnTitle];
        [lblTitle setFont:[UIFont fontWithName:@"HelveticaNeue" size:14.0f]];
        [lblTitle setTextAlignment:NSTextAlignmentCenter];
        [lblTitle setText:[_titles objectAtIndex:i]];
        
        if (i == 0) {
            [lblTitle setTextColor:_nonSelectionColor];
            
        } else {
            [lblTitle setTextColor:_selectionColor];
        }
        
        [_viewButtons addSubview:btnTitle];
        [_viewButtons addSubview:lblTitle];
        [_arrayTitleButtons addObject:btnTitle];
        [_arrayTitleLabels addObject:lblTitle];
    }
    
}

-(void)createSelectionView {
    
    _viewSelection = [[UIView alloc] initWithFrame:CGRectMake(0, 0, selfFrame.size.width / _titles.count, _buttonTabHeight)];
    [_viewSelection.layer setCornerRadius:4.0];
    [_viewSelection setClipsToBounds:YES];
    [_viewSelection setBackgroundColor:_selectionColor];
    [_viewButtons addSubview:_viewSelection];
}

-(void)createContentScrollView {
    
    CGRect rectScrollViewContent = CGRectMake(0, _buttonTabHeight, selfFrame.size.width, selfFrame.size.height - _buttonTabHeight);
    _scrollViewContent = [[UIScrollView alloc] initWithFrame:rectScrollViewContent];
    [_scrollViewContent setDelegate:self];
    [_scrollViewContent setBounces:YES];
    [_scrollViewContent setPagingEnabled:YES];
    
    for (int i = 0; i < _contents.count; i++) {
        
        UIView* content = [_contents objectAtIndex:i];
        CGRect rectContent = content.frame;
        rectContent.origin.x = (i * _scrollViewContent.frame.size.width) + (_scrollViewContent.frame.size.width / 2 - rectContent.size.width / 2);
        [content setFrame:rectContent];
        [_scrollViewContent addSubview:content];
        
    }
    
    [_scrollViewContent setContentSize:CGSizeMake(selfFrame.size.width * _contents.count, selfFrame.size.height - _buttonTabHeight)];
    
    [self addSubview:_scrollViewContent];
    
}

-(void)btnTapped:(UIButton*)sender {
    
    NSUInteger indexOfButton = [_arrayTitleButtons indexOfObject:sender];
    
    if (indexOfButton == _currentIndex) {
        return;
    }
    
    if (_viewSelection.pop_animationKeys.count > 0) {
        [_viewSelection pop_removeAllAnimations];
    }
    
    [self animateSelectionViewToIndex:indexOfButton];
    
    [_scrollViewContent setContentOffset:CGPointMake(indexOfButton * _scrollViewContent.frame.size.width, 0) animated:YES];
    isScrollingAnimationActive = YES;
    
    if ([_delegate respondsToSelector:@selector(ETSegmentedViewButtonTappedWithIndex:)]) {
        [_delegate ETSegmentedViewButtonTappedWithIndex:indexOfButton];
    }
}

-(void)animateSelectionViewToIndex:(NSUInteger)index{
    
    float btnWidth = (selfFrame.size.width / _titles.count);
    float animateToLocation = (int)index * btnWidth;
    
    UILabel* lblCurrent = [_arrayTitleLabels objectAtIndex:_currentIndex];
    UILabel* lblNext = [_arrayTitleLabels objectAtIndex:index];
    
    // location change animation
    
    POPSpringAnimation *locAnimation = [POPSpringAnimation animation];
    locAnimation.property = [POPAnimatableProperty propertyWithName: kPOPLayerPositionX];
    locAnimation.toValue = @(animateToLocation + btnWidth / 2);
    locAnimation.springBounciness = 10.0f;
    locAnimation.springSpeed = 5.0f;
    locAnimation.name = @"GotoLocation";
    locAnimation.delegate = self;
    
    // current label color change animation
    
    POPBasicAnimation* nextColorAnimation = [POPBasicAnimation animation];
    nextColorAnimation.property = [POPAnimatableProperty propertyWithName: kPOPLabelTextColor];
    nextColorAnimation.toValue = [UIColor whiteColor];
    nextColorAnimation.name = @"nextButtonColorChange";
    nextColorAnimation.delegate = self;
    
    // next label color change animation
    
    POPBasicAnimation* currColorAnimation = [POPBasicAnimation animation];
    currColorAnimation.property = [POPAnimatableProperty propertyWithName: kPOPLabelTextColor];
    currColorAnimation.toValue = [UIColor darkGrayColor];
    currColorAnimation.name = @"currentButtonColorChange";
    currColorAnimation.delegate = self;

    [_viewSelection pop_addAnimation:locAnimation forKey:locAnimation.name];
    [lblNext pop_addAnimation:nextColorAnimation forKey:nextColorAnimation.name];
    [lblCurrent pop_addAnimation:currColorAnimation forKey:currColorAnimation.name];
    
}

#pragma mark UIScrollView delegate

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    isScrollingAnimationActive = NO;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (!isScrollingAnimationActive) {
        
        CGRect rectViewSelection = _viewSelection.frame;
        rectViewSelection.origin.x = scrollView.contentOffset.x / _titles.count;
        [_viewSelection setFrame:rectViewSelection];
        
        if (scrollView.contentOffset.x >= 0 && scrollView.contentOffset.x <= scrollView.contentSize.width) {
            [self rearrangeRelatedButtonColor:scrollView.contentOffset.x];
        }
        
        lastContentX = _scrollViewContent.contentOffset.x;
        
        
    }
    
    _currentIndex = roundf(_scrollViewContent.contentOffset.x / scrollView.frame.size.width);
}

-(void)rearrangeRelatedButtonColor:(float)contentOffsetX {
    
    float locationIndex = contentOffsetX / _scrollViewContent.frame.size.width;
    float ratio = fmodf(locationIndex, 1);
    
    int prevIndex = floor(locationIndex);
    int nextIndex = ceil(locationIndex);
    
    if (prevIndex == nextIndex) {
        return;
    }
    
    UILabel* lblPrev;
    UILabel* lblNext;
    
    if (prevIndex >= 0) {
        lblPrev = [_arrayTitleLabels objectAtIndex:prevIndex];
    }
    
    if (nextIndex < _arrayTitleLabels.count) {
        lblNext = [_arrayTitleLabels objectAtIndex:nextIndex];
    }
    
    // TODO: find a better and generic way to set colors
    
    if (lblPrev) {
        
        CGFloat pRed, pGreen, pBlue;
        
        pRed = (selRed - nonRed) * ratio + nonRed;
        pGreen = (selGreen - nonGreen) * ratio + nonGreen;
        pBlue = (selBlue - nonBlue) * ratio + nonBlue;
        
        [lblPrev setTextColor:[UIColor colorWithRed:pRed green:pGreen blue:pBlue alpha:1]];
        
    }
    
    if (lblNext) {
        
        float nRed, nGreen, nBlue;
        
        nRed = (nonRed - selRed) * ratio + selRed;
        nGreen = (nonGreen - selGreen) * ratio + selGreen;
        nBlue = (nonBlue - selBlue) * ratio + selBlue;
        
        [lblNext setTextColor:[UIColor colorWithRed:nRed green:nGreen blue:nBlue alpha:1]];
    }
    
}

@end
