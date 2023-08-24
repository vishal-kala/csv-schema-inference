% if is_first:
-- Begin --
-- Script to rollback table creations --

use role ${sf_details['role']};
use warehouse ${sf_details['role']};
use database ${sf_details['raw_db']['database']};
use schema ${sf_details['raw_db']['schema']};
% endif

DROP TABLE ${sf_details['raw_db']['database']}.${sf_details['raw_db']['schema']}.${table['name']};

% if is_last:
-- End --
% endif
