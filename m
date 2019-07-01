Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59BDE3D102
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 17:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405139AbfFKPhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 11:37:13 -0400
Received: from mail-eopbgr00081.outbound.protection.outlook.com ([40.107.0.81]:35722
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405103AbfFKPhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 11:37:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JbDta3UAqPFlYbWQqHzVlbX9nQ7MchAydhNYxGUKCfo=;
 b=TxRm03B7nK+ia7dDWDJqd6oFf1HJJLVptHNhlPg611kvRZvkDC34GCYg+CBhEbT7z7gWT/SziTNvg3EpsZpEzwrjN0enXfJ/fqbdSr+Mniuf+gV7Q3xD/biCyLmqxKzNnItzqtufIefNWFxxhdQKTD0xLnLgay38Jvk5nNlJd68=
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com (52.134.3.153) by
 VI1PR0402MB2895.eurprd04.prod.outlook.com (10.175.24.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Tue, 11 Jun 2019 15:37:08 +0000
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::ccaf:f4a1:704a:e745]) by VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::ccaf:f4a1:704a:e745%4]) with mapi id 15.20.1965.017; Tue, 11 Jun 2019
 15:37:08 +0000
From:   Horia Geanta <horia.geanta@nxp.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
CC:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2 0/4] Additional fixes on Talitos driver
Thread-Topic: [PATCH v2 0/4] Additional fixes on Talitos driver
Thread-Index: AQHVIGOH8ah5xSLD4UOplfJkXECTiA==
Date:   Tue, 11 Jun 2019 15:37:08 +0000
Message-ID: <VI1PR0402MB34853CAF031426F4183FE29B98ED0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
References: <cover.1560263641.git.christophe.leroy@c-s.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=horia.geanta@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93651de6-7601-4d33-1601-08d6ee82aa43
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB2895;
x-ms-traffictypediagnostic: VI1PR0402MB2895:
x-microsoft-antispam-prvs: <VI1PR0402MB289572B4325B730E39E2618798ED0@VI1PR0402MB2895.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 006546F32A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(366004)(396003)(39860400002)(189003)(199004)(33656002)(316002)(6246003)(14454004)(110136005)(54906003)(25786009)(4326008)(6436002)(8936002)(81166006)(81156014)(8676002)(7736002)(305945005)(74316002)(53936002)(478600001)(86362001)(53546011)(9686003)(229853002)(55016002)(5660300002)(76116006)(68736007)(71190400001)(66946007)(71200400001)(486006)(73956011)(102836004)(99286004)(52536014)(446003)(186003)(7696005)(476003)(6506007)(76176011)(256004)(66446008)(66476007)(66556008)(64756008)(44832011)(6116002)(3846002)(2906002)(26005)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2895;H:VI1PR0402MB3485.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: R/Dd2TGs3gM3XE09uAGx3zcWyFfECw9h6EPovl1GNLuMe5ZD8NesBT4dnTLKQv2pzeL5nAan5xwKMLL9fpaxTzuykEVCNz9IMxKjFeKRixAP3TLFiIF4mVY7otJC6zr0UhviIDKNdVE1pbtczexZIOwOl7jx7C6akfIwW+M38jUGJR3gab9KA47FNfw6pRBJbFNvA5QHWr86xcBn37rnfGkT4vbWzfLXGKmrZw8mleLFTOGTRWvX4/iR4TCLkTiNfsMRbC064TeFPKOylbGiZ82x6wEchvcpwP+LmG2hnXCrJ4MsRJMqHiq8pAW8HWpLv6ddMd8sfNawpBH8MXzh7cjFzG+OOlKQqUOIf8Kb7S7A/ThshVOHx0x1Lr7dW+DF0K9gk1a+kd6AhZrtqzHwREFkp1e2HQmGo2f3Kh3nvKI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93651de6-7601-4d33-1601-08d6ee82aa43
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2019 15:37:08.8236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: horia.geanta@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2895
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/2019 5:39 PM, Christophe Leroy wrote:=0A=
> This series is the last set of fixes for the Talitos driver.=0A=
> =0A=
> We now get a fully clean boot on both SEC1 (SEC1.2 on mpc885) and=0A=
> SEC2 (SEC2.2 on mpc8321E) with CONFIG_CRYPTO_MANAGER_EXTRA_TESTS:=0A=
> =0A=
I am getting below failures on a sec 3.3.2 (p1020rdb) for hmac(sha384) and=
=0A=
hmac(sha512):=0A=
=0A=
alg: ahash: hmac-sha384-talitos test failed (wrong result) on test vector "=
random: psize=3D2497 ksize=3D124", cfg=3D"random: inplace use_finup nosimd =
src_divs=3D[<reimport>76.49%@+4002, <reimport>23.51%@alignmask+26] iv_offse=
t=3D4"=0A=
alg: ahash: hmac-sha512-talitos test failed (wrong result) on test vector "=
random: psize=3D27 ksize=3D121", cfg=3D"random: inplace may_sleep use_diges=
t src_divs=3D[100.0%@+10] iv_offset=3D9"=0A=
=0A=
Reproducibility rate is 100% so far, here are a few more runs - they might =
help finding a pattern:=0A=
=0A=
1.=0A=
alg: ahash: hmac-sha384-talitos test failed (wrong result) on test vector "=
random: psize=3D184 ksize=3D121", cfg=3D"random: use_finup src_divs=3D[<rei=
mport,nosimd>100.0%@+3988] dst_divs=3D[100.0%@+547] iv_offset=3D44"=0A=
alg: ahash: hmac-sha512-talitos test failed (wrong result) on test vector "=
random: psize=3D7 ksize=3D122", cfg=3D"random: may_sleep use_digest src_div=
s=3D[100.0%@+3968] dst_divs=3D[100.0%@+20]"=0A=
=0A=
2.=0A=
alg: ahash: hmac-sha384-talitos test failed (wrong result) on test vector "=
random: psize=3D6481 ksize=3D120", cfg=3D"random: use_final src_divs=3D[<re=
import>100.0%@+6] dst_divs=3D[43.84%@alignmask+6, 56.16%@+22]"=0A=
alg: ahash: hmac-sha512-talitos test failed (wrong result) on test vector "=
random: psize=3D635 ksize=3D128", cfg=3D"random: may_sleep use_finup src_di=
vs=3D[100.0%@+4062] dst_divs=3D[20.47%@+2509, 72.36%@alignmask+2, 7.17%@ali=
gnmask+3990]"=0A=
=0A=
3.=0A=
alg: ahash: hmac-sha384-talitos test failed (wrong result) on test vector "=
random: psize=3D2428 ksize=3D127", cfg=3D"random: may_sleep use_finup src_d=
ivs=3D[<reimport>35.19%@+18, 64.81%@+1755] dst_divs=3D[100.0%@+111] iv_offs=
et=3D5"=0A=
alg: ahash: hmac-sha512-talitos test failed (wrong result) on test vector "=
random: psize=3D4345 ksize=3D128", cfg=3D"random: may_sleep use_digest src_=
divs=3D[100.0%@+2820] iv_offset=3D59"=0A=
=0A=
If you run several times with fuzz testing enabled on your sec2.2,=0A=
are you able to see similar failures?=0A=
=0A=
Thanks,=0A=
Horia=0A=
