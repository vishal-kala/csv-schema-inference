% if is_first:
-- Begin --
-- Script to rollback table creations --

use role ${sf_details['role']};
use warehouse ${sf_details['warehouse']};
use database ${sf_details['trusted_db']['database']};
use schema ${sf_details['trusted_db']['schema']};
% endif

DROP TABLE ${sf_details['trusted_db']['database']}.${sf_details['trusted_db']['schema']}.${entity['name']};

% if is_last:
-- End --
% endif
