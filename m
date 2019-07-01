Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1665824E66
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 13:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbfEUL4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 07:56:48 -0400
Received: from mail-eopbgr00051.outbound.protection.outlook.com ([40.107.0.51]:37251
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726344AbfEUL4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 07:56:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgVT2qP2SQOOboMmc/xn+tAXclaaek2eRiUD0EEONJk=;
 b=HznxYoXMlBJMvTsLAzPNe9jbzDXj4Yj21XAz92/hr21MDuEg+ybLj5D+HSBmLdGBFJuybbRffSMKWHdLS72CfoxzplgQNiOIIDxIrRdAL1DxfIJLfah1TgBG+FII+aNRZGMWAhzMgnIZQ4yBs1dj1z7ij3Hq4WfpOEGnPVdDuuA=
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com (20.179.252.215) by
 AM0PR04MB6051.eurprd04.prod.outlook.com (20.179.35.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Tue, 21 May 2019 11:56:43 +0000
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec]) by AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec%7]) with mapi id 15.20.1900.020; Tue, 21 May 2019
 11:56:42 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V4 1/2] soc: imx: Add SCU SoC info driver support
Thread-Topic: [PATCH V4 1/2] soc: imx: Add SCU SoC info driver support
Thread-Index: AQHVDHRAx0Mm9bAN6USp/nK7XaFMrA==
Date:   Tue, 21 May 2019 11:56:42 +0000
Message-ID: <AM0PR04MB6434643CA1A6807347DCAAF8EE070@AM0PR04MB6434.eurprd04.prod.outlook.com>
References: <1558071840-841-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d04d11f-fe26-4707-0c91-08d6dde36452
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6051;
x-ms-traffictypediagnostic: AM0PR04MB6051:
x-microsoft-antispam-prvs: <AM0PR04MB6051A8946C3B220B050C2956EE070@AM0PR04MB6051.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:741;
x-forefront-prvs: 0044C17179
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(136003)(376002)(366004)(396003)(189003)(199004)(14444005)(99286004)(2906002)(256004)(33656002)(71200400001)(558084003)(71190400001)(6862004)(54906003)(68736007)(52536014)(55016002)(53936002)(9686003)(81166006)(8936002)(6246003)(66066001)(6436002)(6636002)(8676002)(5660300002)(81156014)(229853002)(7736002)(26005)(66946007)(73956011)(316002)(66476007)(478600001)(66556008)(64756008)(14454004)(44832011)(66446008)(25786009)(486006)(186003)(86362001)(476003)(7696005)(76116006)(102836004)(76176011)(74316002)(446003)(305945005)(7416002)(4326008)(91956017)(6116002)(3846002)(6506007)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6051;H:AM0PR04MB6434.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hES89Xu8L/pJ3/H1GgjpsVXovvb0UXnD/nNCGgfcid1gfqpeOxLh9U3nQm938jnwMR581JREEsgnLp086vUnVD+BDmC41eKkcf+cP9OxEXVtBg5oFOZ2Iyicxi55eeeAMzOPDj2KS5KU+10Ct83oG+kp4Pj3568Jn859jmFjM6JIEXwx4cHBSIkXJOkI8mhKTlmM/X7V+ksg9Np2GIF1orumfoTdSb9ruIBt6e8xcU8/Skpwtc6Ey3uifl8y8qzFz+mt0/lGjcwvoPDKNFuwn8M0l9+s0g4yb3Re/KtXCXEFj82naPsuNskmTBQDFrD7tf6Vx+D7XEOQaWTZshni8rf1nCzcCGAL5P5TMeVats17Ue10NmfvD9H8bVgrPTZOHX2mmagDKoRpf3tuBD9x1GwFXaRsB2VW2Ji/CY1iTfs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d04d11f-fe26-4707-0c91-08d6dde36452
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 11:56:42.8438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6051
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/2019 8:49 AM, Anson Huang wrote:=0A=
=0A=
> +	root =3D of_find_node_by_path("/");=0A=
> +=0A=
> +	np =3D of_find_compatible_node(NULL, NULL, "fsl,imx-scu");=0A=
=0A=
It's possibly not very important for root or FW communication nodes but =0A=
you should probably of_node_put those back.=0A=
