
/**
 gitHub : https://github.com/568071718/AlertView.git
 */

#import <UIKit/UIKit.h>

@class TDAlertItem,TDAlertView;

@protocol TDAlertViewDelegate <NSObject>
@optional
- (void)alertView:(TDAlertView *)alertView didClickItemWithIndex:(NSInteger)itemIndex;
@end

@interface TDAlertView : UIView 

- (id)initWithTitle:(NSString *)title
            message:(id)message /** message : NSString or NSAttributedString object */
              items:(NSArray <TDAlertItem *>*)items
           delegate:(id <TDAlertViewDelegate>)delegate;

@property (nonatomic ,weak) id <TDAlertViewDelegate>delegate;

@property (nonatomic ,strong ,readonly) NSString *title;
@property (nonatomic ,strong ,readonly) id message;
@property (nonatomic ,strong ,readonly) NSArray <TDAlertItem *>*items;

@property (nonatomic ,assign) BOOL hideWhenTouchBackground;
@property (nonatomic ,assign) CGFloat optionsRowHeight;
@property (nonatomic ,assign) CGFloat alertWidth;
@property (nonatomic ,assign) UIEdgeInsets edgeInsets;
@property (nonatomic ,assign) NSInteger verticalMaxOptionCount;
@property (nonatomic ,assign) NSInteger horizontalMaxOptionCount;
- (void)show;
@end


@interface TDAlertItem : NSObject

- (id)initWithTitle:(NSString *)title;
@property (nonatomic ,strong) NSString *title;
@property (nonatomic ,strong) UIColor *titleColor;
@property (nonatomic ,strong) UIColor *backgroundColor;
@property (nonatomic ,strong) UIColor *selectedBackgroundColor;
@property (nonatomic ,strong) UIFont *font;
@end


