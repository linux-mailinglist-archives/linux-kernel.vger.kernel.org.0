Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59E3E16A0B8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 09:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbgBXIxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 03:53:32 -0500
Received: from mail-am6eur05on2078.outbound.protection.outlook.com ([40.107.22.78]:27942
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727348AbgBXIx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 03:53:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ne7teBaqIlrdQPDd9JaxmSXOsDVZRsBAL0GTTkRispZx44zZ+WRaqCScM3Hike5mI49A82m5aGGMZbWa6X2mkN/BjGpHJX0+dlvB+fNZoekcIUn9lzpEuMAcCsLJVdmBINKL3heJb5MA9N+Z7cwB4dnYygMgSNHYanR+Va23CdZOWVxhxpScgVVkBoAkkX9UKFxS52ITtlZxNHXwHJJFUfyFULHH3WUx8tph/lZAwBVL6pUZZ2uBMM3Nx6sBwR2CEktTuxj9csXXv1ppm5uUoLBmZOlEAWwYnSYBEF4ipxOAnhn9uJfp0RHaYnqCwxK2gvreX0yRDOO7rzV6iomOFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39ZpzOZDMlgUHdjcgSEY5oRnIiqbOuAoG3PMp076Lbo=;
 b=htuiyNYNHpTpzxWdK5Tv/DiygHEXSAg/coJ6lYwIKQ6sU4yokFfYKMdBjvBiRFzBPjRvXjMurnY1VmNdUKyAeZhi9O59s/sH251ykc8pbySRS3W1wog6wsIiF60+EDBIUb/fNrDXibH+Nwpd6V2ihZPglqQV4idjE3giq3PaGYZA9rOxTQQSG/Hz2YqFii4vFiDnTmoFgeWDIXPWMAARPPrc84Ts3epKmR/dL9iS59m/x8OW4mghxNqYEWQXhmByhPY5OZcAIRSmwyoxbwOgfRpTln7BQVegoCXTUDeAtVLlNtHyY3P9mXuwonyv2Ih8lPHStjJ9kaoUTVksVHQ91w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39ZpzOZDMlgUHdjcgSEY5oRnIiqbOuAoG3PMp076Lbo=;
 b=qxmS1PNMCHIJEN5frCv5iP7B7297bi+IDREMXDkkBM3DyES3JBZnycp0BfGQ0PbH12nkUI94hm43h+4tAL+wmW2qVEiHoOChY50KUywjsVXVoEEwWAd3JXiy+4oGwJSiihs4Y9Rh6jzogDwqAbbTfskZBcM9ocd50dY1w5/2+YQ=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.232.225) by
 VE1PR04MB6606.eurprd04.prod.outlook.com (20.179.235.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18; Mon, 24 Feb 2020 08:53:26 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::2075:2c31:f78a:23a4]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::2075:2c31:f78a:23a4%5]) with mapi id 15.20.2729.033; Mon, 24 Feb 2020
 08:53:25 +0000
From:   "S.j. Wang" <shengjiu.wang@nxp.com>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
CC:     "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] ASoC: fsl_easrc: Add EASRC ASoC CPU DAI and
 platform drivers
Thread-Topic: [PATCH v2 3/3] ASoC: fsl_easrc: Add EASRC ASoC CPU DAI and
 platform drivers
Thread-Index: AdXq7zKbRo5k9O0MQoSy/99vj57qYQ==
Date:   Mon, 24 Feb 2020 08:53:25 +0000
Message-ID: <VE1PR04MB6479BCA376502F6F1251602BE3EC0@VE1PR04MB6479.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-originating-ip: [101.86.209.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1e08fdfd-4cb4-4e99-3420-08d7b90702b9
x-ms-traffictypediagnostic: VE1PR04MB6606:
x-microsoft-antispam-prvs: <VE1PR04MB66060C1F0041F6A9ADD08884E3EC0@VE1PR04MB6606.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 032334F434
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(199004)(189003)(9686003)(186003)(6916009)(316002)(7696005)(76116006)(33656002)(478600001)(55016002)(6506007)(26005)(81166006)(81156014)(5660300002)(2906002)(66946007)(66446008)(8676002)(64756008)(66476007)(66556008)(71200400001)(52536014)(54906003)(4326008)(86362001)(8936002)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6606;H:VE1PR04MB6479.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o3WWhM5TJLrHi8gznmjIIIzZGx/b7VImqyt4nB4PcK+IaUgb0NNapjhMX5NAkDCrKnFkhJmpFsL/AcabJVEFo3Ys/7rL3gx+ydIAV/RPUqYrXkKlp1NappXM6nXGmDK4pHd4xfPyBBMK9KTF+Kjq0n9UFvuPe1JMBmYq25iTh8l3h7p94x1Q77TpVXQrX1C4XxkLzJO5NzQhBiyAhRVd+UvexgnjPXeiuj0PCmgSraIbXs4F8NWg2MSgRmoaE7858ovNREUjwRvnn9su6Ti1By1pbt7nRl66gHoraJRjMwvSSPShWNjWjxu/GUefpdt3N39gwDzBjgjcEvcKCFQ0aP9uMrCaw1MkyvfTktxfYYN5YBrkLZlIfysoXOCTNmm6WLTp8mm+IRoE4q2EeHssmrJgitFP7TVxWO1F921x3L6EujGEix7OcGCnAG5Dn6jJ
x-ms-exchange-antispam-messagedata: fPiDTjYFKXg/lfnBsTO3GteZXyVRssejJyoDRenaez1X/YyWKTPQrjkzR6KKazjbJM+/kk9VK0/0UWk3JDNxuceiN66P6ZGXwyIuslwmUoCXdprrZegm2CuPWEe6XKak4QbH6G80hkUthaoUnaZEkg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e08fdfd-4cb4-4e99-3420-08d7b90702b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2020 08:53:25.6346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k/pYfVM/+CVio65/5mb01LolyoelAriE93P4OgG3QKflkvmLzB7fC2LWyjezZpiu41FMFEEnD9ZLVh0k86TM/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6606
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  sound/soc/fsl/Kconfig           |   10 +
> >  sound/soc/fsl/Makefile          |    2 +
> >  sound/soc/fsl/fsl_asrc_common.h |    1 +
> >  sound/soc/fsl/fsl_easrc.c       | 2265 +++++++++++++++++++++++++++++++
> >  sound/soc/fsl/fsl_easrc.h       |  668 +++++++++
> >  sound/soc/fsl/fsl_easrc_dma.c   |  440 ++++++
>=20
> I see a 90% similarity between fsl_asrc_dma and fsl_easrc_dma files.
> Would it be possible reuse the existing code? Could share structures from
> my point of view, just like it reuses "enum asrc_pair_index", I know
> differentiating "pair" and "context" is a big point here though.
>=20
> A possible quick solution for that, off the top of my head, could be:
>=20
> 1) in fsl_asrc_common.h
>=20
>         struct fsl_asrc {
>                 ....
>         };
>=20
>         struct fsl_asrc_pair {
>                 ....
>         };
>=20
> 2) in fsl_easrc.h
>=20
>         /* Renaming shared structures */
>         #define fsl_easrc fsl_asrc
>         #define fsl_easrc_context fsl_asrc_pair
>=20
> May be a good idea to see if others have some opinion too.
>=20

We need to modify the fsl_asrc and fsl_asrc_pair, let them
To be used by both driver,  also we need to put the specific
Definition for each module to same struct, right?

>=20
> > +static const struct regmap_config fsl_easrc_regmap_config =3D {
> > +     .readable_reg =3D fsl_easrc_readable_reg,
> > +     .volatile_reg =3D fsl_easrc_volatile_reg,
> > +     .writeable_reg =3D fsl_easrc_writeable_reg,
>=20
> Can we use regmap_range and regmap_access_table?
>=20

Can the regmap_range support discontinuous registers?  The
reg_stride =3D 4.

Best regards
Wang shengjiu

