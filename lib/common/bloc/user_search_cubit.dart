// import 'package:potatoes/auto_list.dart';
// import 'package:potatoes/libs.dart';
// import 'package:beauty/common/bloc/search_cubit.dart';
// import 'package:beauty/common/models/user.dart';
// import 'package:beauty/common/services/person_cubit_manager.dart';
// import 'package:beauty/common/services/user_service.dart';

// class UserSearchCubit extends SearchCubit<User> {
//   final UserService userService;
//   final PersonCubitManager cubitManager;

//   UserSearchCubit({
//     required this.userService,
//     required this.cubitManager,
//   }) : super(
//             proceedSearch: userService.searchUser,
//             sleepDuration: Duration(milliseconds: 800));

//   @override
//   void onChange(Change<AutoListState<User>> change) {
//     super.onChange(change);
//     if (change.nextState is AutoListReadyState<User>) {
//       cubitManager
//           .addAll((change.nextState as AutoListReadyState<User>).items.items);
//     }
//   }
// }
