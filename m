Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 660497B139
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 20:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbfG3SFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 14:05:00 -0400
Received: from mail-eopbgr20048.outbound.protection.outlook.com ([40.107.2.48]:34689
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726050AbfG3SE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:04:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aECTEKaTJSF6htBUeivzdC2oAhbW4BzDDD39qSIj2qtLdclTEK38BdBx8R6gdXfGQ7LpaIfO6wAyfrpOVK8uIybAI6J7vG/R4XHEMvFde6Ag2/osaDJP3h5x6C7ydaqsYmp6qp+GC9eB6DCffhG8kmhNM+C8gfGY6vos1FD37yDaHPSrYN1SzVsggJtNIyFip9loP57E1Z9EdBlRja68RKoW4GHlYDjpp2Vj2tMyTSjIlLz7jua1AnVJg7a8n1R/doiQsCJ3T3g/bhkfUva/87U+s3TeKL83wAuTmsfmC65oNzbTrotPLo9GDs1AHxa/wXnpk+EzYgH2/IGq+ZCqnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmMG7fy8EB9WOd2cuGypDJPWNOzA91LZ7osMb4Y8dGo=;
 b=dSJPAihApcofDcIfhr+gvOvc+pPU+u4D9HG2atD9ST+SPRsmVdgzZVNnuWu/NMvLEaJTTdRn8kEuNrJTHDSpWS3jKT/ObTQGHb5rOsfaM+f8f0+FEPw22Uswi5D0xT1zWU6sO5MRY10z0mOPpA+24tsQd3KMDurwowtBjxGNNhvpYTm7UKnVXhuofaWtwMz0CzG+apcQfiPmY1BDqpWIAfWi/9LwBqYZDT73bkTCaPCL1Jsj8mtVXSclcj8H1T/tXF52YVyaNrbYAgwSr6DqjuSL5SDyWUSLMgv5o67FFvaOfStnHQw7IqoHXv5ueJCa0+SMK1C8eNdvUIBwptPrWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmMG7fy8EB9WOd2cuGypDJPWNOzA91LZ7osMb4Y8dGo=;
 b=A4WdObgldV4S0lnDWsj1RCt27Y2mlRvXlumO2qvJ/pZdfL4p0YJbBT/D/zBHHZHdl0CKsKTKo5Sv83+jXJ9ClS1rgpoFp3Qu7PdgmVsaM/Hq5XPnsFgdsuD3rxJdTeu/pBdjhgdN0K95EHiJYvKspFjkhSQJIa+57+u2jn8vzN0=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5728.eurprd05.prod.outlook.com (20.178.121.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.14; Tue, 30 Jul 2019 18:04:56 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880%4]) with mapi id 15.20.2115.005; Tue, 30 Jul 2019
 18:04:56 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     =?iso-8859-1?Q?J=E9r=F4me_Glisse?= <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 13/13] mm: allow HMM_MIRROR on all architectures with MMU
Thread-Topic: [PATCH 13/13] mm: allow HMM_MIRROR on all architectures with MMU
Thread-Index: AQHVRpsJa23GemswhU+gJVFr5hDTJqbjdQwAgAAATwA=
Date:   Tue, 30 Jul 2019 18:04:56 +0000
Message-ID: <20190730180452.GS24038@mellanox.com>
References: <20190730055203.28467-1-hch@lst.de>
 <20190730055203.28467-14-hch@lst.de> <20190730180346.GR24038@mellanox.com>
In-Reply-To: <20190730180346.GR24038@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTBPR01CA0033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::46) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 03d84397-3d3b-4c11-fad7-08d715186dca
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5728;
x-ms-traffictypediagnostic: VI1PR05MB5728:
x-microsoft-antispam-prvs: <VI1PR05MB5728937C459D064314C0B32BCFDC0@VI1PR05MB5728.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0114FF88F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(199004)(189003)(6116002)(3846002)(68736007)(2616005)(71200400001)(71190400001)(2906002)(11346002)(14454004)(386003)(102836004)(26005)(446003)(486006)(256004)(305945005)(6506007)(5660300002)(476003)(52116002)(186003)(76176011)(7736002)(66066001)(86362001)(81156014)(6916009)(6486002)(6512007)(6436002)(25786009)(4326008)(36756003)(7416002)(4744005)(99286004)(66946007)(478600001)(1076003)(8676002)(81166006)(8936002)(316002)(54906003)(66476007)(33656002)(66446008)(66556008)(64756008)(6246003)(53936002)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5728;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hhc/Ht635k2j1rY/C8iYECS199dZkk48XaLnfkr4e3iLTnuw3zMrgJIoGyUsrbAViDerk4hGbpOnk/fGxl70D8Q35oX+VOQGAH2LkMXkwXQEVIH+JmWpSZP3bHZdPrXyPPrs/suZKIrRf6lB/AYSwCIrkCZWfQcimH7EFFM38Nui+aDVGPEXDnsoetdMF3i5OpYCjqLY4N7tHebqpt1cRIFWv74LM7t1eWyapOkHKXt0FRAdsRrUrgv7NeGE+oipfbN5VmlC/hXJW9eovyT6+uPld/0x2v8sAmA5vH7Q2nAV6pcVnBn/mMpYNFjn93C7lWcQfngFe3X4BG5ltqVKQuFn21bhqh2C5I2EuG8SaHbkUTgGR0LC2Jg97yWjCWQEOMyOYhQkwWU5NuuRMqrpGDJNkvtkQOmfokyLkGyV1nA=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <19A5F90EDC581B4E9B7EA8DB5AE872E2@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03d84397-3d3b-4c11-fad7-08d715186dca
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2019 18:04:56.3410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5728
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 03:03:46PM -0300, Jason Gunthorpe wrote:
> On Tue, Jul 30, 2019 at 08:52:03AM +0300, Christoph Hellwig wrote:
> > There isn't really any architecture specific code in this page table
> > walk implementation, so drop the dependencies.
> >=20
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> >  mm/Kconfig | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> Happy to see it, lets try to get this patch + the required parts of
> this series into linux-next to be really sure
>=20
> Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Oh, can we make this into a non-user selectable option now?=20

ie have the drivers that use the API select it?

Thanks,
Jason
