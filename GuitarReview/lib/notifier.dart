import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'api_service.dart';
import 'database_helper.dart';
import 'model.dart';

class ChitarreNotifier with ChangeNotifier {
  List<Chitarra> _chitarre = [];
  List<Preferito> _preferiti = [];
  bool _isLoading = false;
  bool _isOffline = false;

  List<Chitarra> get chitarre => _chitarre;
  List<Preferito> get preferiti => _preferiti;
  bool get isLoading => _isLoading;
  bool get isOffline => _isOffline;

  Preferito? preferitoPer(String chitarraId) {
    for (final p in _preferiti) {
      if (p.chitarraId == chitarraId) return p;
    }
    return null;
  }

  Chitarra? chitarraPer(String chitarraId) {
    for (final c in _chitarre) {
      if (c.id == chitarraId) return c;
    }
    return null;
  }

  Future<void> loadAll() async {
    _isLoading = true;
    notifyListeners();

    final connectivity = await Connectivity().checkConnectivity();
    final online = !connectivity.contains(ConnectivityResult.none);

    if (online) {
      try {
        _chitarre = await ApiService.getChitarre();
        _preferiti = await ApiService.getPreferiti();
        await DatabaseHelper.saveChitarre(_chitarre);
        await DatabaseHelper.savePreferiti(_preferiti);
        _isOffline = false;
      } catch (e) {
        print('ERRORE RETE: $e');
        _chitarre = await DatabaseHelper.getChitarre();
        _preferiti = await DatabaseHelper.getPreferiti();
        _isOffline = true;
      }
    } else {
      _chitarre = await DatabaseHelper.getChitarre();
      _preferiti = await DatabaseHelper.getPreferiti();
      _isOffline = true;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addPreferito(Preferito p) async {
    final saved = await ApiService.createPreferito(p);
    await DatabaseHelper.upsertPreferito(saved);
    _preferiti.add(saved);
    notifyListeners();
  }

  Future<void> updatePreferito(Preferito p) async {
    final saved = await ApiService.updatePreferito(p);
    await DatabaseHelper.upsertPreferito(saved);
    final idx = _preferiti.indexWhere((x) => x.id == saved.id);
    if (idx != -1) _preferiti[idx] = saved;
    notifyListeners();
  }

  Future<void> patchPriorita(String id, String priorita) async {
    final saved = await ApiService.patchPreferito(id, {'priorita': priorita});
    await DatabaseHelper.upsertPreferito(saved);
    final idx = _preferiti.indexWhere((x) => x.id == id);
    if (idx != -1) _preferiti[idx] = saved;
    notifyListeners();
  }

  Future<void> deletePreferito(String id) async {
    await ApiService.deletePreferito(id);
    await DatabaseHelper.deletePreferito(id);
    _preferiti.removeWhere((p) => p.id == id);
    notifyListeners();
  }
}
