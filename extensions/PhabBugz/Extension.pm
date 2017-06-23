# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# This Source Code Form is "Incompatible With Secondary Licenses", as
# defined by the Mozilla Public License, v. 2.0.

package Bugzilla::Extension::PhabBugz;

use 5.10.1;
use strict;
use warnings;
use parent qw(Bugzilla::Extension);

our $VERSION = '0.01';

sub config_add_panels {
    my ($self, $args) = @_;
    my $modules = $args->{panel_modules};
    $modules->{PhabBugz} = "Bugzilla::Extension::PhabBugz::Config";
}

sub auth_delegation_confirm {
    my ($self, $args) = @_;
    my $phab_enabled      = Bugzilla->params->{phabricator_enabled};
    my $phab_callback_url = Bugzilla->params->{phabricator_auth_callback_url};
    my $phab_app_id       = Bugzilla->params->{phabricator_app_id};

    return unless $phab_enabled;
    return unless $phab_callback_url;
    return unless $phab_app_id;

    if (index($args->{callback}, $phab_callback_url) == 0 && $args->{app_id} eq $phab_app_id) {
        ${$args->{skip_confirmation}} = 1;
    }
}

__PACKAGE__->NAME;
