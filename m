Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8EA6013C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2019 09:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbfGEHDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jul 2019 03:03:51 -0400
Received: from mail-eopbgr80048.outbound.protection.outlook.com ([40.107.8.48]:37345
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725827AbfGEHDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 03:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pc7H8JZvi5b5UBWgWjaKfr+XUoJO+fPtC8xJ63htuLk=;
 b=PrezOeEJn+Px6OHq/TmJCADMukMTFav+xRbm4Jw0uLoHqmqsXl/ga5auMBgK42FLMmrog+anVicUg/0/g2g4GFQ3fvv6yUujEtAeobd8CFCTTYmBF1fEP9WHRVRtv1AzO0thhTs5w2WjPjUMq4wzPed1pwfAakQK/ddRO34bY04=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6734.eurprd04.prod.outlook.com (20.179.234.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Fri, 5 Jul 2019 07:03:48 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::9818:813d:1b75:61fe]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::9818:813d:1b75:61fe%7]) with mapi id 15.20.2032.019; Fri, 5 Jul 2019
 07:03:48 +0000
From:   "S.j. Wang" <shengjiu.wang@nxp.com>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
CC:     "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 2/2] ASoC: fsl_esai: recover the channel swap after
 xrun
Thread-Topic: [PATCH V2 2/2] ASoC: fsl_esai: recover the channel swap after
 xrun
Thread-Index: AdUy/vnfzjEA6p6XSCSN/32Dn+RQkA==
Date:   Fri, 5 Jul 2019 07:03:47 +0000
Message-ID: <VE1PR04MB64796C22C2D41B9A45E726BEE3F50@VE1PR04MB6479.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 704f6f43-6dc0-4db1-9421-08d70116ed66
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR04MB6734;
x-ms-traffictypediagnostic: VE1PR04MB6734:
x-microsoft-antispam-prvs: <VE1PR04MB67346B87306CAD03C691E4DFE3F50@VE1PR04MB6734.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 008960E8EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(189003)(199004)(478600001)(71190400001)(6116002)(66066001)(3846002)(486006)(71200400001)(53936002)(9686003)(8676002)(256004)(81156014)(14454004)(81166006)(4744005)(5660300002)(186003)(68736007)(14444005)(6436002)(33656002)(8936002)(229853002)(66556008)(74316002)(6916009)(55016002)(6246003)(476003)(54906003)(99286004)(305945005)(102836004)(7696005)(7736002)(66446008)(2906002)(6506007)(52536014)(26005)(64756008)(66476007)(1411001)(316002)(66946007)(86362001)(76116006)(25786009)(73956011)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6734;H:VE1PR04MB6479.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XG4zzy2vM7nLn5q66oq9XBTbKzr6dpxGugTy5iiSDGvPgCcLKjr0PA8E4adTLJO7uVHWevY7v+4zz4FP+p0nnOLmi7TXzxyBAQGLim5qWhGOM7Ysv2gwqRh9diJ2SpFGF8Cr8nFH2LS3mVz9KtdMOaKnIsfoMKcr2RKtvce7B4H7F3Avs3aNFS6e1mTbJzaVyI9azy2EC9r/7i8Aj4a2GbngTle7xzD5piOiqom+Il+Q9XQY5FtrkNInbilPioAWXwqFwxtbxe+onS2qwil4SzyQP8eGhdWkwJ5jK746efxb1QVHk+o3OjY1r6H1ru99OM6cZ0P3snka1oYS9UE5ZXddVY+K9NTDL4BLbJrRZ1r/vHhwyuVOiGx5+qYCSAtycbAvqFLwgDfEmpV2eJEZwCYjxICYToW4g31Ss0TSEco=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 704f6f43-6dc0-4db1-9421-08d70116ed66
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2019 07:03:47.8956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: shengjiu.wang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6734
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> > +
> > +     /* restore registers by regcache_sync */
> > +     fsl_esai_register_restore(esai_priv);
> > +
> > +     regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR,
> > +                        ESAI_xCR_xPR_MASK, 0);
> > +     regmap_update_bits(esai_priv->regmap, REG_ESAI_RCR,
> > +                        ESAI_xCR_xPR_MASK, 0);
>=20
> And just for curious, can (or shall) we stuff this personal reset to the =
reset()
> function? I found this one is a part of the reset routine being mentioned=
 in
> the RM -- it was done after ESAI reset is done via ECR register.
>=20

There is a problem to do this, TPR/RPR need to be clear after configure the=
 control
register. (TCCR, TCR). So it seems not only one place (reset function) need=
 to be
changed.

Best regards
Wang shengjiu
