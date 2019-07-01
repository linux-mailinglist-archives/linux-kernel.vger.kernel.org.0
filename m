Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C34713CC7D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 15:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389088AbfFKNGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 09:06:50 -0400
Received: from mail-eopbgr60087.outbound.protection.outlook.com ([40.107.6.87]:6151
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387657AbfFKNGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 09:06:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrP61buTAKkrf9XBLNaLEX/WD9IK9ciutw6xqLObRuw=;
 b=Mr91wHySm3bYHta+SYjsb+kVqv1X2hq3n+NEdba+kjR5Ep9x7jDgmT/j/DGJmBO3aGQg/bg6m9cFV/xbE2i62XA5J5s670sbl9e1tvOa/sHbbmKUhOEH6wusPj97XCVahshj/hzrXWYC93HLcPS4pGZCj0SrpVJHso2j1ikGlI8=
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com (52.134.3.153) by
 VI1PR0402MB3631.eurprd04.prod.outlook.com (52.134.7.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.14; Tue, 11 Jun 2019 13:06:44 +0000
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::ccaf:f4a1:704a:e745]) by VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::ccaf:f4a1:704a:e745%4]) with mapi id 15.20.1965.017; Tue, 11 Jun 2019
 13:06:43 +0000
From:   Horia Geanta <horia.geanta@nxp.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
CC:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v1 2/5] crypto: talitos - move struct talitos_edesc into
 talitos.h
Thread-Topic: [PATCH v1 2/5] crypto: talitos - move struct talitos_edesc into
 talitos.h
Thread-Index: AQHVHFtoqsM5u9K3R0ScM4yhQppwKQ==
Date:   Tue, 11 Jun 2019 13:06:43 +0000
Message-ID: <VI1PR0402MB348502A280D64F8A0636AABB98ED0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
References: <cover.1559819372.git.christophe.leroy@c-s.fr>
 <108a23c4d2f0803b1302bc00c7321d799e42edc1.1559819372.git.christophe.leroy@c-s.fr>
 <VI1PR0402MB3485848D81EF07419EB0128F98ED0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
 <a3474daf-3e51-4ce9-0634-8690c2e3045d@c-s.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=horia.geanta@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 83e59f19-f2f3-46e1-f122-08d6ee6da6fc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB3631;
x-ms-traffictypediagnostic: VI1PR0402MB3631:
x-microsoft-antispam-prvs: <VI1PR0402MB3631C81949894F3317DFED2C98ED0@VI1PR0402MB3631.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 006546F32A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(396003)(366004)(39860400002)(199004)(189003)(26005)(53546011)(74316002)(6506007)(81156014)(81166006)(8936002)(76176011)(305945005)(7736002)(4744005)(110136005)(54906003)(102836004)(3846002)(55016002)(25786009)(6116002)(8676002)(99286004)(256004)(5660300002)(9686003)(6246003)(68736007)(66476007)(6436002)(66066001)(64756008)(71190400001)(4326008)(66446008)(66556008)(476003)(186003)(73956011)(33656002)(76116006)(52536014)(66946007)(486006)(86362001)(446003)(316002)(44832011)(229853002)(53936002)(71200400001)(14454004)(7696005)(478600001)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3631;H:VI1PR0402MB3485.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: R8+sYJdQaeonek/JE1XE6DA59bOJJHS1b78QLmcmRVHq6KS2HepzNA/aLvVRM8FMHIrNFq85S0KNJDuCg6yG4g9X2hovSw5nzf9xBkgiuDHHHsH5ymbGni9ABsaoYwr6qmM0Lyvb43yuFeGuF82hTtGP06vqv1pqRGe/+zTWObCSteFY2C1Di3HGuWCwof/W5BKMnrD0SnscJsbi7LVJQhK9GXAi98qDmhGwKwuw5dwBSk+DCwETM2MG6i+TpsTHcWVEeL0rDJvGaO8zryTJieEnoc0R1qqWI3NRrgVrVBum/VjIPx+N/gtZOw2y4Q3/czuNM9e9GW51yInF2sgPHmqEQQeKLxW8MM9ar429SbOAH5LuzClNloJsOFyPe82y4NCvAFzhOLUBYJw0mL1A9no5QJuuXduY+BKF0dAWH3o=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e59f19-f2f3-46e1-f122-08d6ee6da6fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2019 13:06:43.8575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: horia.geanta@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3631
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/2019 3:38 PM, Christophe Leroy wrote:=0A=
> =0A=
> =0A=
> Le 11/06/2019 =E0 13:57, Horia Geanta a =E9crit=A0:=0A=
>> On 6/6/2019 2:31 PM, Christophe Leroy wrote:=0A=
>>> Next patch will require struct talitos_edesc to be defined=0A=
>>> earlier in talitos.c=0A=
>>>=0A=
>>> This patch moves it into talitos.h so that it can be used=0A=
>>> from any place in talitos.c=0A=
>>>=0A=
>>> Fixes: 37b5e8897eb5 ("crypto: talitos - chain in buffered data for ahas=
h on SEC1")=0A=
>> This isn't really a fix, so please drop the tag.=0A=
> =0A=
> As the next patch requires this one and Fixes 37b5e8897eb5, by setting =
=0A=
> Fixes: 37b5e8897eb5 here was for me a way to tell stable that this one =
=0A=
> is required for the following one.=0A=
> =0A=
> Otherwise, how can I ensure that this one will be taken when next one is =
=0A=
> taken ?=0A=
> =0A=
If you want these patches to be automatically sent to -stable (once they=0A=
are merged in main tree), then add a Cc: <stable@vger.kernel.org> tag.=0A=
=0A=
Horia=0A=
