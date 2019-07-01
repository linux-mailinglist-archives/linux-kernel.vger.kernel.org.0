Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C077F4E5C5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 12:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfFUKVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 06:21:11 -0400
Received: from mail-eopbgr50066.outbound.protection.outlook.com ([40.107.5.66]:64732
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726250AbfFUKVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 06:21:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3A4p9Pnv4EC/0TQbCHNhU5vFSTW735fTudNQm6vwHM=;
 b=xXqw9wwXKqFI1JgFI+MjsJdAPiYzFc5CKveGyN+oN031HEEhOR10+TCdGl8F8zIgYcL/EY+AqJ0T0SrMk3J/s1UufMLRCF9eBjMPK+EpzhbV8i/GWROgS5SECsxkmjkKUmIoaUCNnynW276R6tpzQTqFmzDL9HoIbaCZgRABY9g=
Received: from VI1PR08MB3199.eurprd08.prod.outlook.com (52.133.15.150) by
 VI1PR08MB3918.eurprd08.prod.outlook.com (20.178.81.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Fri, 21 Jun 2019 10:21:08 +0000
Received: from VI1PR08MB3199.eurprd08.prod.outlook.com
 ([fe80::fd75:e620:3b39:6712]) by VI1PR08MB3199.eurprd08.prod.outlook.com
 ([fe80::fd75:e620:3b39:6712%7]) with mapi id 15.20.2008.007; Fri, 21 Jun 2019
 10:21:08 +0000
From:   Raymond Smith <Raymond.Smith@arm.com>
To:     "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yuq825@gmail.com" <yuq825@gmail.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>, nd <nd@arm.com>,
        Raymond Smith <Raymond.Smith@arm.com>
Subject: [PATCH] drm/fourcc: Add Arm 16x16 block modifier
Thread-Topic: [PATCH] drm/fourcc: Add Arm 16x16 block modifier
Thread-Index: AQHVKBsKBvRwqAaS30eXmbt21cTJQg==
Date:   Fri, 21 Jun 2019 10:21:08 +0000
Message-ID: <1561112433-5308-1-git-send-email-raymond.smith@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.52]
x-clientproxiedby: LO2P265CA0251.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::23) To VI1PR08MB3199.eurprd08.prod.outlook.com
 (2603:10a6:803:47::22)
x-mailer: git-send-email 2.7.4
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Raymond.Smith@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a05b52d-6092-4bd9-9be4-08d6f6322cb6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB3918;
x-ms-traffictypediagnostic: VI1PR08MB3918:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR08MB391829D0DE9EDAFF3EAF0D45ECE70@VI1PR08MB3918.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:972;
x-forefront-prvs: 0075CB064E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(366004)(346002)(39860400002)(189003)(199004)(6436002)(68736007)(102836004)(6512007)(386003)(6506007)(476003)(54906003)(110136005)(66946007)(73956011)(66556008)(66446008)(64756008)(36756003)(99286004)(2906002)(66476007)(53936002)(14444005)(44832011)(256004)(26005)(186003)(6486002)(2616005)(4744005)(71190400001)(71200400001)(8936002)(7736002)(305945005)(14454004)(2501003)(86362001)(2201001)(25786009)(478600001)(486006)(52116002)(316002)(8676002)(3846002)(81156014)(81166006)(66066001)(6116002)(50226002)(4326008)(72206003)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3918;H:VI1PR08MB3199.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mKBl+fFdbhOvVDneJsZGiV7ZQTPVa0pzICBZe1lPI8okQAeHybD78eA4BiUtTBKp2ZZZKL1PSkWkkf2MloYljeNg6oeN4SrgJFt6yu6jKnjTkiLhLwvBWPlrDqZu0M+6TGDHxnsS2jteFxe98pj3x6OX+b3iYQwrx2FB5Wkkz2RxmU/4Q84S8yS0dDLdRwQOkIAR/ackguOBbB7pYxUp/fBSo6+kSvTdVtC7PEAe4h2/HzQIQmHHYtSsX9ixXphK50iPK9H3uxk9IFuh85Ed0qJD66MN9E71swxiswQVQDhE+f/TYR1nINqI8L01R4Ix40yVMNvxtFS5O+vCu3cGUycYqedFvDlIwTuWLjMt+L+UxHlgM8BTmmu9JNim0opNZInXN6yPILowtUZ46xrP5/hT79H6gdo4cv7muT61QHk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a05b52d-6092-4bd9-9be4-08d6f6322cb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2019 10:21:08.6042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Raymond.Smith@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3918
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIHRoZSBEUk1fRk9STUFUX01PRF9BUk1fMTZYMTZfQkxPQ0tfVV9JTlRFUkxFQVZFRCBtb2Rp
ZmllciB0bw0KZGVub3RlIHRoZSAxNngxNiBibG9jayB1LWludGVybGVhdmVkIGZvcm1hdCB1c2Vk
IGluIEFybSBVdGdhcmQgYW5kDQpNaWRnYXJkIEdQVXMuDQoNClNpZ25lZC1vZmYtYnk6IFJheW1v
bmQgU21pdGggPHJheW1vbmQuc21pdGhAYXJtLmNvbT4NCi0tLQ0KIGluY2x1ZGUvdWFwaS9kcm0v
ZHJtX2ZvdXJjYy5oIHwgMTAgKysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRp
b25zKCspDQoNCmRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvZHJtL2RybV9mb3VyY2MuaCBiL2lu
Y2x1ZGUvdWFwaS9kcm0vZHJtX2ZvdXJjYy5oDQppbmRleCAzZmVlYWEzLi44ZWQ3ZWNmIDEwMDY0
NA0KLS0tIGEvaW5jbHVkZS91YXBpL2RybS9kcm1fZm91cmNjLmgNCisrKyBiL2luY2x1ZGUvdWFw
aS9kcm0vZHJtX2ZvdXJjYy5oDQpAQCAtNzQzLDYgKzc0MywxNiBAQCBleHRlcm4gIkMiIHsNCiAj
ZGVmaW5lIEFGQkNfRk9STUFUX01PRF9CQ0ggICAgICgxVUxMIDw8IDExKQ0KIA0KIC8qDQorICog
QXJtIDE2eDE2IEJsb2NrIFUtSW50ZXJsZWF2ZWQgbW9kaWZpZXINCisgKg0KKyAqIFRoaXMgaXMg
dXNlZCBieSBBcm0gTWFsaSBVdGdhcmQgYW5kIE1pZGdhcmQgR1BVcy4gSXQgZGl2aWRlcyB0aGUg
aW1hZ2UNCisgKiBpbnRvIDE2eDE2IHBpeGVsIGJsb2Nrcy4gQmxvY2tzIGFyZSBzdG9yZWQgbGlu
ZWFybHkgaW4gb3JkZXIsIGJ1dCBwaXhlbHMNCisgKiBpbiB0aGUgYmxvY2sgYXJlIHJlb3JkZXJl
ZC4NCisgKi8NCisjZGVmaW5lIERSTV9GT1JNQVRfTU9EX0FSTV8xNlgxNl9CTE9DS19VX0lOVEVS
TEVBVkVEIFwNCisJZm91cmNjX21vZF9jb2RlKEFSTSwgKCgxVUxMIDw8IDU1KSB8IDEpKQ0KKw0K
Ky8qDQogICogQWxsd2lubmVyIHRpbGVkIG1vZGlmaWVyDQogICoNCiAgKiBUaGlzIHRpbGluZyBt
b2RlIGlzIGltcGxlbWVudGVkIGJ5IHRoZSBWUFUgZm91bmQgb24gYWxsIEFsbHdpbm5lciBwbGF0
Zm9ybXMsDQotLSANCjIuNy40DQoNCg==
