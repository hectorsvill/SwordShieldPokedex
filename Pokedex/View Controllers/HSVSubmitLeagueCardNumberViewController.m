//
//  HSVSubmitLeagueCardNumberViewController.m
//  Pokedex
//
//  Created by Hector S. Villasano on 6/11/20.
//  Copyright © 2020 s. All rights reserved.
//

#import "HSVSubmitLeagueCardNumberViewController.h"
#import "HSVSerebiiViewController.h"
#import <NationalGalarPokedex-Swift.h>


@interface HSVSubmitLeagueCardNumberViewController ()

@property (nonatomic) HSVCloudFramework *cloudFramework;

@end

@implementation HSVSubmitLeagueCardNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureViews];


    self.cloudFramework = [HSVCloudFramework new];

}

- (void)configureViews {
    if (self.cardID != nil) {
        [self.resetButton setHidden:true];
        [self.submitButton setHidden:true];

        [self.sectionATextField setUserInteractionEnabled:false];
        [self.sectionBTextField setUserInteractionEnabled:false];
        [self.sectionCTextField setUserInteractionEnabled:false];
        [self.sectionDTextField setUserInteractionEnabled:false];

        NSArray *cardIDComponents = [self.cardID componentsSeparatedByString:@" "];

        self.sectionATextField.text = cardIDComponents[0];
        self.sectionBTextField.text = cardIDComponents[1];
        self.sectionCTextField.text = cardIDComponents[2];
        self.sectionDTextField.text = cardIDComponents[3];
    } else {
        self.resetButton.layer.cornerRadius = 8;
        self.submitButton.layer.cornerRadius = 8;
    }
}

- (IBAction)resetButtonPressed:(id)sender {
    self.sectionATextField.text = @"";
    self.sectionBTextField.text = @"";
    self.sectionCTextField.text = @"";
    self.sectionDTextField.text = @"";
}

- (IBAction)submutButtonPressed:(id)sender {
    NSString *textA = [self.sectionATextField.text uppercaseString];
    NSString *textB = [self.sectionBTextField.text uppercaseString];
    NSString *textC = [self.sectionCTextField.text uppercaseString];
    NSString *textD = [self.sectionDTextField.text uppercaseString];

    self.sectionATextField.text = textA;
    self.sectionBTextField.text = textB;
    self.sectionCTextField.text = textC;
    self.sectionDTextField.text = textD;

    NSString *cardNumber = [NSString stringWithFormat: @"%@ %@ %@ %@", textA, textB, textC, textD];


    CKRecord *record = [self.cloudFramework createLeageCardRecordWithCardID:cardNumber];
    [self.cloudFramework saveWithRecord:record completion:^(NSError *error) {
        if (error != nil) {
            // alert error
        }
    }];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"LeageCardInfoSegue"]) {
        NSLog(@"LeageCardInfoSegue");
        HSVSerebiiViewController *viewController = (HSVSerebiiViewController *)segue.destinationViewController;
        NSString *urlString = @"https://www.serebii.net/swordshield/leaguecard.shtml";
        viewController.urlString = urlString;

    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *currentText = [textField text];
    return textField.tag == 4 ? [currentText length] < 2 : [currentText length] < 4;
}

@end
