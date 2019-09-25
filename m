Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9FBDBD6AC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2019 05:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411529AbfIYD0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 23:26:14 -0400
Received: from mail-eopbgr80083.outbound.protection.outlook.com ([40.107.8.83]:46822
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406280AbfIYD0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 23:26:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eaNK1EhViLro8kj4b03vmWpLROHQ0j2LIwMzjatQ85vyLnhjGs1XgC+8UIdoNNFU5uP9iG9Em1E6wjoM5Pd21RB+yQiGfNh6WsSJvup4nfuHNmbfCV1TpczX3yZbBNZLsNZaj+Fc2o3z5vaijCYFDkxLvLTGGQT0ZK1cAB2ERCtk8ZX5PdeybBKrzFes1W0/Bs6OYfbE8ylB+J3e5EFM4BYSg6UrbzieDc+LZxPK1E9W/587QbDZYUqEVQDiQbLTPAQHbY6uBFAnN5WBji8CTm5lVs5JivrbsNZD4GX8qm4xBHAleUD+tGPeLLIIRJtD5YeDeu269jMzsw41vQkJ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGn6T1U/kkZANf6VP/0yh/UY2VwqvJhpm6bH++IpC4w=;
 b=GNisEQqo8VUOLNLKHmxrfktvm73zcakGO6yUi5mMeu6bgCukt6YAAcBzs/TGDdpvZawtgfczNJnssKJfdM5TvTQXmmwV0wkYDmewqWlDCMxnthINrl6DTj+Y8ubnJ7+zYa2LnDtYv0OljX/Oea9/7SIzQ0GuFwgwTsYHr9QqSGY3doEqjxx92IPeEznTG6gqh6LPD9Am4l6SyzuN55l50fPT8UI0KY/+Lo/sMthWtJuUyo3TAS0isYWzqJmh2Jv70eXLqRsn1I9tfthXif+UupHkLnhNpU22KqzGNhJTfRkOwtiUdIEnpPTBSEAlx2li9zJq46m3EkAGERRjozdVhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGn6T1U/kkZANf6VP/0yh/UY2VwqvJhpm6bH++IpC4w=;
 b=GN+/cQMIn19qObKbXOdH0FXuDb2VcCay5POeHnXDk4CiBMRHX8pamaBTf19j+N3KcDTGj4BMYJuBbyhuejbfXbOFslGbHdo+eveiIcr+2b2NQzT2dQXqQLLzkdjdiFay/roslskr+RvsRBPBLUX/ptEvp2dTfZfvCKQXo+3fL6U=
Received: from AM0PR04MB6676.eurprd04.prod.outlook.com (20.179.255.161) by
 AM0PR04MB6609.eurprd04.prod.outlook.com (20.179.252.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.26; Wed, 25 Sep 2019 03:26:09 +0000
Received: from AM0PR04MB6676.eurprd04.prod.outlook.com
 ([fe80::5c26:3c5f:17e0:8038]) by AM0PR04MB6676.eurprd04.prod.outlook.com
 ([fe80::5c26:3c5f:17e0:8038%7]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 03:26:09 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Biwen Li <biwen.li@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Ran Wang <ran.wang_1@nxp.com>
CC:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [v3,3/3] Documentation: dt: binding: fsl: Add
 'fsl,ippdexpcr-alt-addr' property
Thread-Topic: [v3,3/3] Documentation: dt: binding: fsl: Add
 'fsl,ippdexpcr-alt-addr' property
Thread-Index: AQHVcoOnKERg3NBKWEeinvrVMNtD66c6+UIwgADABICAAADF0A==
Date:   Wed, 25 Sep 2019 03:26:08 +0000
Message-ID: <AM0PR04MB66762594DDFC6E5B00BD103C8F870@AM0PR04MB6676.eurprd04.prod.outlook.com>
References: <20190924024548.4356-1-biwen.li@nxp.com>
 <20190924024548.4356-3-biwen.li@nxp.com>
 <AM0PR04MB667690EE76D327D0FC09F7818F840@AM0PR04MB6676.eurprd04.prod.outlook.com>
 <DB7PR04MB449034C4BBAA89685A2130F78F870@DB7PR04MB4490.eurprd04.prod.outlook.com>
In-Reply-To: <DB7PR04MB449034C4BBAA89685A2130F78F870@DB7PR04MB4490.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leoyang.li@nxp.com; 
x-originating-ip: [136.49.234.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65ed74ec-29f4-405d-f257-08d741681b99
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM0PR04MB6609;
x-ms-traffictypediagnostic: AM0PR04MB6609:|AM0PR04MB6609:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB6609FCC09E8E13835BBF7C608F870@AM0PR04MB6609.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(189003)(199004)(13464003)(81166006)(64756008)(66476007)(66556008)(316002)(55016002)(229853002)(9686003)(99286004)(478600001)(52536014)(71190400001)(54906003)(7696005)(71200400001)(4326008)(66946007)(76116006)(6246003)(110136005)(6436002)(66446008)(53546011)(6506007)(25786009)(11346002)(486006)(476003)(6636002)(5660300002)(446003)(33656002)(26005)(74316002)(102836004)(305945005)(76176011)(6116002)(3846002)(86362001)(2906002)(14454004)(66066001)(81156014)(2501003)(14444005)(256004)(7736002)(8676002)(186003)(8936002)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6609;H:AM0PR04MB6676.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gqSmu6K8VDTOnl9DnJWgsqJF/uNAZ+qnnfXEBkcav/VeJE0DBoetusrQk7wlHzcR3GEeRlm+ZlLHEfiKfDCF/do85+N2VBnguvMZabypIq3yVfUWesYaGH1Gj7J1/CHjh7ergdAQQBm8dMXXs9J6T9pUV8fRByc5EXRcUoYYX6ChkaPRguxfIUKSYDQHur48sVQ6A6F9s55LZI9JNw5t+IGbg3Ti1O+1+ZGfwp/oZJ7toCr0cK5epTBSya2AXZuznjnWA53ll3eGyI/5OWj6LAOsJ9MGSxcc857dyGpqOKKDEol64b4/QVN4fMY4tE0CkNtosKb5/8w0Bt3ulH5nLxpx3mAWtMkys7QSsWVK1RACkE0pGMrN0Kt2AE7qjykGbr5Sz7k4UeO8SZQ9OAQHaGf0Y3WslHYlA0XFnER9fCI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ed74ec-29f4-405d-f257-08d741681b99
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 03:26:09.0123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R/VD3kJaVaAwsXfekz7gEDoLxO34QNg/4ZJydYsWNAErnwiFcvvk5cJ6O9uJmdeVM6Bk2v4KnkehZEpEre/h3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6609
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Biwen Li
> Sent: Tuesday, September 24, 2019 10:13 PM
> To: Leo Li <leoyang.li@nxp.com>; shawnguo@kernel.org;
> robh+dt@kernel.org; mark.rutland@arm.com; Ran Wang
> <ran.wang_1@nxp.com>
> Cc: linuxppc-dev@lists.ozlabs.org; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; devicetree@vger.kernel.org
> Subject: RE: [v3,3/3] Documentation: dt: binding: fsl: Add 'fsl,ippdexpcr=
-alt-
> addr' property
>=20
> > >
> > > The 'fsl,ippdexpcr-alt-addr' property is used to handle an errata
> > > A-008646 on LS1021A
> > >
> > > Signed-off-by: Biwen Li <biwen.li@nxp.com>
> > > ---
> > > Change in v3:
> > > 	- rename property name
> > > 	  fsl,rcpm-scfg -> fsl,ippdexpcr-alt-addr
> > >
> > > Change in v2:
> > > 	- update desc of the property 'fsl,rcpm-scfg'
> > >
> > >  Documentation/devicetree/bindings/soc/fsl/rcpm.txt | 14
> > > ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
> > > b/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
> > > index 5a33619d881d..157dcf6da17c 100644
> > > --- a/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
> > > +++ b/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
> > > @@ -34,6 +34,11 @@ Chassis Version		Example Chips
> > >  Optional properties:
> > >   - little-endian : RCPM register block is Little Endian. Without it =
RCPM
> > >     will be Big Endian (default case).
> > > + - fsl,ippdexpcr-alt-addr : Must add the property for SoC LS1021A,
> >
> > You probably should mention this is related to a hardware issue on
> > LS1021a and only needed on LS1021a.
> Okay, got it, thanks, I will add this in v4.
> >
> > > +   Must include n + 1 entries (n =3D #fsl,rcpm-wakeup-cells, such as=
:
> > > +   #fsl,rcpm-wakeup-cells equal to 2, then must include 2 + 1 entrie=
s).
> >
> > #fsl,rcpm-wakeup-cells is the number of IPPDEXPCR registers on an SoC.
> > However you are defining an offset to scfg registers here.  Why these
> > two are related?  The length here should actually be related to the
> > #address-cells of the soc/.  But since this is only needed for LS1021, =
you can
> just make it 3.
> I need set the value of IPPDEXPCR resgiters from ftm_alarm0 device
> node(fsl,rcpm-wakeup =3D <&rcpm 0x0 0x20000000>;
> 0x0 is a value for IPPDEXPCR0, 0x20000000 is a value for IPPDEXPCR1).
> But because of the hardware issue on LS1021A, I need store the value of
> IPPDEXPCR registers to an alt address. So I defining an offset to scfg re=
gisters,
> then RCPM driver get an abosolute address from offset,  RCPM driver write
> the value of IPPDEXPCR registers to these abosolute addresses(backup the
> value of IPPDEXPCR registers).

I understand what you are trying to do.  The problem is that the new fsl,ip=
pdexpcr-alt-addr property contains a phandle and an offset.  The size of it=
 shouldn't be related to #fsl,rcpm-wakeup-cells.

> >
> > > +   The first entry must be a link to the SCFG device node.
> > > +   The non-first entry must be offset of registers of SCFG.
> > >
> > >  Example:
> > >  The RCPM node for T4240:
> > > @@ -43,6 +48,15 @@ The RCPM node for T4240:
> > >  		#fsl,rcpm-wakeup-cells =3D <2>;
> > >  	};
> > >
> > > +The RCPM node for LS1021A:
> > > +	rcpm: rcpm@1ee2140 {
> > > +		compatible =3D "fsl,ls1021a-rcpm", "fsl,qoriq-rcpm-2.1+";
> > > +		reg =3D <0x0 0x1ee2140 0x0 0x8>;
> > > +		#fsl,rcpm-wakeup-cells =3D <2>;
> > > +		fsl,ippdexpcr-alt-addr =3D <&scfg 0x0 0x51c>; /*
> > > SCFG_SPARECR8 */
> > > +	};
> > > +
> > > +
> > >  * Freescale RCPM Wakeup Source Device Tree Bindings
> > >  -------------------------------------------
> > >  Required fsl,rcpm-wakeup property should be added to a device node
> > > if the device
> > > --
> > > 2.17.1

