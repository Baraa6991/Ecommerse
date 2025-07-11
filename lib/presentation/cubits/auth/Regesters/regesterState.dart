abstract class Regesterstate {}

class RegesterInit extends Regesterstate{}

class RegesterField extends Regesterstate {
   final String message;
  RegesterField({required this.message});
}

class RegesterLoding extends Regesterstate {}

class RegesterSuccessful extends Regesterstate {
  
}
