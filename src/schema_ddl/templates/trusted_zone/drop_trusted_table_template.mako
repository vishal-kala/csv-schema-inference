DROP TABLE IF EXISTS ${sf_details['trusted_db']['database']}.${sf_details['trusted_db']['schema']}.${entity['name']};

USE DATABASE DL_CHANGE_MGMT_${'${mdp_suffix}'};
