Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B79C7BD6D3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2019 05:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439284AbfIYDrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 23:47:22 -0400
Received: from mail-eopbgr10079.outbound.protection.outlook.com ([40.107.1.79]:14405
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2411611AbfIYDrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 23:47:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPiA2dwtrfNFh53oIzTuXJC0wJ1Z2UkKoRGSI89wT4mMbjplz9UDGoqIvjf7igZvpOOpLvwdJYnjRU+SvNfxMV+3S0bL7Tl1wpIT7QfhxYlWfUwELjB38Qfzk9c70zvNLg1QBZu5WHDUQmQlET1jpHlWeQ2jTzgk1ID+8UZ65Fb2g0gu9XsEwv14YsBl9w5xSf4I40jJwI1siTTxkrEPPWVu4FJeTXOXnRNVmsvdhi8EJSUA6EUX8szHDTDyDhIskjfFuLN/JFZsC0EEet+WZyWW2sdXSLBroUPmaqZWmBgTXubfF7SLYgi9odIb3IfI0qLflOcV1S2rtUghRh8EQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZFH4xIfpEADR0ywwmMpJgFO5xXqj6ivf/IXDaLV1ik=;
 b=gAc2obRBHk3Kqa1HAJ8AnsqFuRCOw4jAoHKRlBorv2lKPvS1Zt0EVg3npbAg2tD2cEpz1mlHq+eMgOy/0hTcyHUKk3+B/pX+DaELagu14z3I3GCjkAxIOjroqq0T49CTWwbgm0vNjf/s6TA9Cv88MQanBFHy5aR6ANUYwg+09JW1P1HE3Jx/OQ7Y0BkcYf1+PY8rLH/gZucywBj3NTciCQLLLM4kelltzXFE+s3YkfqpEcUv9gn9eYvyFu9eVy4Ue9ALGc5L26P7FqRQxXC6tGwaFKnYq+DT+kFBmV2bTUrkB0uOaxTyNb1SI4K5x61+ug1z1W9Llu6+hX4cv/hKiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZFH4xIfpEADR0ywwmMpJgFO5xXqj6ivf/IXDaLV1ik=;
 b=Waf4DvAXSQgdXI/E0sXDzWzvoYQHLsBz0fi19w5GNuc9rbErA45SCItIIhSKuRNgUfxixDzbHy7dUZ8bAwljThK2ssJNlu9nH6GFEIl/eX4TX87aeHcLpMIUVsKk1OI75MItr9QM5nabq0SyP+nXaW7zt3tayn0ynyIvFTctOy0=
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com (52.135.138.150) by
 DB7PR04MB5116.eurprd04.prod.outlook.com (20.176.235.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.18; Wed, 25 Sep 2019 03:47:14 +0000
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::4427:96f2:f651:6dfa]) by DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::4427:96f2:f651:6dfa%5]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 03:47:14 +0000
From:   Biwen Li <biwen.li@nxp.com>
To:     Leo Li <leoyang.li@nxp.com>,
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
Thread-Index: AQHVcoOnab7d5ysBNkWsXmY0PrfSuKc6/L+AgAC3JZCAAAkFAIAAANMggAABmICAAAIKMA==
Date:   Wed, 25 Sep 2019 03:47:14 +0000
Message-ID: <DB7PR04MB4490EAE9591B5AE7112C9D188F870@DB7PR04MB4490.eurprd04.prod.outlook.com>
References: <20190924024548.4356-1-biwen.li@nxp.com>
 <20190924024548.4356-3-biwen.li@nxp.com>
 <AM0PR04MB667690EE76D327D0FC09F7818F840@AM0PR04MB6676.eurprd04.prod.outlook.com>
 <DB7PR04MB449034C4BBAA89685A2130F78F870@DB7PR04MB4490.eurprd04.prod.outlook.com>
 <AM0PR04MB66762594DDFC6E5B00BD103C8F870@AM0PR04MB6676.eurprd04.prod.outlook.com>
 <DB7PR04MB4490FECDC76507AADC35948E8F870@DB7PR04MB4490.eurprd04.prod.outlook.com>
 <AM0PR04MB6676BD24B814C3D1D67CF9F88F870@AM0PR04MB6676.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB6676BD24B814C3D1D67CF9F88F870@AM0PR04MB6676.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=biwen.li@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9f086607-17b9-4683-74c5-08d7416b0e01
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB7PR04MB5116;
x-ms-traffictypediagnostic: DB7PR04MB5116:|DB7PR04MB5116:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB51164EC7EBE610683097D0D98F870@DB7PR04MB5116.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(366004)(136003)(376002)(39860400002)(199004)(189003)(6436002)(55016002)(229853002)(110136005)(316002)(6636002)(5660300002)(66946007)(71190400001)(71200400001)(66556008)(52536014)(305945005)(486006)(76116006)(74316002)(11346002)(446003)(476003)(44832011)(6246003)(4326008)(14444005)(256004)(54906003)(66476007)(9686003)(66446008)(64756008)(7736002)(14454004)(6506007)(102836004)(186003)(478600001)(6116002)(2906002)(3846002)(7696005)(76176011)(99286004)(8676002)(81156014)(86362001)(33656002)(81166006)(26005)(25786009)(66066001)(2501003)(8936002)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5116;H:DB7PR04MB4490.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OXC883Z24XIMrfvTN3sO/BulZVszWqpdL+T3YUyjyWN44azIewq2LRAiPNGOxZqDDTC+W0Fa6E9/dskDIVtR3i8yogT70xfm0iwn+7K1JuFxEamo6k/ue6KX55jWXesikIr0oOxl4xukzAjZapkewE2QVafAj5MZ3skbrQ5Ub8Kx4tw4vypQN8MZmxXYAOi5mbHagsTYVKYFtzAZ/Cr5Uqu2w0xiVf7p7edWGjHOqn/dzMfgT81sP3whNcIUYsWOtxCg1PYVyYdYGmyYLfUy+EQR2R+1AxF/RzW2vOhlrdS3Ur+l6MHb3HevZhpQN4mdsjM7D6Lr6p2YQNHo/GwNekthTaVDkD6xJz253ZgZ0lou0gnilLre4Ob2Ylnc3d6bAvTbeaoiz4+s0ccmFhANkw//ylduhMjYUuIgn2dnr5I=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f086607-17b9-4683-74c5-08d7416b0e01
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 03:47:14.7227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vp9IilRJPrBbbk7P2rZVW7u3obOevVDsdyfDy8k8kk4CzA1Xv7b0peO5mUyD6qBPF2ipgfTnaqKOSN6hMxQL3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > > >
> > > > > > The 'fsl,ippdexpcr-alt-addr' property is used to handle an
> > > > > > errata
> > > > > > A-008646 on LS1021A
> > > > > >
> > > > > > Signed-off-by: Biwen Li <biwen.li@nxp.com>
> > > > > > ---
> > > > > > Change in v3:
> > > > > > 	- rename property name
> > > > > > 	  fsl,rcpm-scfg -> fsl,ippdexpcr-alt-addr
> > > > > >
> > > > > > Change in v2:
> > > > > > 	- update desc of the property 'fsl,rcpm-scfg'
> > > > > >
> > > > > >  Documentation/devicetree/bindings/soc/fsl/rcpm.txt | 14
> > > > > > ++++++++++++++
> > > > > >  1 file changed, 14 insertions(+)
> > > > > >
> > > > > > diff --git
> > > > > > a/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
> > > > > > b/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
> > > > > > index 5a33619d881d..157dcf6da17c 100644
> > > > > > --- a/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
> > > > > > +++ b/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
> > > > > > @@ -34,6 +34,11 @@ Chassis Version		Example Chips
> > > > > >  Optional properties:
> > > > > >   - little-endian : RCPM register block is Little Endian. Witho=
ut it
> RCPM
> > > > > >     will be Big Endian (default case).
> > > > > > + - fsl,ippdexpcr-alt-addr : Must add the property for SoC
> > > > > > + LS1021A,
> > > > >
> > > > > You probably should mention this is related to a hardware issue
> > > > > on LS1021a and only needed on LS1021a.
> > > > Okay, got it, thanks, I will add this in v4.
> > > > >
> > > > > > +   Must include n + 1 entries (n =3D #fsl,rcpm-wakeup-cells, s=
uch as:
> > > > > > +   #fsl,rcpm-wakeup-cells equal to 2, then must include 2 + 1
> entries).
> > > > >
> > > > > #fsl,rcpm-wakeup-cells is the number of IPPDEXPCR registers on an
> SoC.
> > > > > However you are defining an offset to scfg registers here.  Why
> > > > > these two are related?  The length here should actually be
> > > > > related to the #address-cells of the soc/.  But since this is
> > > > > only needed for LS1021, you can
> > > > just make it 3.
> > > > I need set the value of IPPDEXPCR resgiters from ftm_alarm0 device
> > > > node(fsl,rcpm-wakeup =3D <&rcpm 0x0 0x20000000>;
> > > > 0x0 is a value for IPPDEXPCR0, 0x20000000 is a value for
> IPPDEXPCR1).
> > > > But because of the hardware issue on LS1021A, I need store the
> > > > value of IPPDEXPCR registers to an alt address. So I defining an
> > > > offset to scfg registers, then RCPM driver get an abosolute
> > > > address from offset, RCPM driver write the value of IPPDEXPCR
> > > > registers to these abosolute addresses(backup the value of IPPDEXPC=
R
> registers).
> > >
> > > I understand what you are trying to do.  The problem is that the new
> > > fsl,ippdexpcr-alt-addr property contains a phandle and an offset.
> > > The size of it shouldn't be related to #fsl,rcpm-wakeup-cells.
> > You maybe like this: fsl,ippdexpcr-alt-addr =3D <&scfg 0x51c>;/*
> > SCFG_SPARECR8 */
>=20
> No.  The #address-cell for the soc/ is 2, so the offset to scfg should be=
 0x0
> 0x51c.  The total size should be 3, but it shouldn't be coming from
> #fsl,rcpm-wakeup-cells like you mentioned in the binding.
Oh, I got it. You want that fsl,ippdexpcr-alt-add is relative with #address=
-cells instead of #fsl,rcpm-wakeup-cells.
>=20
> > >
> > > > >
> > > > > > +   The first entry must be a link to the SCFG device node.
> > > > > > +   The non-first entry must be offset of registers of SCFG.
> > > > > >
> > > > > >  Example:
> > > > > >  The RCPM node for T4240:
> > > > > > @@ -43,6 +48,15 @@ The RCPM node for T4240:
> > > > > >  		#fsl,rcpm-wakeup-cells =3D <2>;
> > > > > >  	};
> > > > > >
> > > > > > +The RCPM node for LS1021A:
> > > > > > +	rcpm: rcpm@1ee2140 {
> > > > > > +		compatible =3D "fsl,ls1021a-rcpm", "fsl,qoriq-rcpm-
> > 2.1+";
> > > > > > +		reg =3D <0x0 0x1ee2140 0x0 0x8>;
> > > > > > +		#fsl,rcpm-wakeup-cells =3D <2>;
> > > > > > +		fsl,ippdexpcr-alt-addr =3D <&scfg 0x0 0x51c>; /*
> > > > > > SCFG_SPARECR8 */
> > > > > > +	};
> > > > > > +
> > > > > > +
> > > > > >  * Freescale RCPM Wakeup Source Device Tree Bindings
> > > > > >  -------------------------------------------
> > > > > >  Required fsl,rcpm-wakeup property should be added to a device
> > > > > > node if the device
> > > > > > --
> > > > > > 2.17.1

