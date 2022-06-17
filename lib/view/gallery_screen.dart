import 'package:flutter/material.dart';
import 'package:test_dot_technical_app/model/gallery.dart';
import 'package:test_dot_technical_app/model/place.dart';
import 'package:test_dot_technical_app/view_model/api_service.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({Key? key}) : super(key: key);

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final TextEditingController _searchInputController =
      TextEditingController(text: '');
  final ValueNotifier<bool> _isLoading = ValueNotifier(true);
  final ValueNotifier<bool> _isSuccess = ValueNotifier(false);
  final ValueNotifier<List<DataGallery>?> _listGallery = ValueNotifier([]);
  final APIService _apiService = APIService();

  void _getListGalleryProcess() {
    _apiService.getListGallery().then((value) {
      _isLoading.value = true;
      if (value.statusCode == 200 && value.message == 'success') {
        _isLoading.value = false;
        _isSuccess.value = true;
        _listGallery.value = value.data;
        print('success');
      } else {
        _isLoading.value = false;
        _isSuccess.value = false;
        print('error');
      }
    });
  }

  Future<List<DataGallery>?> _reGetListGalleryProcess(String value) async {
    _isLoading.value = true;
    final response = await _apiService.getListGallery();
    if (response.statusCode == 200 && response.message == 'success') {
      _isLoading.value = false;
      _isSuccess.value = true;
      List<DataGallery>? search = response.data!
          .where((element) =>
              element.caption!.toLowerCase().contains(value.toLowerCase()))
          .toList();
      return search;
    } else {
      _isLoading.value = false;
      _isSuccess.value = false;
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    _getListGalleryProcess();
  }

  @override
  Widget build(BuildContext context) {
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
            child: TextField(
              controller: _searchInputController,
              onChanged: (value) {
                _reGetListGalleryProcess(value).then((values) {
                  if (values!.isNotEmpty) {
                    _listGallery.value = values;
                  }
                });
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
                              valueListenable: _listGallery,
                              builder: (context,
                                  List<DataGallery>? valueGallery, _) {
                                return Expanded(
                                    child: GridView.builder(
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          mainAxisSpacing: 3.0,
                                          crossAxisSpacing: 3,
                                          childAspectRatio: 1.0,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        itemCount: valueGallery?.length,
                                        itemBuilder: (context, index) {
                                          return _itemGallery(
                                              valueGallery?[index]);
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
                                      _getListGalleryProcess();
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

  Widget _itemGallery(DataGallery? dataGallery) {
    String? _valueImage = dataGallery?.image;
    return Container(
      width: double.infinity,
      height: 100,
      color: Colors.white,
      child: _valueImage == null
          ? Container()
          : Image.network(
              _valueImage,
              fit: BoxFit.fill,
            ),
    );
  }
}
