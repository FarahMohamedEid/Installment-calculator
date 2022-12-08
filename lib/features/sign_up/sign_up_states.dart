abstract class SignUpStates {}

class InitialSignUpScreenStates extends SignUpStates {}

/// Google Sign In States
class GoogleSignInLoadingState extends SignUpStates {}
class GoogleSignInSuccessState extends SignUpStates {}
class GoogleSignInErrorState extends SignUpStates {}
/// Facebook Sign In States
class FaceBookSignInLoadingState extends SignUpStates {}
class FaceBookSignInSuccessState extends SignUpStates {}
class FaceBookSignInErrorState extends SignUpStates {}
/// Create user States
class CreateUserLoadingState extends SignUpStates {}
class CreateUserSuccessState extends SignUpStates {}
class CreateUserErrorState extends SignUpStates {}