Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F80FAF87D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2019 11:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfIKJFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Sep 2019 05:05:55 -0400
Received: from mail-eopbgr10085.outbound.protection.outlook.com ([40.107.1.85]:45730
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726889AbfIKJFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 05:05:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zdx4Ap8Mt8cDQThthX5MAVSiqnpgoJ7Nr1iKTrDtcBPHqQtiWSYblPcP7IqAWNCc3u5tBhs19o31jiEFRuT8CJKHRGKJiopOtGC/Ni6Ha5NOObZKhdJI42t4SeARt81r7hNSx4RwTIwi6wwN3M4yHy9BkCdK/JB9+ajMOdnydzYMT7SCQspc9cD3GWF2dWEHN+tHHHtWnZVfchn9PImqtOWPhy3433KpqmVo+VJo2nV++dXbFYevGpD5pxg09glRC5NtOmuEc2Z+Bd1Dc9OhFRF66JJvTBNYW95JdmmmGNW/jCbEWGNc+gjn6x6UHKTfl5YSPF+MkdEDWlr/BOH/rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shYRdOn542kr59cJ/yeN+B6cSnvXUnMqxkIDkhbu4bc=;
 b=HVOQdnEl0dGSR9KZYSE2V5IdgBpwwaJMixnPY+qwkTVQlRf0nrqM+jGfB7FCka3RyAQxH+RoDMThKJaQ5Qr/dD7+NoOFDHsNKJi/jdK4LZjm0WEGhIkm8fQIEJxCzO5LO3Vu7pGgkEgDgMwp7/Mguq5fAW0dS+mSO491PiuPCOGA2EZtdDKDEiF0jOoXsrTy1Tqu+TIibJzQR4yUo3i215eArr1dVnZ0HIAVkmJflp887cknGgN6f1VWOeBBIeQ65r+etn0d2X+gUZLEL/74ljGzgnxIWp2HD6xxRWMlLMdBYZipaCttxAuszlBfBvswRnoRXvuYAb33Bt3qjKiUnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shYRdOn542kr59cJ/yeN+B6cSnvXUnMqxkIDkhbu4bc=;
 b=ivJzrRiOo9nSR8aurEgupzhbXokVusL5gzCy5naAqoAWfYTiTupA5iV/fUF+HU/nHFfm88Gyeqj+MdPkAKkDk0CS7ri+tEdWZCypZRyQ4B3wFdMJ0DsFAHJgWp15vtHlsL7qg2CHXj9u360kgzgwmIOK90O1ul1fC4aCql50KfY=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3738.eurprd04.prod.outlook.com (52.134.70.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.20; Wed, 11 Sep 2019 09:05:49 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::8958:299c:bc54:2a38]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::8958:299c:bc54:2a38%7]) with mapi id 15.20.2241.018; Wed, 11 Sep 2019
 09:05:49 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>, Jun Li <jun.li@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/2] arm64: dts: imx8mm: Remove incorrect fallback
 compatible for ocotp
Thread-Topic: [PATCH 1/2] arm64: dts: imx8mm: Remove incorrect fallback
 compatible for ocotp
Thread-Index: AQHVaEhGKGtAvaf22kyiQ0mRpSHPJKcmLmYAgAAA3GA=
Date:   Wed, 11 Sep 2019 09:05:49 +0000
Message-ID: <DB3PR0402MB3916E0F566E35DD30275A8E9F5B10@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1568211887-19318-1-git-send-email-Anson.Huang@nxp.com>
 <749f8dc6-dbf9-127c-9924-33432b8af00a@linaro.org>
In-Reply-To: <749f8dc6-dbf9-127c-9924-33432b8af00a@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b583f22-ec72-49e8-dff3-08d736973da5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB3PR0402MB3738;
x-ms-traffictypediagnostic: DB3PR0402MB3738:|DB3PR0402MB3738:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3738E8AF6540EE7D19DA906EF5B10@DB3PR0402MB3738.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0157DEB61B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(189003)(199004)(25786009)(99286004)(7696005)(478600001)(6436002)(76176011)(186003)(53936002)(6246003)(4326008)(9686003)(55016002)(14444005)(5660300002)(44832011)(486006)(52536014)(11346002)(446003)(476003)(256004)(26005)(14454004)(102836004)(53546011)(6506007)(71190400001)(71200400001)(64756008)(66476007)(66556008)(66446008)(66946007)(76116006)(66066001)(305945005)(74316002)(3846002)(7736002)(8936002)(81166006)(8676002)(81156014)(7416002)(229853002)(110136005)(316002)(2501003)(6116002)(2906002)(86362001)(2201001)(33656002)(32563001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3738;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HaAE6X+nIqMlETLTELSVZgQVNHC5rml4qe9QNewN9KHrHIqd8L6QXNa7Y/x+JTCJr5RFPeXAlF/ze82+WZl67+LvC8mtLdiIm5Zbx05ksJ/JeBQrNxj8Mux/wGHXc72fXbIke02piiAQbt/H6S31BeWm7tkpnzFYqe1SiLsSN7Zjm6bzV9paAZcmaANGECbdbeo0usSSlyicCKCJN/BPe9GZ+b9JBogAvedNIGWeKv3EQPjyi5UwjTC8F/Y9eDDCl4o1kHRW7OAPVobj9tgmBP6FLUgyCD8I/LlXItzsL0YfMLCK2Yy+aoBHdF5R0p7fYIX0TRT68CLtns/nxkcDkA3samqEH8EZe8wDBGPhPhoN8tElcozsHN2KWzRWeAlXhJDaraRbSeCTZknmepBRWDxtX5nEfgD63xQt/z3sY9o=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b583f22-ec72-49e8-dff3-08d736973da5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2019 09:05:49.7297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: veAKiUd828/ci5usBnO9ImFmz8gF2AtUiELTdlEoDzIOkM2IARYXh4WVv76kbNQZrlUTb+cI/TZLHKkgcM1BEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3738
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIERhbmllbA0KDQo+IE9uIDExLzA5LzIwMTkgMTY6MjQsIEFuc29uIEh1YW5nIHdyb3RlOg0K
PiA+IENvbXBhcmVkIHRvIGkuTVg3RCwgaS5NWDhNTSBoYXMgZGlmZmVyZW50IG9jb3RwIGxheW91
dCwgc28gaXQgc2hvdWxkDQo+ID4gTk9UIHVzZSAiZnNsLGlteDdkLW9jb3RwIiBhcyBvY290cCdz
IGZhbGxiYWNrIGNvbXBhdGlibGUsIHJlbW92ZSBpdC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBhcmNoL2Fy
bTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0uZHRzaSB8IDIgKy0NCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0
IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLmR0c2kNCj4gPiBiL2FyY2gv
YXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS5kdHNpDQo+ID4gaW5kZXggNWY5ZDBkYS4u
N2M0ZGNjZSAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9p
bXg4bW0uZHRzaQ0KPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDht
bS5kdHNpDQo+ID4gQEAgLTQyNiw3ICs0MjYsNyBAQA0KPiA+ICAJCQl9Ow0KPiA+DQo+ID4gIAkJ
CW9jb3RwOiBvY290cC1jdHJsQDMwMzUwMDAwIHsNCj4gPiAtCQkJCWNvbXBhdGlibGUgPSAiZnNs
LGlteDhtbS1vY290cCIsICJmc2wsaW14N2QtDQo+IG9jb3RwIiwgInN5c2NvbiI7DQo+ID4gKwkJ
CQljb21wYXRpYmxlID0gImZzbCxpbXg4bW0tb2NvdHAiLCAic3lzY29uIjsNCj4gPiAgCQkJCXJl
ZyA9IDwweDMwMzUwMDAwIDB4MTAwMDA+Ow0KPiA+ICAJCQkJY2xvY2tzID0gPCZjbGsgSU1YOE1N
X0NMS19PQ09UUF9ST09UPjsNCj4gPiAgCQkJCS8qIEZvciBudm1lbSBzdWJub2RlcyAqLw0KPiAN
Cj4gV2h5IG5vdCBmb2xkIHRoZSB0d28gcGF0Y2hlcz8NCg0KRm9yIGkuTVg4TU0sIGl0IGp1c3Qg
cmVtb3ZlcyB0aGUgaW5jb3JyZWN0IGZhbGxiYWNrIGNvbXBhdGlibGUsIGZvciBpLk1YOE1OLCBp
dCBuZWVkcw0KdG8gcmVwbGFjZSB0aGUgaW5jb3JyZWN0IGZhbGxiYWNrIGNvbXBhdGlibGUgaW4g
b3JkZXIgdG8gc3VwcG9ydCBTb0MgVUlEIHJlYWQsIHNvIEkgdGhpbmsNCnRoaXMgc2hvdWxkIGJl
IDIgc2VwYXJhdGUgcGF0Y2g/DQoNClRoYW5rcywNCkFuc29uLg0K
