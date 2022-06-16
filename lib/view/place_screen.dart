import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_dot_technical_app/model/place.dart';
import 'package:test_dot_technical_app/view_model/api_service.dart';

class PlaceScreen extends StatefulWidget {
  const PlaceScreen({Key? key}) : super(key: key);

  @override
  State<PlaceScreen> createState() => _PlaceScreenState();
}

class _PlaceScreenState extends State<PlaceScreen> {
  final TextEditingController _searchInputController =
      TextEditingController(text: '');
  final ValueNotifier<bool> _isLoading = ValueNotifier(true);
  final ValueNotifier<bool> _isSuccess = ValueNotifier(false);
  final ValueNotifier<List<Content>?> _listPlace = ValueNotifier([]);
  final APIService _apiService = APIService();
   final FocusNode _textNode = FocusNode();

  void _getListPlaceProcess() {
    _apiService.getListPlace().then((value) {
      _isLoading.value = true;
      if (value.statusCode == 200 && value.message == 'success') {
        _isLoading.value = false;
        _isSuccess.value = true;
        _listPlace.value = value.data?.content;
        print('success');
      } else {
        _isLoading.value = false;
        _isSuccess.value = false;
        print('error');
      }
    });
  }

  handleKey(RawKeyEventData key) {
    String _keyCode;
    _keyCode = key.keyLabel.toString(); //keycode of key event (66 is return)
    print('key: $_keyCode');
  }

  @override
  void initState() {
    super.initState();
    _getListPlaceProcess();
  }

  @override
  Widget build(BuildContext context) {
     FocusScope.of(context).requestFocus(_textNode);
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.grey[300],
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: RawKeyboardListener(
              focusNode: _textNode,
              onKey:(key) => handleKey(key.data),
              child: TextField(
                controller: _searchInputController,
                onChanged: (value) {
                  if (value.isNotEmpty) {        
                    List<Content>? search = _listPlace.value!
                        .where((element) => element.title!
                            .toLowerCase()
                            .contains(value.toLowerCase()))
                        .toList();
                    _listPlace.value = search;
                  } else {
                    print('empty');
                    _getListPlaceProcess();
                  }
                },
                decoration: const InputDecoration(
                    hintText: 'Search...',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black,
                          style: BorderStyle.solid,
                          width: 1),
                    )),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          ValueListenableBuilder(
              valueListenable: _isLoading,
              builder: (context, bool valueIsLoading, _) {
                if (valueIsLoading) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    ),
                  );
                } else {
                  return ValueListenableBuilder(
                      valueListenable: _isSuccess,
                      builder: (context, bool valueIsSuccess, _) {
                        if (valueIsSuccess) {
                          return ValueListenableBuilder(
                              valueListenable: _listPlace,
                              builder:
                                  (context, List<Content>? valueContent, _) {
                                return Expanded(
                                    child: ListView.builder(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        itemCount: valueContent?.length,
                                        itemBuilder: (context, index) {
                                          return _itemPlace(
                                              valueContent?[index]);
                                        }));
                              });
                        } else {
                          return Expanded(
                            child: Container(
                              color: Colors.transparent,
                              alignment: Alignment.center,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                width: double.infinity,
                                height: 50,
                                color: Colors.transparent,
                                child: ElevatedButton(
                                    onPressed: () {
                                      _getListPlaceProcess();
                                    },
                                    child: const Text('Coba Lagi')),
                              ),
                            ),
                          );
                        }
                      });
                }
              })
        ],
      ),
    );
  }

  Widget _itemPlace(Content? valueContent) {
    // valueContent.image
    String? _valueImage = valueContent?.image;
    String _valueMedia = valueContent!.media!.isNotEmpty ?  valueContent.media![0]: '';
    return Card(
      child: Container(
        width: double.infinity,
        height: 100,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              color: Colors.grey,
              child: _valueImage == null? Image.network(_valueMedia, fit: BoxFit.fill,): Image.network(_valueImage, fit: BoxFit.fill,),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Container(
                height: 80,
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                        child: Container(
                            color: Colors.transparent,
                            child: Text(valueContent.title!))),
                    const SizedBox(
                      height: 5,
                    ),
                    Flexible(
                        child: Container(
                            color: Colors.transparent,
                            child: Text(valueContent.content!))),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
