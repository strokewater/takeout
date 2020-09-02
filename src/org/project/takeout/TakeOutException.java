package org.project.takeout;

import java.util.HashMap;
import java.util.Hashtable;
import java.util.concurrent.ConcurrentHashMap;

public class TakeOutException extends Exception {
    private int classCode;
    private int subCode;
    private String message;

    private static ConcurrentHashMap<Integer, ConcurrentHashMap<Integer, String>> table;
    static {
        table = new ConcurrentHashMap<Integer, ConcurrentHashMap<Integer, String>>();
    }

    public static void setException(int newClassCode, int newSubCode, String message)
    {
        ConcurrentHashMap SubCodeTable = table.get(newClassCode);
        if (SubCodeTable == null)
        {
            SubCodeTable = new ConcurrentHashMap();
            table.put(newClassCode, SubCodeTable);
        }
        SubCodeTable.put(newSubCode, message);
    }

    public TakeOutException(int classCode, int subCode)
    {
        this.classCode = classCode;
        this.subCode = subCode;
        this.message = table.get(classCode).get(subCode);
    }

    public int getClassCode() {
        return classCode;
    }

    public int getSubCode() {
        return subCode;
    }

    @Override
    public String getMessage() {
        return message;
    }
}
