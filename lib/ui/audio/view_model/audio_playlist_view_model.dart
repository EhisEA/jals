import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jals/models/playlist_model.dart';
import 'package:jals/services/audio_service.dart';
import 'package:jals/utils/base_view_model.dart';
import 'package:jals/utils/network_utils.dart';

class AudioPlaylsitViewModel extends BaseViewModel {
  NetworkConfig _networkConfig = NetworkConfig();
  
  AudioService _audioService = AudioService();
  
  List<PlayListModel> playList;
  
  TextEditingController playlistNameController=TextEditingController();
  GlobalKey<FormState> formKey =GlobalKey<FormState> ();

  getPlaylist() async {
    setBusy(ViewState.Busy);
    await _networkConfig.onNetworkAvailabilityDialog(_getPlaylistNewtworkCall);
    setBusy(ViewState.Idle);
  }

  _getPlaylistNewtworkCall() async {
    playList = await _audioService.getPlaylist();

  }

  createPlaylist()async{
    setSecondaryBusy(ViewState.Busy);
    await _networkConfig.onNetworkAvailabilityDialog(_createPlaylistNetworkCall);
    setSecondaryBusy(ViewState.Idle);
  }
  _createPlaylistNetworkCall()async{
    
    if(formKey.currentState.validate()){
    bool response= await _audioService.createPlaylist(playlistNameController.text);

    if(response){
      Fluttertoast.showToast(msg: "Playlist Created");
      playlistNameController.clear();
      getPlaylist();
    }else{
      Fluttertoast.showToast(msg: "Could not create playlist: please try again");
    }
    }
  }
}
