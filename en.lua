local Translations = {
    error = {        
        no_contraband_sell = 'nu există contrabandă de vândut!',
        not_enough_lawmen_duty = 'nu sunt suficienți oameni ai legii în serviciu!',
        no_contraband_left_sell = 'nu a mai rămas contrabandă de vândut!',
        you_moved_too_far_away = 'te-ai mutat prea departe!',
    },    
    success = {
        offer_accepted = 'ofertă acceptată',
    },
    primary = {
        started_selling_contraband = 'a început să vândă contrabandă',
        stopped_selling_contraband = 'sa oprit să vândă contrabandă',        
        you_have_been_robbed = 'ai fost jefuit!',
        offer_declined = 'ofertă refuzată'
    },
    menu = {
        menu_sell = 'Vinde ',
        menu_for = ' pentru $',
        menu_confirm = '[G] Confirma',
        menu_decline = '[B] Refuza',
        menu_remove_what_was_stolen = '[E] pentru a elimina ce a fost furat',
    },    
    progressbar = {
        var = 'textul vine aici',
    },    
    alert = {
        contraband_being_sold = 'se vinde contrabandă',
    }
} 

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
