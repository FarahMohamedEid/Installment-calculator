abstract class FormStates {}

class InitialFormScreenStates extends FormStates {}

class ChangeCaptchaStates extends FormStates {}

/// upload form States
class UploadFormLoadingState extends FormStates {}
class UploadFormSuccessState extends FormStates {}
class UploadFormErrorState extends FormStates {}