Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD075A05B4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 17:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfH1PHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 11:07:49 -0400
Received: from mail-eopbgr20064.outbound.protection.outlook.com ([40.107.2.64]:54766
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726719AbfH1PHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 11:07:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GRoplw5uBj36u9PLD5KkJ52YVI4IKi8C06Kzgm7c/hZK/dpQ9OO+g8uQXlQBoz/tDQPywxRxLh8hgEEKZh/Oatm6DFGPa+Qc87LN6fyLnuVpIY+XbX/z19Cp+buLjlSj02dhrI4KDNAeZH3oZ6umbuaQXPFPzOU4Zx0O+o8okYTzsL90gKYXshi/Pdn7sGKZbXznZ00dhHZ61gf6tUoFgJ85UmPLCk+aN2qRs2mDSdZLlknpvojZUj78GpEu9KLXgmHklV4F2kNGdggsEFwWL936DWFTOcV9mLsoXWM0bM7wcSWVjBDIr8wFHwtP+Xt0kVsEiGLbAD3JgA63tSTuCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzBO9v2P7cavA82+WvAK7mNHOh6Ht/b4uZLcBSgNBbM=;
 b=cvvqtfCH6kOfWqPAUWsQxY76d4RPhOMGyiaCl+oE511JoApSfW4cpX1yzZtlrVpHsrlf6qDo29kFVsrRG8CV5MbYZSD8Wxcok7d/gjHiOiTpHKXuT0Jqb4qZQY/QZJYlVRn/Qzk4E6g0/X5Gikph/s9GwmGbkkSjOmT4+y8Huu3HTTmqtY6pP7+mracfY2gFBOaqschcfLIIR6zjje24JrGFTVsYhvkubv5O/xV0oJn9sJPeEmpHz6uIirvOfXn7GuhTBBMRx/j05yve4jlUotw+X20CNeYY5X03OJO6v0CmA+M2rDEjTjIahLkWm18aolvhxcTzDyK1HqMKhZrDyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzBO9v2P7cavA82+WvAK7mNHOh6Ht/b4uZLcBSgNBbM=;
 b=VcAGSi/1Yzpex313BdXg92GMZpRQkVgY0HOd1XC7febfqIkL+E+Lul+fvydZw/EalIJA+pu03ScaLjUerbL7zPoJ3Yw2w8pCZHHRy20w0Ez6zILDqN1DHAqVADN0s/o6getzPceW8p/5jbTm2JWCAanoChlhnzKHXdbHiJJNQrQ=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6030.eurprd05.prod.outlook.com (20.178.127.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Wed, 28 Aug 2019 15:07:44 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1d6:9c67:ea2d:38a7]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1d6:9c67:ea2d:38a7%6]) with mapi id 15.20.2199.021; Wed, 28 Aug 2019
 15:07:44 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?iso-8859-1?Q?Thomas_Hellstr=F6m?= <thomas@shipmail.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Steven Price <steven.price@arm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: cleanup the walk_page_range interface v2
Thread-Topic: cleanup the walk_page_range interface v2
Thread-Index: AQHVXauu1eDDLACvPUOFLhngSurTPqcQqVMA
Date:   Wed, 28 Aug 2019 15:07:44 +0000
Message-ID: <20190828150740.GO914@mellanox.com>
References: <20190828141955.22210-1-hch@lst.de>
In-Reply-To: <20190828141955.22210-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::21) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.167.216.168]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1424d360-cdf3-447e-757a-08d72bc97ab7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6030;
x-ms-traffictypediagnostic: VI1PR05MB6030:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR05MB6030AF2912F13769D3C023E6CFA30@VI1PR05MB6030.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(189003)(199004)(53754006)(2906002)(25786009)(6512007)(478600001)(4326008)(8936002)(3846002)(6116002)(14454004)(6246003)(6306002)(4744005)(66476007)(66946007)(81166006)(966005)(26005)(81156014)(53936002)(54906003)(33656002)(229853002)(316002)(8676002)(5660300002)(64756008)(66446008)(6916009)(66556008)(1076003)(2616005)(6436002)(86362001)(476003)(7736002)(11346002)(446003)(66066001)(36756003)(76176011)(186003)(52116002)(71190400001)(99286004)(305945005)(71200400001)(486006)(14444005)(386003)(256004)(6506007)(102836004)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6030;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: y8rs7KENIxHeRdBbHhnXun9UrH9UOt2TmPKWNiTm8ebQnT5TH+UgGKyfcrMQgrCOKEvPMhSjJRVoRZ9s+qH9nN+YW+PVfrJTs0Suqm8QEBkRdhgEC+K8dE73Ug9LPR8BI/8cmxxGZfcvAG66koX5iiPeNZ1VOZuyw02Zu3IpP0CYXI939CQVmscdHa2Z9l5thGukA2Nmoj3tOnKekTluMCD9aMZoLK+ndTd4Nj90lCQoBeyQTuVinKZ5G7e+pfkmfXDJFPDXVH2WovMoK2M7zNI6n/WUQdoWPiPcdEvAbRR/QLf9H9KTC1NO+DMjhIJ7quruP6WBxbLiwtEYIOBC1VT4Oxm6QsviVMbtJz6Y062vl1kfg5VHxoF79h30AWPy3OUx3eaXs+lTtOsLSMsM8lGjjlK/LHTDM0m/wab8Mhs=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <A699024BC38C89458FBFDF76B13C61F7@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1424d360-cdf3-447e-757a-08d72bc97ab7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 15:07:44.5068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1nDZ5jISFlz+xXAbpUSiWxvwNeX1XH90U5g5qBMGTd1N5zTnruNgQWjepaGlXEJoWmCbGDCtqdlnF014mm7iFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6030
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 04:19:52PM +0200, Christoph Hellwig wrote:
> Hi all,
>=20
> this series is based on a patch from Linus to split the callbacks
> passed to walk_page_range and walk_page_vma into a separate structure
> that can be marked const, with various cleanups from me on top.
>=20
> This series is also available as a git tre here:
>=20
>     git://git.infradead.org/users/hch/misc.git pagewalk-cleanup
>=20
> Gitweb:
>=20
>     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/pagew=
alk-cleanup
>=20
>=20
> Diffstat:
>=20
>     14 files changed, 291 insertions(+), 273 deletions(-)
>=20
> Changes since v1:
>  - minor comment typo and checkpatch fixes
>  - fix a compile failure for !CONFIG_SHMEM
>  - rebased to the wip/jgg-hmm branch

Applied to hmm.git, thanks

I will push it toward linux-next after 0-day completes

Jason
