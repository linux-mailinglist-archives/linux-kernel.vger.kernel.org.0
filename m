Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 472CD15571E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Feb 2020 12:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgBGLqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Feb 2020 06:46:30 -0500
Received: from mail-am6eur05on2089.outbound.protection.outlook.com ([40.107.22.89]:6020
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726674AbgBGLqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 06:46:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IWatnhLgIgOZjY63ggLiV29ZrtIc3nytAciaaXAADKk7CKOHnVnVdAFNnqUR3RlxUHdcPSTITTt/bs7wivgMNIsBTfz7kPjCs2gdmqXN15aN8ViQZ5ENKKgCEhJB/+XHak8FgFUpQzoykX4VlNum3zhGYrXaKGQBXc1gb+RoebiXG2JeG5pMmYH8LDOrktB2Rq9UFgLnkIdDSp9zdUOrpSJn9qiDtkq3k3PRGZRO9RzdH3499EM6l+zt2eqPylMHDy3rLTm8bZCHwBIF0eS1f0ZD542oaJoDguUdp7NhD/JjpPQrM+PknrM+8WfGFlQB/NK2ebn74Bnf/GKWyutUaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkXm2KA6AFJCH/943Fy/DzqdqeSY6vRxPZl7HzgASV8=;
 b=IA6pPJRnCZrT4hNHpdyaekfvymTAToZAozb2DhIqbM4GOiK3/Md3/GHhtOGNBz6dKj3kiPMHa0grgBFMBuj+f7sV81jT6WLind9UBXPBJu7loaYLhR09fLlkmw/3LJ1kPLk98ExIc6ww+f0MhSgIyBgt6xFLKTpkZgtPrCHifZZ5DFPqCYYvh2J6aLxS1dKJm0iGCKD9Lci7tzH9sGQiB8oZyaMuHEgqLDvAHYt3LQ17WBuumdTJQNuOpXcTiTUlCh2hJ5VFcH9pUvyru7GBCtiBQbsGqNPN2FoMj4Bj63vnOxlbchX1TH93MEu38c9Ia+rdRLykyusYqL2Hf4++UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkXm2KA6AFJCH/943Fy/DzqdqeSY6vRxPZl7HzgASV8=;
 b=LDkQCjPpf9RJKs5jUmqdeTntqpui1ZmfHN1QzW2+V/7FxfLOWiPwanXPq9886VldhoEc9EUpN6Pv9j26385tFNgolBSeeeR6AsQCXUTYxrK3G+ONq8Rfy+TsrmlOPdwYt/EE7tjgOCqMypiQqlQQ9Xq1Fr359AcP8EBX+yfnfWU=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4482.eurprd04.prod.outlook.com (52.135.148.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Fri, 7 Feb 2020 11:46:25 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2707.024; Fri, 7 Feb 2020
 11:46:25 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Sudeep Holla <sudeep.holla@arm.com>, Marc Zyngier <maz@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 1/2] dt-bindings: arm: arm,scmi: add smc/hvc transports
Thread-Topic: [PATCH 1/2] dt-bindings: arm: arm,scmi: add smc/hvc transports
Thread-Index: AQHV3O5LIqtUB1cLq0qKBDDFKN5B7qgPg0IAgAAK5QCAAAIrgIAAAERwgAADxQCAAAZegIAAAoZg
Date:   Fri, 7 Feb 2020 11:46:25 +0000
Message-ID: <AM0PR04MB4481867284EAC2879DDD9F93881C0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1580994086-17850-1-git-send-email-peng.fan@nxp.com>
 <1580994086-17850-2-git-send-email-peng.fan@nxp.com>
 <7875e2533c4ba23b8ca0a2a296699497@kernel.org> <20200207104736.GB36345@bogus>
 <5a073c37e877d23977e440de52dba6e0@kernel.org>
 <AM0PR04MB44815F11C94E5F35AE7B0B21881C0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <ce775af0803d174fa2ad5dfc797592d9@kernel.org> <20200207113235.GC40103@bogus>
In-Reply-To: <20200207113235.GC40103@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dff3cc4e-cb06-48fe-5215-08d7abc35ca9
x-ms-traffictypediagnostic: AM0PR04MB4482:|AM0PR04MB4482:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4482B14EF0E6EBD3FB82D833881C0@AM0PR04MB4482.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0306EE2ED4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(199004)(189003)(478600001)(2906002)(76116006)(86362001)(53546011)(5660300002)(33656002)(7696005)(8936002)(6506007)(316002)(9686003)(110136005)(66446008)(52536014)(26005)(71200400001)(4326008)(66476007)(186003)(64756008)(66556008)(55016002)(8676002)(81166006)(7416002)(66946007)(81156014)(44832011)(54906003)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4482;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AlpGLnP8yd01WP/9xnnEmVqQMxJ+AGvZkpZIzWix55bspzelABbiJ6BNNNgAVbHL8DksbK6NFntIzKw8Tx7Jn55u9FOUXChIdd3qJsjQ3qCys2D3UVPIIAfS2H/sZAeD53GsAlDlbsKuqvgLgF/y7URQaj+hptH/w3iVRz8a35esB90ea8XQLqJSc1Q6i3fNNjVSEwkrAHpvXgVzzOTszr+tHhaynvuuS5wJpIeScBLxzbJ/udvtaWhYIqYwC5I6u6fwd73miXv4ViVUutJ2qyy5TH/W+oqHoCX2PwgWd0DFOZtwofn9+ub0ifxjlbfve4YHmTPiQHy6d0N+67GboTQZ5ZXBXPmDGZh6bLMEpNzYWGPr1uK4tuaPARl8hp8bRfCERlZzmkjUY0ZUSXH+uUljrrQgHcUDurdrvSeVlju09xImvNrPTiEEMS1TKlZwt8nXelMjuHCvNHWn3QVvfYsyiQyuZQQuoEbqQrKg4h4Kx2AzH3Ew69cgBGROvxmM
x-ms-exchange-antispam-messagedata: uk4wFVu3wpjSBpvDo6xsmWa+0Ng0Fbel1zM6r3N7/D884PcENTsenLLSXR3O78hTBLf64zICNNJ/tVLk5FfxmlpiDtyKP7tBTh+PMtq6zx6YyWkeW5NYsXTy77TO9Gz48XPjAlh3REG4ka7xpPgolA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dff3cc4e-cb06-48fe-5215-08d7abc35ca9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2020 11:46:25.6058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: slo4qJh+p35o1pUx6sE9OIs6BWegSaWv7yaU8cSoa1cJEeDev3QEUca6q8nODmPZhkFpnSFzq0i0vB0w7GimOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4482
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH 1/2] dt-bindings: arm: arm,scmi: add smc/hvc transpor=
ts
>=20
> On Fri, Feb 07, 2020 at 11:09:48AM +0000, Marc Zyngier wrote:
> > On 2020-02-07 11:00, Peng Fan wrote:
> > > > Subject: Re: [PATCH 1/2] dt-bindings: arm: arm,scmi: add smc/hvc
> > > > transports
> > > >
> > > > On 2020-02-07 10:47, Sudeep Holla wrote:
> > > > > On Fri, Feb 07, 2020 at 10:08:36AM +0000, Marc Zyngier wrote:
> > > > >> On 2020-02-06 13:01, peng.fan@nxp.com wrote:
> > > > >> > From: Peng Fan <peng.fan@nxp.com>
> > > > >> >
> > > > >> > SCMI could use SMC/HVC as tranports, so add into devicetree
> > > > >> > binding doc.
> > > > >> >
> > > > >> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > >> > ---
> > > > >> >  Documentation/devicetree/bindings/arm/arm,scmi.txt | 4 +++-
> > > > >> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > >> >
> > > > >> > diff --git
> > > > >> > a/Documentation/devicetree/bindings/arm/arm,scmi.txt
> > > > >> > b/Documentation/devicetree/bindings/arm/arm,scmi.txt
> > > > >> > index f493d69e6194..03cff8b55a93 100644
> > > > >> > --- a/Documentation/devicetree/bindings/arm/arm,scmi.txt
> > > > >> > +++ b/Documentation/devicetree/bindings/arm/arm,scmi.txt
> > > > >> > @@ -14,7 +14,7 @@ Required properties:
> > > > >> >
> > > > >> >  The scmi node with the following properties shall be under
> > > > >> > the /firmware/ node.
> > > > >> >
> > > > >> > -- compatible : shall be "arm,scmi"
> > > > >> > +- compatible : shall be "arm,scmi" or "arm,scmi-smc"
> > > > >> >  - mboxes: List of phandle and mailbox channel specifiers. It
> > > > >> > should contain
> > > > >> >  	  exactly one or two mailboxes, one for transmitting
> messages("tx")
> > > > >> >  	  and another optional for receiving the
> > > > >> > notifications("rx") if @@ -25,6 +25,8 @@ The scmi node with
> > > > >> > the following properties shall be under the /firmware/ node.
> > > > >> >  	  protocol identifier for a given sub-node.
> > > > >> >  - #size-cells : should be '0' as 'reg' property doesn't have =
any size
> > > > >> >  	  associated with it.
> > > > >> > +- arm,smc-id : SMC id required when using smc transports
> > > > >> > +- arm,hvc-id : HVC id required when using hvc transports
> > > > >> >
> > > > >> >  Optional properties:
> > > > >>
> > > > >> Not directly related to DT: Why do we need to distinguish
> > > > >> between SMC and HVC?
> > > > >
> > > > > IIUC you want just one property to get the function ID ? Does
> > > > > that align with what you are saying ? I wanted to ask the same
> > > > > question and I see no need for 2 different properties.
> > > >
> > > > Exactly. Using SMC or HVC should come from the context, and there
> > > > is zero value in having different different IDs, depending on the
> > > > conduit.
> > > >
> > > > We *really* want SMC and HVC to behave the same way. Any attempt
> > > > to make them different should just be NAKed.
> > >
> > > ok. Then just like psci node,
> > > Add a "method" property for each protocol, and add "arm,func-id" to
> > > indicate the ID.
> > >
> > > How about this?
> >
> > Or rather just a function ID, full stop. the conduit *MUST* be
> > inherited from the PSCI context.
>=20
> Absolutely, this is what I was expecting.
>=20
> Peng,
>=20
> You have already introduced a compatible for smc/hvc transport instead of
> default mailbox, why do you need anything more ?=20

No.

Just use SMC or HVC
> conduit from PSCI/SMCCC. I don't think you need anything more than the
> function ID.

Yes, only function ID for now. If function ID could not be standardized in =
short
term, I could first mark smc-id optional in dt bindings, then smc transport=
s
driver will first parse smc-id, abort if not exist. When ARM has standarliz=
ed
ID, we could switch to use that ID if smc-id not exist.

Thanks,
Peng.

>=20
> --
> Regards,
> Sudeep
