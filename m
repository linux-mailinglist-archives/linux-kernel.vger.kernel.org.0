Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 604999E427
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 11:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbfH0J15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 05:27:57 -0400
Received: from mail-eopbgr60056.outbound.protection.outlook.com ([40.107.6.56]:15150
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725793AbfH0J14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 05:27:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGZxb0FVie3J918HVdVjOgvP+zsGEZRhXX8mo0hWvcFghHynBJcsDhd+N6sqEzZ6Ld6klZfEgJGe8OYrcuNPF7HjP6MQN2fVH4PsQkB4EnEn5Pc7W3CaIN4WB8BZOCg3I4gCEbzkikMpm2UqfOUptWvXL1qdKEdYVP3K19jSQ0/Ny5wI48NbOG6w9nMtUeeAvXqTTWZ8OVxyVvO9LauxtKoLqEISstrEJj/X3O172+b6FnpLpJL8Nntp0D3cb28eKICgaRnsvsgIZ7w8sjhHOQ1BJRrQ7PWl7rHshM25rge1r8+iZGLLI3gDZtYlEyshuL/4AHtvmOl5oyC5ctHqqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5MZyXFTtEtFKMu7SJdyOkMnL8vRhRWLKC4eUU4WjJY=;
 b=jW73TuF/ru85gA1MhyHV0vXMzO0j7r2/XIheu+gxiYAWjO5pGBDcInaE/lIvEeL2uxaQ2Q1crj49WNoL+A84lwbvVqYQqSbd0+dhaH2KBmnJAntGZ1SU3gQOPbznxV6TSsF5kBSaLM3atVG9QmLG+xzK2WQ4GzGrtGZdRG8a5sdsgVwpZ4+nyjfQYFroVlxWE/0ILPmABkoAAjtC1jSZYVjZp9MbyQLBrPo6CGZVsKBDQULed9YyRlyk3VPa+XimesjMbhHGPtRbwwJbdVlwcUz6/hrTKPGPT1E/lmpC671TZXdMthZRL0gCSvicq+oDLGH7FUVHV5Ayq/RlkpgCCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5MZyXFTtEtFKMu7SJdyOkMnL8vRhRWLKC4eUU4WjJY=;
 b=JoD1ut+8RDQDTnsHnjVqx/pjhLBe3gPAhaMoAUYOGKv/DeKSkHE7TNEmEKhcMLZSJqFefAb548NPm4ixi8Z+JcXXfRmvSkchwVnZYr3F323UcyXG3tABDrG5wqN8T7EpVE2zJL2pklBho7fjv0arbRcBi63kuhkZSGB6R12Dbwg=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6866.eurprd04.prod.outlook.com (52.132.213.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Tue, 27 Aug 2019 09:27:53 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::5d98:e1f4:aa72:16b4]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::5d98:e1f4:aa72:16b4%4]) with mapi id 15.20.2178.022; Tue, 27 Aug 2019
 09:27:53 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "sstabellini@kernel.org" <sstabellini@kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "julien.grall@arm.com" <julien.grall@arm.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: RE: [PATCH] arm: xen: mm: use __GPF_DMA32 for arm64
Thread-Topic: [PATCH] arm: xen: mm: use __GPF_DMA32 for arm64
Thread-Index: AQHVNi9zmpVhxJk2Z0aPUBEkePn3c6bXnoowgDdoLuA=
Date:   Tue, 27 Aug 2019 09:27:53 +0000
Message-ID: <AM0PR04MB44818BB69CAD35DC989A416988A00@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <20190709083729.11135-1-peng.fan@nxp.com>
 <AM0PR04MB448135E1B2C85F0B6029F7B788C70@AM0PR04MB4481.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB448135E1B2C85F0B6029F7B788C70@AM0PR04MB4481.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc080c13-9b1e-40b2-3565-08d72ad0d678
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6866;
x-ms-traffictypediagnostic: AM0PR04MB6866:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB6866743A9FE5324CDF3C0CA288A00@AM0PR04MB6866.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:269;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(199004)(189003)(8936002)(6436002)(6116002)(55016002)(316002)(486006)(14454004)(476003)(44832011)(5660300002)(8676002)(66946007)(25786009)(3846002)(7736002)(33656002)(446003)(11346002)(6246003)(4326008)(54906003)(53936002)(2906002)(64756008)(66556008)(66476007)(76116006)(66446008)(2201001)(76176011)(186003)(99286004)(71190400001)(71200400001)(256004)(14444005)(102836004)(478600001)(26005)(6506007)(86362001)(7696005)(2501003)(9686003)(4744005)(81156014)(81166006)(110136005)(229853002)(305945005)(74316002)(52536014)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6866;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9QXx9L9rNlHM7/lOH+iTscQowqdPjE4Czy1EsEVzsUei/tEJ3Hsq499xiK4GeaL00Wsv+ORuZv6BR+VtSLHP39Fw08sQyxnie1k59YfPpmErU7RqyrLUAutEJF0OuBszqKBSEFenX2Dlj/0jLca+g0CI2QFWgg2l031sgLhxHYU9d1lnNwdlMoy564j3q+clSBIBWVAC0I2PKw+imiSgSZGvGT2zrJHWzu/2tIdaftcZFL0/9FLLbmFnqcrV/T4Sema5+zNdVnV4XnM60cofS1iRg8N8vd2V7SrwJUHappsEOz578lKEnoZirMdQA+jj0ly0JPqdyPp7mFsBj/JomT9eoPr9UK/XLlmfTElImkRF5hjKtAKrYUTWbZUwIoY74IeytXw5ciBaDFKq8xBhj1jP4P0LnHy0dVKa5I/m4WU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc080c13-9b1e-40b2-3565-08d72ad0d678
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 09:27:53.5241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RxGjywD07xFcFfzd7xOcNbeHc1X/ez3EkQ7GDLLnWUZbkGS7d9mq4tlHFr6tQgULxYJE4dXoVjNQz9lyRhNzTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6866
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping again..

+Julien

> Subject: RE: [PATCH] arm: xen: mm: use __GPF_DMA32 for arm64
>=20
> Hi Russell, Stefano
>=20
> > Subject: [PATCH] arm: xen: mm: use __GPF_DMA32 for arm64
>=20
> Any comments?
>=20
> >
> > arm64 shares some code under arch/arm/xen, including mm.c.
> > However ZONE_DMA is removed by commit
> > ad67f5a6545("arm64: replace ZONE_DMA with ZONE_DMA32").
> > So to ARM64, need use __GFP_DMA32.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  arch/arm/xen/mm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c index
> > e1d44b903dfc..a95e76d18bf9 100644
> > --- a/arch/arm/xen/mm.c
> > +++ b/arch/arm/xen/mm.c
> > @@ -27,7 +27,7 @@ unsigned long xen_get_swiotlb_free_pages(unsigned
> int
> > order)
> >
> >  	for_each_memblock(memory, reg) {
> >  		if (reg->base < (phys_addr_t)0xffffffff) {
> > -			flags |=3D __GFP_DMA;
> > +			flags |=3D __GFP_DMA | __GFP_DMA32;
> >  			break;
> >  		}
> >  	}
>=20
> Thanks,
> Peng.

Thanks,
Peng.

>=20
> > --
> > 2.16.4

