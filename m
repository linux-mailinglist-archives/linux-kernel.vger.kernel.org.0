Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8F5F16C28C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 14:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730148AbgBYNjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 08:39:48 -0500
Received: from mail-db8eur05on2068.outbound.protection.outlook.com ([40.107.20.68]:6081
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729602AbgBYNjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 08:39:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYOqOiVNvWI6NsqzCX5dEBrjZjkDDadp3Qzvwry/A+MzVzZ9ivKPMZEmQVKqwJiGyJGmKKLbzV1FptjrIkGUXLcOD87AMKIM2PA6jLj1EYi8PlhjT3IR4dACAHBKVCCnh7jBS0f58uj4QqKOMWQZS4c2qqWiTY5QasRIOtg8RlP56VlARZTFwEaFy8bHXJdOtf3RL37cp9O8M1b0Ui74fa6xevOPrCyFgHaz9AOUKISl3EqaB7F2L663zK8nv1XEC8n+o4UQTiamov9Cou1vFiw1Lp3Y/+wGRmVI8RR6h2fpZ3xS6fVu1N0L7/aHfdIzPLhNWBCI4MwXfNoiP0HA8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MdaQfyRbeHEkAESmyzeQ0IZZaFXVk8OWr4bJ52L5xvE=;
 b=cKyEplqRsImplauw4WRD8Nf8H+EuSM4AwktKOdW4NOm9Kwwqq3VpvIG3nSiEgK22iWtLTkNHncaDU3Wv4LJL8AOdvtcwpwxjgImN6FznSL9SI/K4lLIOATWIf6PyqrvqAa9apb00aQ2mpJtEqVA9HNC18uPV2w0pihRlvuM9WebnYlAcmMqq/5tpp/AM8yXMDJGjrL+FCGTquoKnNN+6e62G/Q53o+vpb40IQ/Ddr/2EQ4h0JFuHWFnSMgLXWqjYn1t/sfNqxMVY3GiGEHBjkj8LkXE6XpxLRyCmS+4+xkMThRZC/N9b66BzknWE65SP3nluFbXZFa4h3+Z/tUESWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MdaQfyRbeHEkAESmyzeQ0IZZaFXVk8OWr4bJ52L5xvE=;
 b=KiUKguGcVTSTEPdbQ/Fy/z70rIko31Tn33adDnQlL4fykTALEFIphCyDgSq3QovpJSBPDsA4ymD62GnkKGLye9Y7ivYJteZIR+Tte6SR2xERlR5DXgW9uoC9RdupOnjz8hDpTgS4gBb0bemoEXiVB3/SmDHCqmHpojp4BW2i5ZU=
Received: from VI1PR0402MB3839.eurprd04.prod.outlook.com (52.134.16.147) by
 VI1PR0402MB2734.eurprd04.prod.outlook.com (10.172.255.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Tue, 25 Feb 2020 13:39:43 +0000
Received: from VI1PR0402MB3839.eurprd04.prod.outlook.com
 ([fe80::8881:e155:f058:c0d1]) by VI1PR0402MB3839.eurprd04.prod.outlook.com
 ([fe80::8881:e155:f058:c0d1%4]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 13:39:43 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>,
        "Daniel Baluta (OSS)" <daniel.baluta@oss.nxp.com>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH] ASoC: fsl: Add generic CPU DAI driver
Thread-Topic: [PATCH] ASoC: fsl: Add generic CPU DAI driver
Thread-Index: AQHV1endWlacWLF960CV3VuNFcs0VqgsE0OAgAAC+gA=
Date:   Tue, 25 Feb 2020 13:39:43 +0000
Message-ID: <c1c56c52-656c-cc06-02d1-abefd330ebc8@nxp.com>
References: <20200128144707.21833-1-daniel.baluta@oss.nxp.com>
 <CAOMZO5CKda0TEai5CDdkmADNSMnn3WvY_xD42a=PMpzUFO4Z-w@mail.gmail.com>
In-Reply-To: <CAOMZO5CKda0TEai5CDdkmADNSMnn3WvY_xD42a=PMpzUFO4Z-w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1ee9ce09-dae9-4e58-8c66-08d7b9f82bc4
x-ms-traffictypediagnostic: VI1PR0402MB2734:|VI1PR0402MB2734:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB27346707F82971AF71FA203EF9ED0@VI1PR0402MB2734.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 0324C2C0E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(396003)(136003)(366004)(346002)(199004)(189003)(66946007)(6506007)(2616005)(31696002)(110136005)(76116006)(186003)(2906002)(26005)(6486002)(316002)(54906003)(64756008)(66556008)(66476007)(66446008)(71200400001)(36756003)(44832011)(4326008)(86362001)(5660300002)(4744005)(53546011)(8676002)(81166006)(81156014)(31686004)(8936002)(6512007)(478600001)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2734;H:VI1PR0402MB3839.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZwRnqtggfqXMtK8bXMUYxEY3uHTSRNdN+vzLxQqp+YAU5s6nFiL2LpcPg0MQLfx9hEJ3WJ+hMGBrEr5OGFJGxoqYYnuhIY5RFPz5hQ4GDkFgb4rSI4vOkhOBPiVbI3V6BEaPckEt3IR8eklw2B5L1sa6CH6caAs5yP3nDuTEZXTrO73mazjJMXEztbmPf31+2lzagMDyTUbnSulJLjNJzc9H1t+0tQXx/6l3O93jJ0GmwCuJxIrKD/6q5BDEA6TsUyzzLmIvIMqrke/ItfAq9vZD2bbtnaMMbPJIRhgbEd1MBdR+/naJp8qRWGX0Re/MzD5zEubAHpBjzk2TaQ6WMeQ3F5Xxlvk3eTTWD0zKyI7oehBSojkmHvYvN2CJ3xKtAAtBNEeT+kq+nHs7YGFJhevzBUrHU2aHfGojrqqX54+7sMKWuNhfLvdhqVlwKAwtHNsVb9QHKhccCq397BmRDr4bRYCaPd6ynJSdeQVkUYXXCaFuPZwyZO3cY7/oP8Y5
x-ms-exchange-antispam-messagedata: m3HKLXKl/afU6/ZwUVzOOCTSlL1s2NahS0U7FmoJ64w7Du1fkpu9lMG24HA9yTiyvhaDkNXofyT/rT5RzyKVIspioJyzuc81m5ldp8w+imbbGGXx31/EqAl6rAZnvRc7S52bMXuRHbxf+I/einB4bg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <99217B1ED332554493BB3F3EC0F659A1@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee9ce09-dae9-4e58-8c66-08d7b9f82bc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2020 13:39:43.2114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GrFea58jDesGEMo3cCb863OrdYtaOU4WbKqofym/EXcNkpvad0Vxp2XFgh/T019JDv5pd1pjyVN2wlaFWC2hnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2734
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjUuMDIuMjAyMCAxNToyOSwgRmFiaW8gRXN0ZXZhbSB3cm90ZToNCj4gT24gVHVlLCBKYW4g
MjgsIDIwMjAgYXQgMTE6NDcgQU0gRGFuaWVsIEJhbHV0YSAoT1NTKQ0KPiA8ZGFuaWVsLmJhbHV0
YUBvc3MubnhwLmNvbT4gd3JvdGU6DQo+DQo+PiArc3RhdGljIHN0cnVjdCBzbmRfc29jX2RhaV9k
cml2ZXIgZnNsX2VzYWlfZGFpID0gew0KPj4gKyAgICAgICAubmFtZSA9ICJlc2FpMCIsDQo+PiAr
fTsNCj4+ICsNCj4+ICtzdGF0aWMgc3RydWN0IHNuZF9zb2NfZGFpX2RyaXZlciBmc2xfc2FpX2Rh
aSA9IHsNCj4+ICsgICAgICAgLm5hbWUgPSAic2FpMSIsDQo+IFNvIHRoZSBuYW1lIHdpbGwgYmUg
aGFyZGNvZGVkIHRvIHNhaTEgZXZlbiBpZiBTQUkyLCBTQUkzLCBldGMgaXMgdXNlZD8NCg0KDQpJ
bmRlZWQgdGhpcyBpcyBhIGdvb2QgcG9pbnQuIEluIG91ciB1c2UgY2FzZSB3aXRoIERTUCB3ZSBh
cmUgb25seSB1c2luZyANClNBSTEvRVNBSTAgZm9yIG5vdy4NCg0KTGV0IG1lIHRyeSB0byBnZXQg
YSBtb3JlIGdlbmVyaWMgYXBwcm9hY2ggYW5kIHJlc2VuZC4NCg0KDQp0aGFua3MsDQoNCkRhbmll
bC4NCg0K
