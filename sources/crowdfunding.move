/*
/// Module: crowdfunding
module crowdfunding::crowdfunding;
*/
module crowdfunding::crowdfunding{
    use sui::object::{Self, UID, ID};
    use sui::tx_context::{Self, TxContext};

    struct Campaign has key {
        uid: UID,
        target_amount: u64,
        raised_amount: u64
    }

    //add campaign id to the receipt
    struct FundingReceipt has key {
        uid: UID,
        donated_amount: u64
    }

    struct CampaignOwner has key{
        uid: UID,
        campaign_id: ID
    }

    //tx_content provides complete info on the tx being executed
    public entry fun createCampaign(target_amount: u64, ctx: &mut TxContext){
        //as per Move, this is the only way to create UIDs
        let campaign_uid : UID = object::new(ctx);
        //this is the way to extract the ID from the UID
        let campaign_id : ID = object::uid_to_inner(&campaign_uid);

        let campaign : Campaign = Campaign{
            uid : campaign_uid,
            target_amount: target_amount,
            raised_amount: 0
        };

        let campaignOwner : CampaignOwner = CampaignOwner{
            uid : object::new(ctx),
            campaign_id: campaign_id
        };

    }
    //add function donate to the campaign
    //add function withdraw funds
}