/*
/// Module: crowdfunding
module crowdfunding::crowdfunding;
*/
module crowdfunding::crowdfunding{
    use sui::object::{Self, UID, ID};
    use sui::tx_context::{Self, TxContext};
    use sui::transfer;
    use sui::event;
    use std::string;

    //event though this is UID type, we can't name it 'uid'
    //we have to name it 'id'
    struct Campaign has key {
        id: UID,
        target_amount: u64,
        raised_amount: u64
    }

    //add campaign id to the receipt
    struct FundingReceipt has key {
        id: UID,
        donated_amount: u64
    }

    //object that proves the ownership over the campaign
    struct CampaignOwner has key {
        id: UID,
        campaign_id: ID
    }

     struct CampaignFunded has copy, drop {
        message: string::String
    }

    //tx_content provides complete info on the tx being executed
    public entry fun createCampaign(target_amount: u64, ctx: &mut TxContext){
        //as per Move, this is the only way to create UIDs
        let campaign_uid : UID = object::new(ctx);
        //this is the way to extract the ID from the UID
        let campaign_id : ID = object::uid_to_inner(&campaign_uid);

        let campaign : Campaign = Campaign{
            id : campaign_uid,
            target_amount: target_amount,
            raised_amount: 0
        };

        let campaignOwner : CampaignOwner = CampaignOwner{
            id : object::new(ctx),
            campaign_id: campaign_id
        };

        transfer::transfer(campaignOwner, tx_context::sender(ctx));

        transfer::share_object(campaign);
    }
    //add function donate to the campaign
    public entry fun donate(campaign : &mut Campaign, amount: u64, ctx: &mut TxContext){
        let donated_amount = amount;

        //add the amount to the campaign
        campaign.raised_amount = campaign.raised_amount + amount;

        //check if the campaign reashed it's terget amount
        if (campaign.raised_amount >= campaign.target_amount){
            event::emit(CampaignFunded {message : string::utf8(b"Thanks to the community effort, we made ZK education accessible to everyone!!!")} );
        };

        let fundingReceipt = FundingReceipt{
            id : object::new(ctx),
            donated_amount : amount
        };

        transfer::transfer(fundingReceipt, tx_context::sender(ctx));
    }
    //add function withdraw funds
}