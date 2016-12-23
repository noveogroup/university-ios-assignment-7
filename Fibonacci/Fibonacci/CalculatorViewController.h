//
//  CalculatorViewController.h
//  Fibonacci
//
//  Created by Иван Букшев on 3/17/15.
//  Copyright (c) 2015 Ivan Bukshev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalculatorViewController : UIViewController

@property (nonatomic, weak) IBOutlet UILabel *resultLabel;
@property (nonatomic, weak) IBOutlet UIButton *countButton;

- (IBAction)countButtonTouchUp:(UIButton *)sender;

@end
