package auctionhaus


// Ben Williams

class Customer {
    String email
    String password
    Date   createdDate

    static hasMany = [listings: Listing, bids: Bid]
    static mappedBy = [listings: "seller", bids: "bidder"]

    static constraints = {

        email email:true,blank:false,unique: true
        password size: 6..8,blank:false
        createdDate nullable: false,blank:false

    }
}
