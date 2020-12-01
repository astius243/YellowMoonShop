/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package huonglh.models;

import huonglh.entities.OrderDetail;
import java.io.Serializable;
import java.util.HashMap;

/**
 *
 * @author Hau Huong
 */
public class ShoppingCart implements Serializable {

    private String customerName;
    private HashMap<Integer, OrderDetail> cart;
    private int total;

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public HashMap<Integer, OrderDetail> getCart() {
        return cart;
    }

    public ShoppingCart() {
        this.customerName = "Guest";
        this.cart = new HashMap<>();
    }

    public void addToCart(OrderDetail orderDetail) throws Exception {
        if (this.cart.containsKey(orderDetail.getCakeID().getCakeID())) {
            int quantity = (this.cart.get(orderDetail.getCakeID().getCakeID()).getQuantities() + 1);
            orderDetail.setQuantities(quantity);
        }
        this.cart.put(orderDetail.getCakeID().getCakeID(), orderDetail);
    }

    public void remove(int id) throws Exception {
        if (this.cart.containsKey(id)) {
            this.cart.remove(id);
        }
    }

    public void updateCart(int id, int quantity) throws Exception {
        if (this.cart.containsKey(id)) {
            this.cart.get(id).setQuantities(quantity);
        }
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public int getTotal() {
        int result = 0;
        for (OrderDetail orderDetail : this.cart.values()) {
            result += orderDetail.getCakeID().getPrice() * orderDetail.getQuantities();
        }
        return result;
    }
}
