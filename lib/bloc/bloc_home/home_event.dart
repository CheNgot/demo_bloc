abstract class HomeEvent {}
class AddItem extends HomeEvent {
  final String item;


  AddItem({required this.item});
}