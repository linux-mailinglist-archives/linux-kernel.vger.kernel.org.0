Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61DAF15D75
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 08:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfEGGe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 02:34:27 -0400
Received: from mail-eopbgr20080.outbound.protection.outlook.com ([40.107.2.80]:19686
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726313AbfEGGe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 02:34:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1Q2FZsYY3vbWjfn0prNgNpJLLp8TZ8gQqvtbBVmk1Y=;
 b=beiwwmctpztq2c88Bxdxr6g1cB2aQxt39G9enquJkk83SZue9K0VEC9T0xknh8BmAT7KnrHQMB4uV2dTZkZL9uI5YcA6NafuNdVy8efk9rXmTvd72jpEy3D05aFNJv4cSK9AmFLh2h0cfn6pHzhfOUk+gPuu+GuT8Hw7G9yFY+o=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3771.eurprd04.prod.outlook.com (52.134.67.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Tue, 7 May 2019 06:34:20 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1856.012; Tue, 7 May 2019
 06:34:20 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 1/5] ARM: dts: imx6qdl-sabresd: Assign corresponding power
 supply for LDOs
Thread-Topic: [PATCH 1/5] ARM: dts: imx6qdl-sabresd: Assign corresponding
 power supply for LDOs
Thread-Index: AQHVBJ7nuea/KlQRjEGwfGMejxLbMw==
Date:   Tue, 7 May 2019 06:34:20 +0000
Message-ID: <1557210565-4457-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0302CA0014.apcprd03.prod.outlook.com
 (2603:1096:202::24) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a714587-abec-42c7-6717-08d6d2b60954
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3771;
x-ms-traffictypediagnostic: DB3PR0402MB3771:
x-microsoft-antispam-prvs: <DB3PR0402MB3771F99C553D07215FD9A9A4F5310@DB3PR0402MB3771.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(376002)(346002)(136003)(189003)(199004)(6486002)(66066001)(68736007)(26005)(386003)(6506007)(186003)(102836004)(86362001)(2616005)(110136005)(14454004)(316002)(2201001)(52116002)(2501003)(5660300002)(99286004)(6116002)(2906002)(3846002)(4326008)(6512007)(6436002)(476003)(486006)(25786009)(36756003)(256004)(53936002)(305945005)(66476007)(66556008)(64756008)(66446008)(50226002)(478600001)(81156014)(81166006)(8676002)(8936002)(71190400001)(7736002)(73956011)(66946007)(71200400001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3771;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yxJJqcvpMgYErHX5kh+eHX731Mrpr38UwFzGpfEhl5Wp5+qCo0O/DcBlkS3GvSytzh+bNGDdLWMKxUjxZ+jd7heNnzkGWHFvWgHY1/CBE+KJHPJUo9Q1fL7g8+lQ2NqsjuCLNz80LWQkSZFZsGt7Q7LUQaOYc17MLGP5wjWG4iup3jBDM3noj52RjxyX2tHDQAnspWt6VdGkh9vjILOMLwylgMvBC3il1sShspBbiSMOFbZMD3cUE69c5o3jEA21vXVCnpTXMnjvo6TDJkHDEPh4ujZdz37CYrD/zc+7aOL8a/uhZA+VeDIE+60XfBrgsRsBMEHECeQZk6pmYuJyoqnud8fL6ogB1VAEAHtN1fcsZ5LEF72GEHtPEcUnAiFmucYkZ30Pw2tvFC5AIFWwBF6/HIrhHhOTCfnwfmGUTYk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a714587-abec-42c7-6717-08d6d2b60954
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 06:34:20.6234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3771
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gaS5NWDZRL0RMIFNhYnJlU0QgYm9hcmQsIHZnZW41IHN1cHBsaWVzIHZkZDFwMS92ZGQycDUg
TERPIGFuZA0Kc3cyIHN1cHBsaWVzIHZkZDNwMCBMRE8sIHRoaXMgcGF0Y2ggYXNzaWducyBjb3Jy
ZXNwb25kaW5nIHBvd2VyDQpzdXBwbHkgZm9yIHZkZDFwMS92ZGQycDUvdmRkM3AwIHRvIGF2b2lk
IGNvbmZ1c2lvbiBieSBiZWxvdyBsb2c6DQoNCnZkZDFwMTogc3VwcGxpZWQgYnkgcmVndWxhdG9y
LWR1bW15DQp2ZGQzcDA6IHN1cHBsaWVkIGJ5IHJlZ3VsYXRvci1kdW1teQ0KdmRkMnA1OiBzdXBw
bGllZCBieSByZWd1bGF0b3ItZHVtbXkNCg0KV2l0aCB0aGlzIHBhdGNoLCB0aGUgcG93ZXIgc3Vw
cGx5IGlzIG1vcmUgYWNjdXJhdGU6DQoNCnZkZDFwMTogc3VwcGxpZWQgYnkgVkdFTjUNCnZkZDNw
MDogc3VwcGxpZWQgYnkgU1cyDQp2ZGQycDU6IHN1cHBsaWVkIGJ5IFZHRU41DQoNClNpZ25lZC1v
ZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KLS0tDQogYXJjaC9hcm0v
Ym9vdC9kdHMvaW14NnFkbC1zYWJyZXNkLmR0c2kgfCAxMiArKysrKysrKysrKysNCiBhcmNoL2Fy
bS9ib290L2R0cy9pbXg2cWRsLmR0c2kgICAgICAgICB8ICA2ICsrKy0tLQ0KIDIgZmlsZXMgY2hh
bmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2Fy
Y2gvYXJtL2Jvb3QvZHRzL2lteDZxZGwtc2FicmVzZC5kdHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMv
aW14NnFkbC1zYWJyZXNkLmR0c2kNCmluZGV4IDE4NWZiMTcuLjExMTAzYTQgMTAwNjQ0DQotLS0g
YS9hcmNoL2FybS9ib290L2R0cy9pbXg2cWRsLXNhYnJlc2QuZHRzaQ0KKysrIGIvYXJjaC9hcm0v
Ym9vdC9kdHMvaW14NnFkbC1zYWJyZXNkLmR0c2kNCkBAIC03NDUsNiArNzQ1LDE4IEBADQogICAg
ICAgIHZpbi1zdXBwbHkgPSA8JnN3MWNfcmVnPjsNCiB9Ow0KIA0KKyZyZWdfdmRkMXAxIHsNCisJ
dmluLXN1cHBseSA9IDwmdmdlbjVfcmVnPjsNCit9Ow0KKw0KKyZyZWdfdmRkM3AwIHsNCisJdmlu
LXN1cHBseSA9IDwmc3cyX3JlZz47DQorfTsNCisNCismcmVnX3ZkZDJwNSB7DQorCXZpbi1zdXBw
bHkgPSA8JnZnZW41X3JlZz47DQorfTsNCisNCiAmc252c19wb3dlcm9mZiB7DQogCXN0YXR1cyA9
ICJva2F5IjsNCiB9Ow0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZxZGwuZHRz
aSBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZxZGwuZHRzaQ0KaW5kZXggNjY0ZjdiNS4uOTI5ZmM3
ZCAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZxZGwuZHRzaQ0KKysrIGIvYXJj
aC9hcm0vYm9vdC9kdHMvaW14NnFkbC5kdHNpDQpAQCAtNzAxLDcgKzcwMSw3IEBADQogCQkJCQkg
ICAgIDwwIDU0IElSUV9UWVBFX0xFVkVMX0hJR0g+LA0KIAkJCQkJICAgICA8MCAxMjcgSVJRX1RZ
UEVfTEVWRUxfSElHSD47DQogDQotCQkJCXJlZ3VsYXRvci0xcDEgew0KKwkJCQlyZWdfdmRkMXAx
OiByZWd1bGF0b3ItMXAxIHsNCiAJCQkJCWNvbXBhdGlibGUgPSAiZnNsLGFuYXRvcC1yZWd1bGF0
b3IiOw0KIAkJCQkJcmVndWxhdG9yLW5hbWUgPSAidmRkMXAxIjsNCiAJCQkJCXJlZ3VsYXRvci1t
aW4tbWljcm92b2x0ID0gPDEwMDAwMDA+Ow0KQEAgLTcxNiw3ICs3MTYsNyBAQA0KIAkJCQkJYW5h
dG9wLWVuYWJsZS1iaXQgPSA8MD47DQogCQkJCX07DQogDQotCQkJCXJlZ3VsYXRvci0zcDAgew0K
KwkJCQlyZWdfdmRkM3AwOiByZWd1bGF0b3ItM3AwIHsNCiAJCQkJCWNvbXBhdGlibGUgPSAiZnNs
LGFuYXRvcC1yZWd1bGF0b3IiOw0KIAkJCQkJcmVndWxhdG9yLW5hbWUgPSAidmRkM3AwIjsNCiAJ
CQkJCXJlZ3VsYXRvci1taW4tbWljcm92b2x0ID0gPDI4MDAwMDA+Ow0KQEAgLTczMSw3ICs3MzEs
NyBAQA0KIAkJCQkJYW5hdG9wLWVuYWJsZS1iaXQgPSA8MD47DQogCQkJCX07DQogDQotCQkJCXJl
Z3VsYXRvci0ycDUgew0KKwkJCQlyZWdfdmRkMnA1OiByZWd1bGF0b3ItMnA1IHsNCiAJCQkJCWNv
bXBhdGlibGUgPSAiZnNsLGFuYXRvcC1yZWd1bGF0b3IiOw0KIAkJCQkJcmVndWxhdG9yLW5hbWUg
PSAidmRkMnA1IjsNCiAJCQkJCXJlZ3VsYXRvci1taW4tbWljcm92b2x0ID0gPDIyNTAwMDA+Ow0K
LS0gDQoyLjcuNA0KDQo=
