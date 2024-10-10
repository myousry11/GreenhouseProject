

abstract class GreenStates {}

class GreenInitialState extends GreenStates{}

class GreenBottomNavState extends GreenStates {}

class ControlPressed extends GreenStates {
  final bool fanState;
  ControlPressed(this.fanState);
}

class ControlChanged extends GreenStates {
  final bool fanState;

  ControlChanged(this.fanState);
}

abstract class AppThemeState{}
class AppThemeInitial extends AppThemeState {}
class AppLightTheme extends AppThemeState {}
class AppDarkTheme extends AppThemeState {}