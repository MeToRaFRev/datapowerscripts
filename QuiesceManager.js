if (!session.parameters.REST) session.parameters.REST = 'https://localhost:5554';
if (!session.parameters.Domain) session.parameters.Domain = 'default';
if (!session.parameters.Enable) session.parameters.Enable = true;

var urlopen = require('urlopen');

var quiesceRequest = {
	target: session.parameters.REST + '/mgmt/actionqueue/' + session.parameters.Domain,
	method: 'POST',
	headers: {
		'Accept': 'application/json',
		'Content-Type': 'application/json'
	},
	timeout: 60,
};

if (session.parameters.Enable == true) {
	quiesceRequest.data = {
		"DomainQuiesce": {
			"name": session.parameters.Domain,
			"timeout": 60
		}
	};
} else {
	quiesceRequest.data = {
		"DomainUnquiesce": {
			"name": session.parameters.Domain
		}
	}
};


urlopen.open(quiesceRequest, function(error, response) {
	if (error) {
		if (session.parameters.Enable == true) {
			console.error('error: ' + error + ' info: connection failed trying to quiesce');
			return;
		}
		console.error('error: ' + error + ' info: connection failed trying to unquiesce');
		return;
	} else {
		if (session.parameters.Enable == true) {
			console.error('quiesce:success');
			return;
		}
		console.error('unquiesce:success');
		return;
	}
});
