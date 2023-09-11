% if is_first:
-- Begin --
-- Script to count rows for all the necessary entities --

use role ${sf_details['role']};
use warehouse ${sf_details['warehouse']};
use database ${sf_details['trusted_db']['database']};
use schema ${sf_details['trusted_db']['schema']};

% endif

SELECT COUNT(1) FROM ${sf_details['trusted_db']['database']}.${sf_details['trusted_db']['schema']}.${entity['name']} ;
