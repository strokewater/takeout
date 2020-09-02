package org.project.takeout.pojo;

import org.springframework.stereotype.Component;

import java.util.Set;

@Component("recvAddress")
public class RecvAddress {
    private int id;
    private String address;
    private String name;
    private String phone;
    private Customer customer;

    private Set<GoodOrder> orders;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public Set<GoodOrder> getOrders() {
        return orders;
    }

    public void setOrders(Set<GoodOrder> orders) {
        this.orders = orders;
    }
}
