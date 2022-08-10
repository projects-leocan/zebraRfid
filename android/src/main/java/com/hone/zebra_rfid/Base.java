package com.hone.zebra_rfid;

import com.zebra.rfid.api3.ACCESS_OPERATION_STATUS;

public class Base {
    public static class ErrorResult {
        int code = -1;
        String errorMessage = "";

        public static ErrorResult error(String errorMessage, int code) {
            ErrorResult result=new ErrorResult();
            result.errorMessage=errorMessage;
            result.code=code;
            return result;
        }

        public static ErrorResult error(String errorMessage) {
            ErrorResult result=new ErrorResult();
            result.errorMessage=errorMessage;
            return result;
        }
    }

    public static class RfidEngineEvents{
        static String Error = "Error";
        static String ReadRfid = "ReadRfid";
        static String ConnectionStatus = "ConnectionStatus";
    }

    enum ConnectionStatus {
        ///Not connected
        UnConnection,
        ///Connection complete
        ConnectionRealy,
        ///Connection error
        ConnectionError,
    }

    public static class RfidData{
        public String tagID;
        public short antennaID;
        public short peakRSSI;
        // public String tagDetails; 
        public ACCESS_OPERATION_STATUS opStatus;
        public short relativeDistance;
        public String memoryBankData;
        public String lockData;
        public int allocatedSize;
        public int count = 0;
    }
}
