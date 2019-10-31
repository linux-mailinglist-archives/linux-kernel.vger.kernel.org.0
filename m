Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA15EB5F6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 18:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbfJaRRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 13:17:20 -0400
Received: from mga06.intel.com ([134.134.136.31]:39904 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728672AbfJaRRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 13:17:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Oct 2019 10:17:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,252,1569308400"; 
   d="scan'208";a="211608055"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga001.fm.intel.com with ESMTP; 31 Oct 2019 10:17:19 -0700
Received: from fmsmsx114.amr.corp.intel.com ([169.254.6.30]) by
 fmsmsx107.amr.corp.intel.com ([169.254.6.52]) with mapi id 14.03.0439.000;
 Thu, 31 Oct 2019 10:17:18 -0700
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "cai@lca.pw" <cai@lca.pw>,
        "Williams, Dan J" <dan.j.williams@intel.com>
CC:     "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Busch, Keith" <keith.busch@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>
Subject: Re: [PATCH v3] nvdimm/btt: fix variable 'rc' set but not used
Thread-Topic: [PATCH v3] nvdimm/btt: fix variable 'rc' set but not used
Thread-Index: AQHVj/RKt9JEPUybdkSDhqnJiJ6bv6d1c4eA
Date:   Thu, 31 Oct 2019 17:17:18 +0000
Message-ID: <ab127750fc543ec236dc241255c70dd30abc6f21.camel@intel.com>
References: <1572530719-32161-1-git-send-email-cai@lca.pw>
In-Reply-To: <1572530719-32161-1-git-send-email-cai@lca.pw>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.164]
Content-Type: text/plain; charset="utf-8"
Content-ID: <DDB80CDF46CFFA46B59DDCF5A958C2D1@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTEwLTMxIGF0IDEwOjA1IC0wNDAwLCBRaWFuIENhaSB3cm90ZToNCj4gZHJp
dmVycy9udmRpbW0vYnR0LmM6IEluIGZ1bmN0aW9uICdidHRfcmVhZF9wZyc6DQo+IGRyaXZlcnMv
bnZkaW1tL2J0dC5jOjEyNjQ6ODogd2FybmluZzogdmFyaWFibGUgJ3JjJyBzZXQgYnV0IG5vdCB1
c2VkDQo+IFstV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlXQ0KPiAgICAgaW50IHJjOw0KPiAgICAg
ICAgIF5+DQo+IA0KPiBBZGQgYSByYXRlbGltaXRlZCBtZXNzYWdlIGluIGNhc2UgYSBzdG9ybSBv
ZiBlcnJvcnMgaXMgZW5jb3VudGVyZWQuDQo+IA0KPiBGaXhlczogZDliODNjNzU2OTUzICgibGli
bnZkaW1tLCBidHQ6IHJld29yayBlcnJvciBjbGVhcmluZyIpDQo+IFNpZ25lZC1vZmYtYnk6IFFp
YW4gQ2FpIDxjYWlAbGNhLnB3Pg0KPiAtLS0NCj4gdjM6IHJlbW92ZSB0aGUgdW51c2VkICJyYyIg
cGVyIFZpc2hhbC4NCj4gdjI6IGluY2x1ZGUgdGhlIGJsb2NrIGFkZHJlc3MgdGhhdCBpcyByZXR1
cm5pbmcgYW4gZXJyb3IgcGVyIERhbi4NCj4gDQo+ICBkcml2ZXJzL252ZGltbS9idHQuYyB8IDgg
KysrKy0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25z
KC0pDQoNCkxvb2tzIGdvb2QsDQpSZXZpZXdlZC1ieTogVmlzaGFsIFZlcm1hIDx2aXNoYWwubC52
ZXJtYUBpbnRlbC5jb20+DQoNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252ZGltbS9idHQu
YyBiL2RyaXZlcnMvbnZkaW1tL2J0dC5jDQo+IGluZGV4IDNlOWY0NWFlYzhkMS4uNTEyOTU0M2Ew
NDczIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL252ZGltbS9idHQuYw0KPiArKysgYi9kcml2ZXJz
L252ZGltbS9idHQuYw0KPiBAQCAtMTI2MSwxMSArMTI2MSwxMSBAQCBzdGF0aWMgaW50IGJ0dF9y
ZWFkX3BnKHN0cnVjdCBidHQgKmJ0dCwgc3RydWN0IGJpb19pbnRlZ3JpdHlfcGF5bG9hZCAqYmlw
LA0KPiAgDQo+ICAJCXJldCA9IGJ0dF9kYXRhX3JlYWQoYXJlbmEsIHBhZ2UsIG9mZiwgcG9zdG1h
cCwgY3VyX2xlbik7DQo+ICAJCWlmIChyZXQpIHsNCj4gLQkJCWludCByYzsNCj4gLQ0KPiAgCQkJ
LyogTWVkaWEgZXJyb3IgLSBzZXQgdGhlIGVfZmxhZyAqLw0KPiAtCQkJcmMgPSBidHRfbWFwX3dy
aXRlKGFyZW5hLCBwcmVtYXAsIHBvc3RtYXAsIDAsIDEsDQo+IC0JCQkJTlZESU1NX0lPX0FUT01J
Qyk7DQo+ICsJCQlpZiAoYnR0X21hcF93cml0ZShhcmVuYSwgcHJlbWFwLCBwb3N0bWFwLCAwLCAx
LCBOVkRJTU1fSU9fQVRPTUlDKSkNCj4gKwkJCQlkZXZfd2Fybl9yYXRlbGltaXRlZCh0b19kZXYo
YXJlbmEpLA0KPiArCQkJCQkiRXJyb3IgcGVyc2lzdGVudGx5IHRyYWNraW5nIGJhZCBibG9ja3Mg
YXQgJSN4XG4iLA0KPiArCQkJCQlwcmVtYXApOw0KPiAgCQkJZ290byBvdXRfcnR0Ow0KPiAgCQl9
DQo+ICANCg0K
