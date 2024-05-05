abstract class TrifectaAuthenticationReopsitory {
  Stream<User?> get currentTrifectaUser;
  Future<TrifectaUser> signUp({
    required TrifectaUser trifectaUser,
    required String passkey,
  });
  Future<void> signIn({
    required String emailAddress,
    required String passkey,
  });
  Future<void> setTrifectaUserData({required TrifectaUser trifectaUser});
  Future<void> logOut();
}
