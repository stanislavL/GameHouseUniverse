//
//  TPKeyboardAvoidingScrollView.h
//  Game Hours Universe
//
//  Created by stanislav on 10/10/14.
//
//

@interface TPKeyboardAvoidingScrollView : UIScrollView {
 
    UIEdgeInsets    _priorInset;
    BOOL            _priorInsetSaved;
    BOOL            _keyboardVisible;
    CGRect          _keyboardRect;
    CGSize          _originalContentSize;
}

- (void)adjustOffsetToIdealIfNeeded;
@end
