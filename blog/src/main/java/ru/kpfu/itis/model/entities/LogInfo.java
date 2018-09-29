package ru.kpfu.itis.model.entities;

import javax.persistence.*;

@Entity
@Table(name = "logInfo")
public class LogInfo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;


    @Column(name = "date")
    private String date;


    @Column(name = "methodName")
    private String methodName;


    @Column(name = "retValue")
    private String retValue;


    public LogInfo() {
    }

    public LogInfo(String date, String methodName, String args) {
        this.date = date;
        this.methodName = methodName;
        this.retValue = args;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getMethodName() {
        return methodName;
    }

    public void setMethodName(String methodName) {
        this.methodName = methodName;
    }

    public String getRetValue() {
        return retValue;
    }

    public void setRetValue(String retValue) {
        this.retValue = retValue;
    }


    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        LogInfo logInfo = (LogInfo) o;

        if (id != logInfo.id) return false;
        if (!date.equals(logInfo.date)) return false;
        if (!methodName.equals(logInfo.methodName)) return false;
        return retValue != null ? retValue.equals(logInfo.retValue) : logInfo.retValue == null;

    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + date.hashCode();
        result = 31 * result + methodName.hashCode();
        result = 31 * result + (retValue != null ? retValue.hashCode() : 0);
        return result;
    }
}
