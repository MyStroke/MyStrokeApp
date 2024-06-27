enum AuthResultStatus {
  successful,
  emailAlreadyExists,
  wrongPassword,
  invalidEmail,
  userNotFound,
  userDisabled,
  operationNotAllowed,
  tooManyRequests,
  undefined,
}

class AuthExceptionHandler {
  static handleException(e) {
    final AuthResultStatus status;
    switch (e.code) {
      case "invalid-email":
        status = AuthResultStatus.invalidEmail;
        break;
      case "email-already-in-use":
        status = AuthResultStatus.emailAlreadyExists;
        break;
      case "wrong-password":
        status = AuthResultStatus.wrongPassword;
        break;
      case "user-not-found":
        status = AuthResultStatus.userNotFound;
        break;
      case "user-disabled":
        status = AuthResultStatus.userDisabled;
        break;
      case "operation-not-allowed":
        status = AuthResultStatus.operationNotAllowed;
        break;
      case "too-many-requests":
        status = AuthResultStatus.tooManyRequests;
        break;
      default:
        status = AuthResultStatus.undefined;
    }
    return status;
  }

  static errorMessage(exceptionCode) {
    String errorMessage;

    switch (exceptionCode) {
      case AuthResultStatus.invalidEmail:
        errorMessage = "อีเมลไม่ถูกต้อง";
        break;
      case AuthResultStatus.emailAlreadyExists:
        errorMessage = "อีเมลนี้มีผู้ใช้งานแล้ว";
        break;
      case AuthResultStatus.wrongPassword:
        errorMessage = "รหัสผ่านไม่ถูกต้อง";
        break;
      case AuthResultStatus.userNotFound:
        errorMessage = "ไม่พบผู้ใช้งาน";
        break;
      case AuthResultStatus.userDisabled:
        errorMessage = "ผู้ใช้งานถูกระงับ";
        break;
      case AuthResultStatus.operationNotAllowed:
        errorMessage = "การดำเนินการไม่ได้รับอนุญาต";
        break;
      case AuthResultStatus.tooManyRequests:
        errorMessage = "มีการเรียกใช้งานมากเกินไป";
        break;
      default:
        errorMessage = "เกิดข้อผิดพลาดไม่ทราบสาเหตุ";
    }

    return errorMessage;
  }
}