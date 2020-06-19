//
//  HSVSubmitLeagueCardNumberViewController.m
//  Pokedex
//
//  Created by Hector S. Villasano on 6/11/20.
//  Copyright © 2020 s. All rights reserved.
//

#import "HSVSubmitLeagueCardNumberViewController.h"
#import "HSVSerebiiViewController.h"
#import "HSVLeageCard.h"
#import <NationalGalarPokedex-Swift.h>
#import <CloudKit/CloudKit.h>


@interface HSVSubmitLeagueCardNumberViewController ()

@property (nonatomic) HSVCloudFramework *cloudFramework;

@end

@implementation HSVSubmitLeagueCardNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureViews];
    self.cloudFramework = [HSVCloudFramework new];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self checkiCloudAccountStatus];
}

- (void)configureViews {
    if (self.cardID != nil) {
        // user will be viewing leage card id
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
        // user will try to input leage card id
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

    for (HSVLeageCard *card in self.cards) {
        if (card.cardID == cardNumber) {
            [self alertControlerWith:@"Error" message:@"Leage Card Already Exist"];
            return;
        }
    }

    CKRecord *record = [self.cloudFramework createLeageCardRecordWithCardID:cardNumber];
    [self.cloudFramework saveWithRecord:record completion:^(NSError *error) {
        if (error != nil) {
            [self alertControlerWith:@"Error" message:@"iCloud error saving Leage Card ID.\n Please try again."];
        }
    }];
}

- (void)checkiCloudAccountStatus {
    [self.cloudFramework.container accountStatusWithCompletionHandler:^(CKAccountStatus accountStatus, NSError *error) {
        if (error) {
            [self alertControlerWith:@"Error" message:@"Please try again."];
            return;
        }

        if (accountStatus == CKAccountStatusNoAccount) {
            [self alertControlerWith:@"iCloud Error" message:@"User must be signed in to their iCloud account."];
        }
    }];
}

#pragma mark - AlertControllers

- (void)alertControlerWith:(NSString *)title message:(NSString *)message {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
            [self.navigationController popViewControllerAnimated:true];
        }];

        [ac addAction:okAction];

        [self presentViewController:ac animated:false completion:nil];
    });
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
