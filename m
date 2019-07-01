Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47D391BA9F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 18:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730943AbfEMQJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 12:09:45 -0400
Received: from mail-eopbgr10059.outbound.protection.outlook.com ([40.107.1.59]:4487
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729246AbfEMQJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 12:09:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IvVfZvDXhHgsToo9rsa2yRoEmdO/XZBarL2I0ixnMEM=;
 b=R1oRvdRcApFq4o8ZV/+4UMG7SSWfobC5C9Yjebw/arozFwjeLI3CTJRuJtB2iefRfoAguc1lUJDyAoKKvF/J3naqr1OjoBQx/LHsS6jaN61yu3PGwGxk49j5xp7zeYwOrWukbEcWt/L+kQlnyFgw0E8BTyCKflhJIjlQWAkItms=
Received: from DB6PR0402MB2727.eurprd04.prod.outlook.com (10.172.247.10) by
 DB6PR0402MB2709.eurprd04.prod.outlook.com (10.172.246.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.25; Mon, 13 May 2019 16:09:38 +0000
Received: from DB6PR0402MB2727.eurprd04.prod.outlook.com
 ([fe80::e194:a71a:3497:783e]) by DB6PR0402MB2727.eurprd04.prod.outlook.com
 ([fe80::e194:a71a:3497:783e%8]) with mapi id 15.20.1878.024; Mon, 13 May 2019
 16:09:38 +0000
From:   Roy Pledge <roy.pledge@nxp.com>
To:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>
CC:     Madalin-cristian Bucur <madalin.bucur@nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Roy Pledge <roy.pledge@nxp.com>
Subject: [PATCH v1 0/8] soc/fsl/qbman: Enable Kexec for DPAA1 devices
Thread-Topic: [PATCH v1 0/8] soc/fsl/qbman: Enable Kexec for DPAA1 devices
Thread-Index: AQHVCaZDNJ/dr3CnPEu8McjjpTjPxA==
Date:   Mon, 13 May 2019 16:09:38 +0000
Message-ID: <1557763756-24118-1-git-send-email-roy.pledge@nxp.com>
Reply-To: Roy Pledge <roy.pledge@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: SN4PR0501CA0144.namprd05.prod.outlook.com
 (2603:10b6:803:2c::22) To DB6PR0402MB2727.eurprd04.prod.outlook.com
 (2603:10a6:4:98::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=roy.pledge@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [72.142.119.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9eca5315-cdde-484b-99f1-08d6d7bd6639
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB6PR0402MB2709;
x-ms-traffictypediagnostic: DB6PR0402MB2709:
x-microsoft-antispam-prvs: <DB6PR0402MB27091F8FF49E9912538E4A2F860F0@DB6PR0402MB2709.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0036736630
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(366004)(376002)(396003)(39860400002)(189003)(199004)(81166006)(81156014)(8936002)(2201001)(110136005)(54906003)(316002)(476003)(2501003)(86362001)(2616005)(50226002)(2906002)(66556008)(64756008)(66446008)(66946007)(66476007)(73956011)(478600001)(3450700001)(6636002)(305945005)(5660300002)(386003)(6506007)(102836004)(43066004)(6486002)(7736002)(26005)(186003)(6436002)(66066001)(4326008)(36756003)(99286004)(486006)(25786009)(52116002)(53936002)(44832011)(6512007)(8676002)(14454004)(68736007)(71200400001)(14444005)(256004)(3846002)(71190400001)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0402MB2709;H:DB6PR0402MB2727.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: v+q+po0cCEZ1xYPTx6j+Hpe48x1KF8lVOXr79xc27Trm50F/g9KI47KGd+jdTzLHvl3E92yr7Lnhtuw9Dd7s0+RHU9fshSJZcILhcnj6Z0vX0Ms+tgebOYSkTbURltecMlL8fPb63wQsnPNz0gGmgJYYQnCGxkhiIgs1r1/nupWGrq0o8VG6nI68Bov3F1RbEm4Q7yYx5aLE1WFPtaSRZ0qBVfDF0rszrZqM1aPtEWqoO4u3yDBKc0GGTn6wR/2ajxBibO0YL7lG6zNbCIVdlXoqc50y3s5PYwQf50SbX5KA9JpJzp8ac+3TQnw3UKNbwU3iNYWVS/mXke/KYU1D1WGlg6m83E2kNE96qDEYRkflIn8u6VQBChVTQ3ZqnyaZOfDn4Ws/JfOWdGUM8EYa02ZEoH4Nv5phNHWqgSoWGwY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eca5315-cdde-484b-99f1-08d6d7bd6639
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2019 16:09:38.6828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2709
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TW9zdCBEUEFBMSBkZXZpY2VzIGRvIG5vdCBzdXBwb3J0IGEgc29mdCByZXNldCB3aGljaCBpcyBh
biBpc3N1ZSBpZg0KS2V4ZWMgc3RhcnRzIGEgbmV3IGtlcm5lbC4gVGhpcyBwYXRjaCBzZXJpZXMg
YWxsb3dzIEtleGVjIHRvIGZ1bmN0aW9uDQpieSBkZXRlY3RpbmcgdGhhdCB0aGUgUUJNYW4gZGV2
aWNlIHdhcyBwcmV2aW91c2x5IGluaXRpYWxpemVkLg0KDQpUaGUgcGF0Y2hlcyBmaXggc29tZSBp
c3N1ZXMgd2l0aCBkZXZpY2UgY2xlYW51cCBhcyB3ZWxsIGFzIGVuc3VyaW5nDQp0aGF0IHRoZSBs
b2NhdGlvbiBvZiB0aGUgUUJNYW4gcHJpdmF0ZSBtZW1vcmllcyBoYXMgbm90IGNoYW5nZWQNCmFm
dGVyIHRoZSBleGVjdXRpb24gb2YgdGhlIEtleGVjLg0KDQpSb3kgUGxlZGdlICg4KToNCiAgc29j
L2ZzbC9xYm1hbjogUmV3b3JrIFFCTWFuIHByaXZhdGUgbWVtb3J5IHNldHVwDQogIHNvYy9mc2wv
cWJtYW46IENsZWFudXAgYnVmZmVyIHBvb2xzIGlmIEJNYW4gd2FzIGluaXRpYWxpemVkIHByaW9y
IHRvDQogICAgYm9vdHVwDQogIHNvYy9mc2wvcWJtYW46IENsZWFudXAgUU1hbiBxdWV1ZXMgaWYg
ZGV2aWNlIHdhcyBhbHJlYWR5IGluaXRpYWxpemVkDQogIHNvYy9mc2wvcWJtYW46IFVzZSBpbmRl
eCB3aGVuIGFjY2Vzc2luZyBkZXZpY2UgdHJlZSBwcm9wZXJ0aWVzDQogIHNvYy9mc2wvcWJtYW46
IEZpeCBkcmFpbl9tcl9mcW5pKCkNCiAgc29jL2ZzbC9xYm1hbjogRGlzYWJsZSBpbnRlcnJ1cHRz
IGR1cmluZyBwb3J0YWwgcmVjb3ZlcnkNCiAgc29jL2ZzbC9xYm1hbjogRml4dXAgcW1hbl9zaHV0
ZG93bl9mcSgpDQogIHNvYy9mc2wvcWJtYW46IFVwZGF0ZSBkZXZpY2UgdHJlZSB3aXRoIHJlc2Vy
dmVkIG1lbW9yeQ0KDQogZHJpdmVycy9zb2MvZnNsL3FibWFuL2JtYW4uYyAgICAgICAgfCAxNyAr
KysrLS0tLQ0KIGRyaXZlcnMvc29jL2ZzbC9xYm1hbi9ibWFuX2Njc3IuYyAgIHwgMzYgKysrKysr
KysrKysrKysrLQ0KIGRyaXZlcnMvc29jL2ZzbC9xYm1hbi9ibWFuX3BvcnRhbC5jIHwgMTggKysr
KysrKy0NCiBkcml2ZXJzL3NvYy9mc2wvcWJtYW4vYm1hbl9wcml2LmggICB8ICA1ICsrKw0KIGRy
aXZlcnMvc29jL2ZzbC9xYm1hbi9kcGFhX3N5cy5jICAgIHwgNjMgKysrKysrKysrKysrKysrKy0t
LS0tLS0tLS0tLQ0KIGRyaXZlcnMvc29jL2ZzbC9xYm1hbi9xbWFuLmMgICAgICAgIHwgODMgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLQ0KIGRyaXZlcnMvc29jL2ZzbC9xYm1h
bi9xbWFuX2Njc3IuYyAgIHwgNTkgKysrKysrKysrKysrKysrKysrKysrKystLS0NCiBkcml2ZXJz
L3NvYy9mc2wvcWJtYW4vcW1hbl9wb3J0YWwuYyB8IDE4ICsrKysrKystDQogZHJpdmVycy9zb2Mv
ZnNsL3FibWFuL3FtYW5fcHJpdi5oICAgfCAgOCArKysrDQogOSBmaWxlcyBjaGFuZ2VkLCAyNDYg
aW5zZXJ0aW9ucygrKSwgNjEgZGVsZXRpb25zKC0pDQoNCi0tDQoyLjcuNA0KDQo=
