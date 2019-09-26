Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62E76BEB09
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 05:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391755AbfIZD5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Sep 2019 23:57:21 -0400
Received: from mail-eopbgr70055.outbound.protection.outlook.com ([40.107.7.55]:4162
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726207AbfIZD5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 23:57:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBEwGvOsb0xlGOAxch+x7m+IRtpGnfZoBQVXg2o49V3rshhjbJbey8S8yXut/47KhUOWRMfK94DDc7y4l/GYbfz1Qva/P5Pt1ziKVpwclIKeFfItBQEsFlu0pOkafwaPx6PNBw/IuSnQ2PiME7MAsLirGquD9uQFALCkKyDknPLhcSbZJZ3ak6p+eifa7qwdSqyz7DmluWrYxHriYKBOSpCv+1somCuSFJreaNJNLWsHkTMUVI+7z1bqn4qCZLn5gAm1Vaj/pt/8LFxnYNESkdsDP4WMdGny8wDzGCVfnXMYnKg1YZts9/8F0s2Hcl+fYlaoAsYBfu76lTVxu7HqmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFtETIWmItbz8sgkDjSwYdwaW7nZaOXUhJA46UX0nYw=;
 b=DU9MiRJdy2c6qntScnFDMFCb8veqf3Gr8iZexBzBCqXLHbXx2n59GO3ecjZo46jbWQJTPSwt6vSQtWP1B1Id6mQl/+26Q9hxRcaw4iQyXKH993+hhUEf2nKP7HbOvek4IAQpTVbDVr/F8mVwav6IeQWAF1ApJqaWl9mD5U+9jPdxyfXOq2XK0qOHvkyT+ZXBlIBaVchNOqmK3fHxNaRhRC1rZ6H+0Le6lOWvpudAtAmOdUIjz3q1CUUSgL1m1r65sV69XKqvnrybNuQ/8l1oiDJoH93xkQoNzr1xEXaijG33juWG+IWYqVTEs1Vf+RpKR2kCNVXM0WFbEeRZfYQeBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFtETIWmItbz8sgkDjSwYdwaW7nZaOXUhJA46UX0nYw=;
 b=iarMhq+c76PXDwhA5OMOii1bNsVBD7m0A2I8v/gDbAb4lnCoMpRh0qdO3f2WaEDL4dKbfleIpjRWlaWR0P/wNdiF8gCCPJAMDbB61rH6g+tKNSHe5w5UsN0AEmB2OAaL/J7u9L+cObJwH1c5A2l8pARuoNEYGbUfe17LltC+BAo=
Received: from AM6PR04MB6470.eurprd04.prod.outlook.com (20.179.246.160) by
 AM6PR04MB5847.eurprd04.prod.outlook.com (20.179.2.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.23; Thu, 26 Sep 2019 03:57:17 +0000
Received: from AM6PR04MB6470.eurprd04.prod.outlook.com
 ([fe80::85ae:95e1:4532:2cdc]) by AM6PR04MB6470.eurprd04.prod.outlook.com
 ([fe80::85ae:95e1:4532:2cdc%5]) with mapi id 15.20.2284.023; Thu, 26 Sep 2019
 03:57:17 +0000
From:   "S.j. Wang" <shengjiu.wang@nxp.com>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
CC:     "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH V5 4/4] ASoC: fsl_asrc: Fix error with S24_3LE format
 bitstream in i.MX8
Thread-Topic: [PATCH V5 4/4] ASoC: fsl_asrc: Fix error with S24_3LE format
 bitstream in i.MX8
Thread-Index: AdV0HmLgytY2LH8gSNeymPbPUv29fw==
Date:   Thu, 26 Sep 2019 03:57:16 +0000
Message-ID: <AM6PR04MB6470AFE4170063A6F1429C33E3860@AM6PR04MB6470.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cfbbd9ea-8e00-43c8-dd06-08d742359f5b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB5847;
x-ms-traffictypediagnostic: AM6PR04MB5847:
x-microsoft-antispam-prvs: <AM6PR04MB5847FCC5C07CBC6F185A78AFE3860@AM6PR04MB5847.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0172F0EF77
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(366004)(136003)(376002)(39860400002)(199004)(189003)(7736002)(3846002)(305945005)(66556008)(64756008)(66446008)(74316002)(186003)(66476007)(86362001)(14454004)(66946007)(8676002)(486006)(81156014)(71190400001)(55016002)(71200400001)(4326008)(76116006)(229853002)(102836004)(81166006)(9686003)(52536014)(7696005)(478600001)(2906002)(6246003)(33656002)(6436002)(4744005)(66066001)(26005)(6506007)(25786009)(1411001)(316002)(7416002)(476003)(6916009)(54906003)(8936002)(256004)(5660300002)(6116002)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5847;H:AM6PR04MB6470.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: m5cnDYf4gGcgD5+R5Voar6Ga3w+HbFLMuUaTk0Fzj2B1n9shEgECVJk5/MZtuFX9VJI4me7PPTI/gKw7cnLbLTNU1jkRbSmjWp2VNMAt84hoJI8xrNkvOBXYA4U3XfQ7eeUKGRlZx5FoyndUMV+673mteWlRQ1HomIxxp2clwqmruvXK2bsArufHE7A2tKynQXWRSKTEHlM6Y16KAGfLP/nIgbSfVWF5LSD01oAbEUdfe8IKEds+LNSfZweU2i4r+Z0kaYVbI36fHw0CPc14PHkJWsghIMutqvZHt+K/1Sn365zNj3LLQPyP1/JQe+FUVSVwcD3Z/Bz/ejQoN2GS0ftvk7rQ02sFdwIyXCxJKsEJWQ6aylCg+ov5fQrvIDw6+nX5SOaHcz+x/DI1qk5L5roLw4L0YzT3HJZpPEjEahs=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfbbd9ea-8e00-43c8-dd06-08d742359f5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2019 03:57:16.9532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2LHO7HIpoqI9HKouJNSskC4JAfxwdBbNTA9TRqzUnx+uVp74hDe5Naikfn9iMQlFIowf6uSBGl2pD1Ixj90/bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5847
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> Just a small concern...
>=20
> On Thu, Sep 26, 2019 at 09:29:51AM +0800, Shengjiu Wang wrote:
> >  static int fsl_asrc_dma_startup(struct snd_pcm_substream *substream)
> > {
> > +
> > +     release_pair =3D false;
> > +     ret =3D snd_soc_set_runtime_hwparams(substream,
> > + &snd_imx_hardware);
>=20
> This set_runtime_hwparams() always returns 0 for now, but if one day it
> changes and it fails here, kfree() will be still ignored although the sta=
rtup()
> gets error-out.
>=20
> We could avoid this if we continue to ignore the return value like the
> current code. Or we may check ret at kfree() also?

I like to ignore the return value.

Best regards
Wang shengjiu
