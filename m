Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1105B1BB24
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 18:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730676AbfEMQkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 12:40:42 -0400
Received: from mail-eopbgr680078.outbound.protection.outlook.com ([40.107.68.78]:57069
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730656AbfEMQkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 12:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/iAmHKB5HOp50e9yMvGnt3MYRpcQk4vsw0oVUTgzCg=;
 b=FraIFcYEJvDnrAxURCgaoLh6K0bdqFU9bbUoYXTFO8YTOWXgP2NvjH+/mWdnr3ZTxXC+3EJ+3vAlHjexMbuHCmyIWNJah0/3c9esERJMsIWu9ESxTLXZ9iDUIvejUwoOAYz/11VRVGbgVOKFjht7duleQ0vXyO7ffRjq5coK7Wk=
Received: from BN8PR10MB3540.namprd10.prod.outlook.com (20.179.78.205) by
 BN8PR10MB3219.namprd10.prod.outlook.com (20.179.138.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.25; Mon, 13 May 2019 16:40:37 +0000
Received: from BN8PR10MB3540.namprd10.prod.outlook.com
 ([fe80::24c5:ea68:cff3:4a16]) by BN8PR10MB3540.namprd10.prod.outlook.com
 ([fe80::24c5:ea68:cff3:4a16%7]) with mapi id 15.20.1878.024; Mon, 13 May 2019
 16:40:37 +0000
From:   Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "leoyang.li@nxp.com" <leoyang.li@nxp.com>,
        "roy.pledge@nxp.com" <roy.pledge@nxp.com>
CC:     "madalin.bucur@nxp.com" <madalin.bucur@nxp.com>,
        "laurentiu.tudor@nxp.com" <laurentiu.tudor@nxp.com>
Subject: Re: [PATCH v1 4/8] soc/fsl/qbman: Use index when accessing device
 tree properties
Thread-Topic: [PATCH v1 4/8] soc/fsl/qbman: Use index when accessing device
 tree properties
Thread-Index: AQHVCadY7pF1Pe9lUE2omDuEjFRsAaZpQd6A
Date:   Mon, 13 May 2019 16:40:36 +0000
Message-ID: <1afd837287cebccfc1dd68365870d0f5d1cf27f7.camel@infinera.com>
References: <1557763756-24118-1-git-send-email-roy.pledge@nxp.com>
         <1557763756-24118-5-git-send-email-roy.pledge@nxp.com>
In-Reply-To: <1557763756-24118-5-git-send-email-roy.pledge@nxp.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Joakim.Tjernlund@infinera.com; 
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe32ae2f-f61f-4c12-e2ba-08d6d7c1ba1b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BN8PR10MB3219;
x-ms-traffictypediagnostic: BN8PR10MB3219:
x-microsoft-antispam-prvs: <BN8PR10MB32191C4D15B5F73E163563E4F40F0@BN8PR10MB3219.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0036736630
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(346002)(366004)(396003)(189003)(199004)(4326008)(7736002)(256004)(102836004)(6246003)(6436002)(73956011)(6486002)(76116006)(66946007)(66556008)(64756008)(66446008)(66476007)(2501003)(2906002)(6506007)(91956017)(81156014)(229853002)(8676002)(81166006)(8936002)(71190400001)(71200400001)(36756003)(6116002)(3846002)(118296001)(5660300002)(53936002)(110136005)(478600001)(72206003)(486006)(4744005)(6512007)(54906003)(14454004)(2201001)(186003)(26005)(11346002)(476003)(2616005)(68736007)(446003)(316002)(86362001)(66066001)(99286004)(25786009)(305945005)(14444005)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR10MB3219;H:BN8PR10MB3540.namprd10.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: infinera.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YGMhfspaPplJ+Kut85Y/tVRjWe+YPzHNvLIKD/8FyHlovAoozvlAhEpkVWmAIR9R/Jfz18sG3PHNPC30ePg1bMIk7NheUaOhHJ3jgzXdsBv2gUSVw3Fd7B5rBHg6FIWjEBhxHy7emw4vyqqFYe6dePSxMnDRJkzVVXwp1nZ6V3wPOeGxYFK+RZB/807Zs+eGW/PUra+jX+gFjhbSzjhRms+7BmYbIiQipZosmcdA1qK+1g1PerqcvFcwyRcITLjEYZeuYx1GBSFuZjjSN9pz6nR90f2dT0NyTlUH2ZP9Ua5h9qe/0+yx5DCaZtyCqj5sup0RYuO8TzfzMuvs6fenkt6+h4ojfWWFOcRlDlVCpTAirZJHH+MFw366X64WCdSLmkfQAshIBntVIsDjmb4tT/pf+OggP6DLBSuTq65P2Dk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <30C6854288C3D8458564DBB4CDD4EDB4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe32ae2f-f61f-4c12-e2ba-08d6d7c1ba1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2019 16:40:36.9214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3219
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTA1LTEzIGF0IDE2OjA5ICswMDAwLCBSb3kgUGxlZGdlIHdyb3RlOg0KPiAN
Cj4gVGhlIGluZGV4IHZhbHVlIHNob3VsZCBiZSBwYXNzZWQgdG8gdGhlIG9mX3BhcnNlX3BoYW5k
bGUoKQ0KPiBmdW5jdGlvbiB0byBlbnN1cmUgdGhlIGNvcnJlY3QgcHJvcGVydHkgaXMgcmVhZC4N
Cg0KSXMgdGhpcyBhIGJ1ZyBmaXg/IE1heWJlIGZvciBzdGFibGUgdG9vPw0KDQogSm9ja2UNCg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogUm95IFBsZWRnZSA8cm95LnBsZWRnZUBueHAuY29tPg0KPiAt
LS0NCj4gIGRyaXZlcnMvc29jL2ZzbC9xYm1hbi9kcGFhX3N5cy5jIHwgMiArLQ0KPiAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9zb2MvZnNsL3FibWFuL2RwYWFfc3lzLmMgYi9kcml2ZXJzL3NvYy9mc2wvcWJt
YW4vZHBhYV9zeXMuYw0KPiBpbmRleCAzZTBhN2YzLi4wYjkwMWE4IDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL3NvYy9mc2wvcWJtYW4vZHBhYV9zeXMuYw0KPiArKysgYi9kcml2ZXJzL3NvYy9mc2wv
cWJtYW4vZHBhYV9zeXMuYw0KPiBAQCAtNDksNyArNDksNyBAQCBpbnQgcWJtYW5faW5pdF9wcml2
YXRlX21lbShzdHJ1Y3QgZGV2aWNlICpkZXYsIGludCBpZHgsIGRtYV9hZGRyX3QgKmFkZHIsDQo+
ICAgICAgICAgICAgICAgICAgICAgICAgIGlkeCwgcmV0KTsNCj4gICAgICAgICAgICAgICAgIHJl
dHVybiAtRU5PREVWOw0KPiAgICAgICAgIH0NCj4gLSAgICAgICBtZW1fbm9kZSA9IG9mX3BhcnNl
X3BoYW5kbGUoZGV2LT5vZl9ub2RlLCAibWVtb3J5LXJlZ2lvbiIsIDApOw0KPiArICAgICAgIG1l
bV9ub2RlID0gb2ZfcGFyc2VfcGhhbmRsZShkZXYtPm9mX25vZGUsICJtZW1vcnktcmVnaW9uIiwg
aWR4KTsNCj4gICAgICAgICBpZiAobWVtX25vZGUpIHsNCj4gICAgICAgICAgICAgICAgIHJldCA9
IG9mX3Byb3BlcnR5X3JlYWRfdTY0KG1lbV9ub2RlLCAic2l6ZSIsICZzaXplNjQpOw0KPiAgICAg
ICAgICAgICAgICAgaWYgKHJldCkgew0KPiAtLQ0KPiAyLjcuNA0KPiANCg0K
