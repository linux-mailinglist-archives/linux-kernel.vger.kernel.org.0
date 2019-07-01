Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B103E43CBA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 17:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbfFMPhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 11:37:22 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:62965 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732733AbfFMPhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 11:37:19 -0400
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.63,369,1557212400"; 
   d="scan'208";a="37402039"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jun 2019 08:37:18 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 13 Jun 2019 08:37:16 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 13 Jun 2019 08:37:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIktsP4cJ0Blel6UI4Q+F0NVGLYjA+/zCrWlpWxqb78=;
 b=CYJMshuw4WJff2zwcLVM2mkIPP6/ZgjWDKnAdMMqTWZoZo4ACk6Ng//iCz/aGkYAysK3WlptcsQ2t9YWgKU5l1R3biXO4Nn4dhn6Gxewbu413xwTXh8Losb2T9BvRP4DmMyduCWsc2Wb+fsq4ol5euPmhZgjp/CntXRGvyDeeJg=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1822.namprd11.prod.outlook.com (10.175.54.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Thu, 13 Jun 2019 15:37:16 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::316b:7774:8db6:30ec]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::316b:7774:8db6:30ec%7]) with mapi id 15.20.1987.012; Thu, 13 Jun 2019
 15:37:16 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <claudiu.beznea@gmail.com>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH 3/7] clk: at91: sckc: add support to free slow clock
 osclillator
Thread-Topic: [PATCH 3/7] clk: at91: sckc: add support to free slow clock
 osclillator
Thread-Index: AQHVIf3gvS79G8XBBE+EsYEDTZKNnA==
Date:   Thu, 13 Jun 2019 15:37:15 +0000
Message-ID: <1560440205-4604-4-git-send-email-claudiu.beznea@microchip.com>
References: <1560440205-4604-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1560440205-4604-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0174.eurprd09.prod.outlook.com
 (2603:10a6:800:120::28) To MWHPR11MB1549.namprd11.prod.outlook.com
 (2603:10b6:301:c::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 409c25a2-15dc-4d97-2a7f-08d6f01502f6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR11MB1822;
x-ms-traffictypediagnostic: MWHPR11MB1822:
x-microsoft-antispam-prvs: <MWHPR11MB1822E0C9072E10B4A5A5231587EF0@MWHPR11MB1822.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:418;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(366004)(376002)(39860400002)(396003)(189003)(199004)(14454004)(478600001)(110136005)(54906003)(256004)(68736007)(2906002)(72206003)(316002)(71200400001)(71190400001)(2501003)(36756003)(50226002)(4326008)(107886003)(25786009)(6512007)(8676002)(8936002)(81156014)(2616005)(476003)(446003)(11346002)(6436002)(6486002)(81166006)(5660300002)(66066001)(99286004)(305945005)(4744005)(53936002)(7736002)(52116002)(76176011)(66946007)(3846002)(6116002)(86362001)(486006)(66446008)(66556008)(186003)(26005)(6506007)(73956011)(386003)(102836004)(64756008)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1822;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: v1ztfQLERIFHIsBepzEBPmZfMFWkWbC6YbEsZ/4mPjxKHMRUVnDaiGWdh4rlY1Xgjqiu2zWhv+o1zTlCx0SnZs6nQFqWSzJcT9nmDWCLOxcgvE7ZZaN4U672XJ992J0lqa6geMZ4hQO82xAzn+fNyQ2qIfxddLC9LNAkp8z2095R7OJWteaPkph9RubUVCL1Eb5FTaJJe+/XlNBAkiiZiZrfhMOZBWx/Hh5AwhcytwuphaJIoNrKaiKFCX2eeiAoJVCzZpU5E6G2TWwuqAWkHVGTQ+72GXpoW7VAo2ZLGn7lwnD7gzOjGumhk1N3gJvhE5avD8Yia4WVTMbDFUMaOZg+wLqsDA0ya8G/QpAVBd6qDBuLjL0ftsulEqai4fwWKtY5v687He+9QE6ECZXDwF0YKNzeYsjzRNMHif+fF4A=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 409c25a2-15dc-4d97-2a7f-08d6f01502f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 15:37:15.8884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: claudiu.beznea@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQoNCkFk
ZCBzdXBwb3J0IHRvIGZyZWUgc2xvdyBjbG9jayBvc2NpbGxhdG9yIHJlc291cmNlcy4NCg0KU2ln
bmVkLW9mZi1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+
DQotLS0NCiBkcml2ZXJzL2Nsay9hdDkxL3Nja2MuYyB8IDggKysrKysrKysNCiAxIGZpbGUgY2hh
bmdlZCwgOCBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9hdDkxL3Nj
a2MuYyBiL2RyaXZlcnMvY2xrL2F0OTEvc2NrYy5jDQppbmRleCA0OTJiMTM5YTdjMTUuLjJhNjc3
YzU2ZjkwMSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvY2xrL2F0OTEvc2NrYy5jDQorKysgYi9kcml2
ZXJzL2Nsay9hdDkxL3Nja2MuYw0KQEAgLTM1NSw2ICszNTUsMTQgQEAgYXQ5MV9jbGtfcmVnaXN0
ZXJfc2FtOXg1X3Nsb3codm9pZCBfX2lvbWVtICpzY2tjciwNCiAJcmV0dXJuIGh3Ow0KIH0NCiAN
CitzdGF0aWMgdm9pZCBhdDkxX2Nsa191bnJlZ2lzdGVyX3NhbTl4NV9zbG93KHN0cnVjdCBjbGtf
aHcgKmh3KQ0KK3sNCisJc3RydWN0IGNsa19zYW05eDVfc2xvdyAqc2xvd2NrID0gdG9fY2xrX3Nh
bTl4NV9zbG93KGh3KTsNCisNCisJY2xrX2h3X3VucmVnaXN0ZXIoaHcpOw0KKwlrZnJlZShzbG93
Y2spOw0KK30NCisNCiBzdGF0aWMgdm9pZCBfX2luaXQgYXQ5MXNhbTl4NV9zY2tjX3JlZ2lzdGVy
KHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAsDQogCQkJCQkgICAgdW5zaWduZWQgaW50IHJjX29zY19z
dGFydHVwX3VzLA0KIAkJCQkJICAgIGNvbnN0IHN0cnVjdCBjbGtfc2xvd19iaXRzICpiaXRzKQ0K
LS0gDQoyLjcuNA0KDQo=
