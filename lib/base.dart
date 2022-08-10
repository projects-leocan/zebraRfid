import 'package:json_annotation/json_annotation.dart';
part 'base.g.dart';

typedef ErrorCallback = void Function(ErrorResult err);
typedef ReadRfidCallback = void Function(List<RfidData> datas);
typedef ConnectionStatusCallback = void Function(ReaderConnectionStatus status);

class ZebraEngineEventHandler {
  ZebraEngineEventHandler({
    required this.readRfidCallback,
    required this.errorCallback,
    required this.connectionStatusCallback
  });

  ///Read rfid tag callback
  ReadRfidCallback readRfidCallback;
  ///Connection Status
  ConnectionStatusCallback connectionStatusCallback;
  ///Exception error callback
  ErrorCallback errorCallback;

  // ignore: public_member_api_docs
  void process(String eventName, Map<String, dynamic> map) {
    switch (eventName) {
      case 'ReadRfid':
        List<dynamic> rfidDatas = map["datas"];
        List<RfidData> list = [];
        for (var i = 0; i < rfidDatas.length; i++) {
          list.add(RfidData.fromJson(Map<String, dynamic>.from(rfidDatas[i])));
        }
        readRfidCallback.call(list);
        break;
      case 'Error':
        var ss = ErrorResult.fromJson(map);
        errorCallback.call(ss);
        break;
      case 'ConnectionStatus':
        ReaderConnectionStatus status =
            ReaderConnectionStatus.values[map["status"] as int];
        connectionStatusCallback.call(status);
        break;
    }
  }
}

enum ReaderConnectionStatus {
  ///Not connected
  UnConnection,
  ///Connection complete
  ConnectionRealy,
  ///Connection error
  ConnectionError,
}

///Tag data
@JsonSerializable()
class RfidData {
  RfidData({
    required this.tagID,
    required this.antennaID,
    required this.peakRSSI,
    required this.relativeDistance,
    this.count = 0,
    required this.memoryBankData,
    required this.lockData,
    required this.allocatedSize
  });
  String tagID;
  int antennaID;
  ///Signal peak
  int peakRSSI;
  // public String tagDetails;
  // ACCESS_OPERATION_STATUS opStatus;
  int relativeDistance;
  int count;
  ///Storing data
  String memoryBankData;
  ///Permanently lock data
  String lockData;
  int allocatedSize;

  factory RfidData.fromJson(Map<String, dynamic> json) =>
      _$RfidDataFromJson(json);
  Map<String, dynamic> toJson() => _$RfidDataToJson(this);
}

@JsonSerializable()
class ErrorResult {
  ErrorResult();

  int code = -1;
  String errorMessage = "";

  factory ErrorResult.fromJson(Map<String, dynamic> json) =>
      _$ErrorResultFromJson(json);
  Map<String, dynamic> toJson() => _$ErrorResultToJson(this);
}
