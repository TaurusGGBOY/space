import 'package:http/http.dart' as http;

import '../../classes/abstract/persit_data.dart';
import '../../classes/nasa/list.dart';
import '../../repositories/nasa/images.dart';
import '../../repositories/persistence_repository.dart';
import '../models.dart';

class NasaImagesModel extends QueryModel implements PersistData {
  @override
  Future loadData() async {
    await loadFromDisk();
    try {
      items.addAll(_module.images);
    } catch (e) {
      print("Error Loading Images: $e");
      items.addAll(await NasaImageRepo(httpClient: http.Client()).images);
    }
    setLoading(false);

    _module.images = await NasaImageRepo(httpClient: http.Client()).images;
    saveToDisk();
  }

  NasaImages _module = NasaImages(images: []);

  @override
  bool loaded = false;

  @override
  bool loading = false;

  @override
  Future loadFromDisk() async {
    if (!loading) {
      print("Loading $module from Disk");
      loading = true;
      notifyListeners();

      NasaImages _savedModule;
      try {
        _savedModule = await storage.loadNasaImagesState();
      } catch (e) {
        print("Error Loading State => $e");
      }
      if (_savedModule == null) {
        _module.images = await NasaImageRepo(httpClient: http.Client()).images;
      } else {
        _module = _savedModule;
        _fetching = false;
      }

      loading = false;
      loaded = true;
      notifyListeners();
    }
  }

  bool _fetching = false;

  bool get fetching => _fetching;

  @override
  String get module => "nasa_images".toLowerCase().trim();

  @override
  void saveToDisk() async {
    print("Saving $module to Disk");
    try {
      storage.saveNasaImagesState(_module);
    } catch (e) {
      print("Error Saving State => $e");
    }
  }

  @override
  PersistenceRepository get storage =>
      PersistenceRepository(fileStorage: FileStorage(module));
}
