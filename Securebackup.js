if (!session.parameters.REST) session.parameters.REST = 'https://localhost:5554';
if (!session.parameters.Domain) session.parameters.Domain = 'default';
if (!session.parameters.Certificate) session.parameters.Certificate = 'skipValidation';
if (!session.parameters.Destination) session.parameters.Destination = 'ftp://admin:admin@127.0.0.1';

var sm = require('service-metadata');
var hm = require('header-metadata');
var urlopen = require('urlopen');
sm.setVar('var://service/mpgw/skip-backside', true);

var secureBackupRequest = {
	target: session.parameters.REST + '/mgmt/actionqueue/' + session.parameters.Domain,
	method: 'POST',
	headers: {
		'Accept': 'application/json',
		'Content-Type': 'application/json'
	},
	timeout: 60,
	data: {
		"SecureBackup": {
			"cert": session.parameters.Certificate,
			"destination": session.parameters.Destination
		}
	}
};


urlopen.open(secureBackupRequest, function(error, response) {
	if (error) {
		console.error('error: ' + error + ' info: connection failed trying to secure backup');
		return;
	} else {
		console.error('secure-backup: success');
	}
});
