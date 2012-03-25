package auctionhaus

import static org.junit.Assert.*
import org.junit.*
import org.springframework.test.annotation.ExpectedException
import grails.validation.ValidationException

//Amit Thakore and Ben Williams

class BidIntegrationTests extends GroovyTestCase {

    @Before
    void setUp() {
        // Setup logic here
    }

    @After
    void tearDown() {
        // Tear down logic here
    }


    // B-5: The Bid amount must be at least .50 higher than the previous Bid for the same listing (integration test)
    //Test that adding a bid that is not 0.50 higher than previous bid causes validation exception on save. (exceptional case)
    @Test
    void testBidNotHighEnoughCausesError()
    {


        def testEndDateTime = new Date() + 1
        def testSeller = new Customer(email:"amit_thakore1@yahoo.com",password: "1234567",createdDate: new Date())


        def bidTest = new Bid(bidAmount: 20.0, bidDateTime: new Date(), bidder: testSeller)


        def bidTest2 = new Bid(bidAmount: 20.4, bidDateTime: new Date(), bidder: testSeller )


        testSeller.save()

        def testList = new Listing(listingName: "Apple TV",listingEndDateTime: testEndDateTime, startingBidPrice: 10.00, seller:testSeller)
        testList.save()

        testList.addToBids(bidTest)


        testList.addToBids(bidTest2)
        //since bidTest2 is only 0.40 greater than the last bid, it should cause a validation error

        shouldFail(ValidationException){
            bidTest2.save()       //this should cause validation exception
        }





    }


    // B-5: The Bid amount must be at least .50 higher than the previous Bid for the same listing (integration test)
    //Test that adding a bid that is 0.50 higher than previous bid  successfully validates, no error on bidAmount field. (happy path)
    @Test
    void testBidHighEnoughOK()
    {


        def testEndDateTime = new Date() + 1
        def testSeller = new Customer(email:"amit_thakore1@yahoo.com",password: "1234567",createdDate: new Date())


        def bidTest = new Bid(bidAmount: 20.0, bidDateTime: new Date(), bidder: testSeller)


        def bidTest2 = new Bid(bidAmount: 20.5, bidDateTime: new Date(), bidder: testSeller )


        testSeller.save()



        def testList = new Listing(listingName: "Apple TV",listingEndDateTime: testEndDateTime, startingBidPrice: 10.00, seller:testSeller)
        testList.save()

        testList.addToBids(bidTest)

        bidTest.save()

        testList.addToBids(bidTest2)
        //since bidTest2 is 0.50 greater than the last bid, it should not cause a validation error
        bidTest2.save()
        assert bidTest2.validate()

        assert bidTest2.errors['bidAmount'] == null



    }


    // B-6: When a Listing is saved, any new Bids added for the listing must be saved (integration test)
    // Test that bid is saved to db when added to list and list is saved (happy path)
    @Test
    void testListingSavedBidsAlsoSaved()
    {


        def testEndDateTime = new Date() + 1
        def testSeller = new Customer(email:"amit_thakore1@yahoo.com",password: "1234567",createdDate: new Date())


        def bidTest = new Bid(bidAmount: 20.0, bidDateTime: new Date(), bidder: testSeller)



        testSeller.save()

        def testList = new Listing(listingName: "Apple TV",listingEndDateTime: testEndDateTime, startingBidPrice: 10.00, seller:testSeller)


        testList.addToBids(bidTest)



        testList.save()


        //we should find bidTest in the db, because it was added to testList before call to testList.save
        assert (Bid.find(bidTest))




    }

    // B-6: When a Listing is saved, any new Bids added for the listing must be saved (integration test)
    // Test that bid is not saved to db when not added to list and list is saved (excaptional path)
    @Test
    void testListingNotSavedBidsAlsoNotSaved()
    {


        def testEndDateTime = new Date() + 1
        def testSeller = new Customer(email:"amit_thakore1@yahoo.com",password: "1234567",createdDate: new Date())


        def bidTest = new Bid(bidAmount: 20.0, bidDateTime: new Date(), bidder: testSeller)



        testSeller.save()

        def testList = new Listing(listingName: "Apple TV",listingEndDateTime: testEndDateTime, startingBidPrice: 10.00, seller:testSeller)


        //    testList.addToBids(bidTest)



        testList.save()


        //we should find not bidTest in the db, because it was never saved nor added to testList before call to testList.save
        assert (!Bid.find(bidTest))




    }

}
