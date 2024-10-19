/*
/// Module: crowdfunding
module crowdfunding::crowdfunding;
*/
module crowdfunding::crowdfunding{
    use sui::object::{Self, UID, ID};
    use sui::coin::{Self, Coin};
    use sui::balance::{Self, Balance};
    use sui::sui::SUI;

    struct Campaign has key {
        id: UID,
        raised_amount: u64,
        target_amount: u64,
    }

    //add campaign id to the receipt
    //this is some sort of NFT
    struct FundingReceipt has key {
        id: UID,
        donated_amount: u64
    }

    //add function create campaign
    //add function donate to the campaign
    //add function withdraw funds
}