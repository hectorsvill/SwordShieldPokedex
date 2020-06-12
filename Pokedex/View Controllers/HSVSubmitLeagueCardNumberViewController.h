//
//  HSVSubmitLeagueCardNumberViewController.h
//  Pokedex
//
//  Created by Hector S. Villasano on 6/11/20.
//  Copyright © 2020 s. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HSVSubmitLeagueCardNumberViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *sectionATextField;
@property (weak, nonatomic) IBOutlet UITextField *sectionBTextField;
@property (weak, nonatomic) IBOutlet UITextField *sectionCTextField;
@property (weak, nonatomic) IBOutlet UITextField *sectionDTextField;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;


@end

NS_ASSUME_NONNULL_END
