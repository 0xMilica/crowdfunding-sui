/*
/// Module: crowdfunding
module crowdfunding::crowdfunding;
*/
module crowdfunding::crowdfunding{
    use sui::object::{Self, UID, ID};
    use sui::coin::{Self, Coin};
    use sui::balance::{Self, Balance};
    use sui::sui::SUI;

    struct Fund has key {
        id: UID,
        target: u64, // in USD 
        raised: Balance<SUI>,
    }
}