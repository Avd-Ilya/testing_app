part of 'navigation_cubit.dart';

class NavigationState extends Equatable {
  final NavbarItem navbarItem;
  final int index;
  final bool secondSelected;

  NavigationState(this.navbarItem, this.index, this.secondSelected);

  @override
  List<Object> get props => [navbarItem, index, secondSelected];
}

class NavigationUpdated extends NavigationState {
  NavigationUpdated(super.navbarItem, super.index, super.secondSelected);
}