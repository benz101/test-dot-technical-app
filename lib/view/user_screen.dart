import 'package:flutter/material.dart';
import 'package:test_dot_technical_app/model/place.dart';
import 'package:test_dot_technical_app/model/user.dart';
import 'package:test_dot_technical_app/view_model/api_service.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final TextEditingController _placeInputController =
      TextEditingController(text: '');
  final ValueNotifier<bool> _isLoading = ValueNotifier(true);
  final ValueNotifier<bool> _isSuccess = ValueNotifier(false);
  final ValueNotifier<DataUser?> _user = ValueNotifier(null);
  final APIService _apiService = APIService();

  void _getUser() {
    _apiService.getUser().then((value) {
      _isLoading.value = true;
      if (value.statusCode == 200 && value.message == 'success') {
        _isLoading.value = false;
        _isSuccess.value = true;
        _user.value = value.data;
        // ignore: avoid_print
        print('success');
      } else {
        _isLoading.value = false;
        _isSuccess.value = false;
        // ignore: avoid_print
        print('error');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.grey[300],
        alignment: Alignment.center,
        child: ValueListenableBuilder(
            valueListenable: _isLoading,
            builder: (context, bool valueIsLoading, _) {
              if (valueIsLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                );
              } else {
                return ValueListenableBuilder(
                    valueListenable: _isSuccess,
                    builder: (context, bool valueIsSuccess, _) {
                      if (valueIsSuccess) {
                        return ValueListenableBuilder(
                            valueListenable: _user,
                            builder: (context, DataUser? valueDataUser, _) {
                              return _userContent(valueDataUser);
                            });
                      } else {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          width: double.infinity,
                          height: 50,
                          color: Colors.transparent,
                          child: ElevatedButton(
                              onPressed: () {
                                _getUser();
                              }, child: const Text('Coba Lagi')),
                        );
                      }
                    });
              }
            }));
  }

  Widget _userContent(DataUser? valueDataUser) {
    String? _valueImage = valueDataUser?.avatar;
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              shape: BoxShape.circle,
            ),
            child: _valueImage == null
                ? Container()
                : CircleAvatar(
                  backgroundColor: Colors.grey[300],
                    backgroundImage: NetworkImage(_valueImage),
                  ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Container(
                width: 80,
                color: Colors.transparent,
                child: const Text('Username'),
              ),
              Container(
                color: Colors.transparent,
                child: const Text(':'),
              ),
              Flexible(
                child: Container(
                  width: double.infinity,
                  color: Colors.transparent,
                  child: Text(valueDataUser!.username!),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Container(
                width: 80,
                color: Colors.transparent,
                child: const Text('Email'),
              ),
              Container(
                color: Colors.transparent,
                child: const Text(':'),
              ),
              Flexible(
                child: Container(
                  width: double.infinity,
                  color: Colors.transparent,
                  child: Text(valueDataUser.fullname!),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Container(
                width: 80,
                color: Colors.transparent,
                child: const Text('Email'),
              ),
              Container(
                color: Colors.transparent,
                child: const Text(':'),
              ),
              Flexible(
                child: Container(
                  width: double.infinity,
                  color: Colors.transparent,
                  child: Text(valueDataUser.email!),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Container(
                width: 80,
                color: Colors.transparent,
                child: const Text('Phone'),
              ),
              Container(
                color: Colors.transparent,
                child: const Text(':'),
              ),
              Flexible(
                child: Container(
                  width: double.infinity,
                  color: Colors.transparent,
                  child: Text(valueDataUser.phone!),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
