package com.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;

@Entity
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int pID;
    private String pName;
    @Column(length = 3000)
    private String pDesc;
    private String pPhoto;
    private int pPrice;
    private int pDiscount;
    private int pQuantity;
    
    @ManyToOne
    private Category category;
    
    public Product() {
    }

    public Product(String pName, String pDesc, String pPhoto, int pPrice, int pDiscount, int pQuantity, Category category) {
        this.pName = pName;
        this.pDesc = pDesc;
        this.pPhoto = pPhoto;
        this.pPrice = pPrice;
        this.pDiscount = pDiscount;
        this.pQuantity = pQuantity;
        this.category = category;
    }

    public Product(int pID, String pName, String pDesc, int pPrice, int pDiscount, int pQuantity, Category category) {
        this.pID = pID;
        this.pName = pName;
        this.pDesc = pDesc;
        this.pPrice = pPrice;
        this.pDiscount = pDiscount;
        this.pQuantity = pQuantity;
        this.category = category;
    }

    public int getpID() {
        return pID;
    }

    public void setpID(int pID) {
        this.pID = pID;
    }

    public String getpName() {
        return pName;
    }

    public void setpName(String pName) {
        this.pName = pName;
    }

    public String getpDesc() {
        return pDesc;
    }

    public void setpDesc(String pDesc) {
        this.pDesc = pDesc;
    }

    public String getpPhoto() {
        return pPhoto;
    }

    public void setpPhoto(String pPhoto) {
        this.pPhoto = pPhoto;
    }

    public int getpPrice() {
        return pPrice;
    }

    public void setpPrice(int pPrice) {
        this.pPrice = pPrice;
    }

    public int getpDiscount() {
        return pDiscount;
    }

    public void setpDiscount(int pDiscount) {
        this.pDiscount = pDiscount;
    }

    public int getpQuantity() {
        return pQuantity;
    }

    public void setpQuantity(int pQuantity) {
        this.pQuantity = pQuantity;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    @Override
    public String toString() {
        return "Product [pID=" + pID + ", pName=" + pName + ", pDesc=" + pDesc + ", pPhoto=" + pPhoto + ", pPrice="
                + pPrice + ", pDiscount=" + pDiscount + ", pQuantity=" + pQuantity + ", category=" + category + "]";
    }
    
    public int getOriginalPrice() {
        int price = (int) Math.floor(this.getpPrice() - (this.getpPrice() * this.getpDiscount() / 100));
        return price;
    }
}
