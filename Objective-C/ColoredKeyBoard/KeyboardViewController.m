//
//  KeyboardViewController.m
//  ColoredKeyBoard
//
//

#import "KeyboardViewController.h"

@interface KeyboardViewController ()



@property (nonatomic) BOOL capsLockOn;

@property (nonatomic,strong) NSLayoutConstraint* heightConstraint;
@property (nonatomic,strong) UIVisualEffectView* blurEffectView;


@property (weak, nonatomic) IBOutlet UIView *row1;
@property (weak, nonatomic) IBOutlet UIView *row2;
@property (weak, nonatomic) IBOutlet UIView *row3;
@property (weak, nonatomic) IBOutlet UIView *row4;

@property (weak, nonatomic) IBOutlet UIView *charSet1;
@property (weak, nonatomic) IBOutlet UIView *charSet2;



@end

@implementation KeyboardViewController

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    // Add custom view sizing constraints here
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.capsLockOn = true;
    
    NSArray * topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"KeyboardView" owner:self options:nil];
    self.view = [topLevelObjects objectAtIndex:0];
    self.charSet2.hidden = YES;
    
    for (int i = 101; i <= 153; i++)
    {
        UIView * view = [self.view viewWithTag:i];
        view.layer.cornerRadius = 5.0;
    }
    self.view.backgroundColor = [UIColor lightGrayColor];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    CGFloat desiredHeight = 263.0;
    
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:desiredHeight];
    [self.view addConstraint:heightConstraint];
    UIButton * button = (UIButton *)[self.view viewWithTag:101];
    button.layer.cornerRadius = 5.0;
    
     button = (UIButton *)[self.view viewWithTag:102];
     button.layer.cornerRadius = 5.0;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)nextKeyboardPressed:(id)sender {
    [self advanceToNextInputMode];
}

- (IBAction)capsLockPressed:(id)sender {
    
    self.capsLockOn = !self.capsLockOn;
    
    [self changeCaps:self.row1];
    [self changeCaps:self.row2];
    [self changeCaps:self.row3];
    [self changeCaps:self.row4];
}

-(void)changeCaps:(UIView *)containerView {
    
    for (UIView *view in containerView.subviews)
    {
        UIButton * button = (UIButton *)view;
        if (button != nil){
            
             NSString * buttonTitle = button.titleLabel.text;
            if (self.capsLockOn == YES){
                NSString * text = buttonTitle.uppercaseString;
                [button setTitle:text forState:UIControlStateNormal];
            } else {
                NSString * text = buttonTitle.lowercaseString;
                [button setTitle:text forState:UIControlStateNormal];
            }
        }
    }
}


- (IBAction)keyPressed:(id)sender {
    
    UIButton * button = (UIButton *)sender;
    NSString *string = button.titleLabel.text;
    
    
    [self.textDocumentProxy insertText:string];
    
    [UIView animateWithDuration:0.2 animations:^{
        button.transform =  CGAffineTransformScale(CGAffineTransformIdentity, 2.0, 2.0);
    } completion:^(BOOL finished) {
         button.transform =  CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
    }];
}

- (IBAction)backSpacePressed:(id)sender {
    [self.textDocumentProxy deleteBackward];
}

- (IBAction)spacePressed:(id)sender {
    [self.textDocumentProxy insertText: @" "];
}


- (IBAction)returnPressed:(id)sender {
    [self.textDocumentProxy insertText: @"\n"];
}


- (IBAction)charSetPressed:(id)sender {
    
    UIButton *button = (UIButton *)sender;
   
    if ([button.titleLabel.text  isEqual: @"=+-"]) {
        
        self.charSet1.hidden = YES;
        self.charSet2.hidden = NO;
        [button setTitle:@"#%*" forState:normal];
    } else  if ([button.titleLabel.text  isEqual: @"#%*"]) {
        
        self.charSet1.hidden = NO;
        self.charSet2.hidden = YES;
        [button setTitle:@"=+-" forState:normal];
    }
}


- (IBAction)morePressedAction:(id)sender {
    
    UIBlurEffect * blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    
    if  (self.blurEffectView == nil) {
        
        self.blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        //always fill the view
        self.blurEffectView.frame = self.view.bounds;
//        self.blurEffectView.autoresizingMask = [ UIViewAutoresizingFlexibleWidth, UIViewAutoresizingFlexibleHeight];
        self.blurEffectView.tag = 301;
        
        CGRect rect = CGRectMake(20, 20, self.view.frame.size.width - 40, self.view.frame.size.height - 40);
        UIView * view = [[UIView alloc]initWithFrame:rect];
        [self.blurEffectView addSubview:view];
        
        UIButton * button1 = [UIButton buttonWithType: UIButtonTypeSystem];
        button1.frame = CGRectMake(30, 30, 70, 40);
        [self configureButtonWith:button1 withColor:[UIColor greenColor] withTitle:@"Green" withTagNumber:701];
        [self.blurEffectView addSubview:button1];

        UIButton * button2 = [UIButton buttonWithType: UIButtonTypeSystem];
        button2.frame = CGRectMake(120, 30, 70, 40);
        [self configureButtonWith:button2 withColor:[UIColor yellowColor] withTitle:@"Yellow" withTagNumber:702];
        [self.blurEffectView addSubview:button2];
        
        UIButton * button3 = [UIButton buttonWithType: UIButtonTypeSystem];
        button3.frame = CGRectMake(210, 30, 70, 40);
        [self configureButtonWith:button3 withColor:[UIColor orangeColor] withTitle:@"Orange" withTagNumber:703];
        [self.blurEffectView addSubview:button3];
        
        UIButton * button4 = [UIButton buttonWithType: UIButtonTypeSystem];
        button4.frame = CGRectMake(30, 90, 70, 40);
        [self configureButtonWith:button4 withColor:[UIColor redColor] withTitle:@"Red" withTagNumber:704];
        [self.blurEffectView addSubview:button4];
        
        UIButton * button5 = [UIButton buttonWithType: UIButtonTypeSystem];
        button5.frame = CGRectMake(120, 90, 70, 40);
        [self configureButtonWith:button5 withColor:[[UIColor alloc]initWithRed: 60/255.0 green:239/255.0 blue: 239/255.0 alpha:1.0] withTitle:@"Blue" withTagNumber:705];
        [self.blurEffectView addSubview:button5];
        
        UIButton * button6 = [UIButton buttonWithType: UIButtonTypeSystem];
        button6.frame = CGRectMake(210, 90, 70, 40);
        [self configureButtonWith:button6 withColor:[[UIColor alloc]initWithRed: 255.0/255.0 green:0/255.0 blue: 255.0/255.0 alpha:0.7] withTitle:@"Pink" withTagNumber:706];
        [self.blurEffectView addSubview:button6];
    }
    
    [self.view addSubview:self.blurEffectView];
    
}

-(void)configureButtonWith:(UIButton *)button withColor:(UIColor *)color withTitle:(NSString *)title withTagNumber:(int)tagNumber {
    
    button.backgroundColor = color;
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self
               action:@selector(tappedButton:)
         forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = 5.0;
    button.tag = tagNumber;
}


-(void)tappedButton:(UIButton *)sender{
    
    if (sender.tag == 701) {
        self.view.backgroundColor = [UIColor greenColor];
        
    } else if(sender.tag == 702) {
        
        self.view.backgroundColor = [UIColor yellowColor];
        
    } else if (sender.tag == 703) {
        
        self.view.backgroundColor = [UIColor orangeColor];
        
    }  else if(sender.tag == 704) {
        
        self.view.backgroundColor = [UIColor redColor];
        
    }  else if (sender.tag == 705) {
        
        self.view.backgroundColor =  [[UIColor alloc]initWithRed: 60/255.0 green:239/255.0 blue: 239/255.0 alpha:1.0];
    }  else {
        
        self.view.backgroundColor =  [[UIColor alloc]initWithRed: 255.0/255.0 green:0/255.0 blue: 255.0/255.0 alpha:0.7];
    }
    
    UIView * colorView = [self.view viewWithTag:301];
    [colorView removeFromSuperview];
}

- (void)textWillChange:(id<UITextInput>)textInput {
}

- (void)textDidChange:(id<UITextInput>)textInput {
       UIColor *textColor = nil;
    if (self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearanceDark) {
        textColor = [UIColor whiteColor];
    } else {
        textColor = [UIColor blackColor];
    }
}

@end
