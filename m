Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DECF25FD9A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2019 21:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbfGDT7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jul 2019 15:59:43 -0400
Received: from mail-eopbgr40080.outbound.protection.outlook.com ([40.107.4.80]:7118
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726038AbfGDT7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 15:59:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVGOHmLSP/JIZtqpwRtiDiY1SzX40ljEnPrYndO1vII=;
 b=qW39W5DO8ZPjCLawPUoIOl9ykwyA1mN7FyeohBoGboPGP2l/bY/S9IYz7YJPOEnYAeDnIhKv7geh+kz412/1TQEbzeWJ7ckn7uS8K6tcIr0CYWWeGuE0PtMOvXJ80wYt9KK6oWUQ0z0Boy5eAYLKBjuDuNE/Yi2gZXFsKj3xNrw=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB3167.eurprd05.prod.outlook.com (10.170.237.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Thu, 4 Jul 2019 19:59:39 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2032.019; Thu, 4 Jul 2019
 19:59:39 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Christoph Hellwig <hch@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 0/4] Devmap cleanups + arm64 support
Thread-Topic: [PATCH v3 0/4] Devmap cleanups + arm64 support
Thread-Index: AQHVK/HAM2r3dJ5EjUuvQfApLyHQmKat3lEAgAA0MoCAAAH5AIAAxnaAgAwArgCAABJ8AA==
Date:   Thu, 4 Jul 2019 19:59:38 +0000
Message-ID: <20190704195934.GA23542@mellanox.com>
References: <cover.1558547956.git.robin.murphy@arm.com>
 <20190626073533.GA24199@infradead.org>
 <20190626123139.GB20635@lakrids.cambridge.arm.com>
 <20190626153829.GA22138@infradead.org> <20190626154532.GA3088@mellanox.com>
 <20190626203551.4612e12be27be3458801703b@linux-foundation.org>
 <20190704115324.c9780d01ef6938ab41403bf9@linux-foundation.org>
In-Reply-To: <20190704115324.c9780d01ef6938ab41403bf9@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR01CA0017.prod.exchangelabs.com (2603:10b6:208:10c::30)
 To VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5bcf9b6e-f6b5-43f1-0787-08d700ba2543
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB3167;
x-ms-traffictypediagnostic: VI1PR05MB3167:
x-microsoft-antispam-prvs: <VI1PR05MB31673E959366D797D0F55226CFFA0@VI1PR05MB3167.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1051;
x-forefront-prvs: 0088C92887
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(189003)(199004)(54906003)(476003)(2616005)(7736002)(305945005)(186003)(446003)(11346002)(7416002)(53936002)(478600001)(6512007)(6246003)(229853002)(316002)(6436002)(14454004)(33656002)(6486002)(2906002)(256004)(99286004)(76176011)(8936002)(1076003)(36756003)(68736007)(386003)(6506007)(66066001)(71200400001)(102836004)(25786009)(86362001)(26005)(66446008)(71190400001)(64756008)(66476007)(486006)(66556008)(81156014)(4326008)(81166006)(6916009)(8676002)(3846002)(52116002)(66946007)(5660300002)(73956011)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3167;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5FQR5yQC+//7srTU9m1LCNnAMEM/TLHDdkInE9OLvXRPtlk4D5Qp6NyskQNYKVt/RsRSFT8bGxMLNwfaRainxw4PKuFQCbyW6wzGMJmdh3B+wkTxyGFaPPUhr5O0niY3+hOpmgrSOqjP1gwjRYrxdadYKB1rRzhT8wzIkwJZl4FRhmDdO1nMXLvWqsrqFOZySjGgN8X9d1rwtGw0ujeLfj9SdVCKukEToOXli0J1redwycxy31Zerk0EqSfU8sk1PP00V7QLcyjzmsUp8BAjCT9fqdK8/VG5J+WTlmob3rLQrLoO/ycv/Rv2IZIcoFsH8Q5xhlKDSDOnhGPKFC70p3Xkj1anqobtgSg1IBYxDpzUjJoDsLgmCYS9HF/Qq0ngmXdTPJZqChFCg1Bu/cGnh+rid/d1ox7nYJpPbJV9aqg=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E7B95E329110B24BA206433070923C07@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bcf9b6e-f6b5-43f1-0787-08d700ba2543
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2019 19:59:38.9039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3167
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 11:53:24AM -0700, Andrew Morton wrote:
> On Wed, 26 Jun 2019 20:35:51 -0700 Andrew Morton <akpm@linux-foundation.o=
rg> wrote:
>=20
> > > Let me know and I can help orchestate this.
> >=20
> > Well.  Whatever works.  In this situation I'd stage the patches after
> > linux-next and would merge them up after the prereq patches have been
> > merged into mainline.  Easy.
>=20
> All right, what the hell just happened?=20

Christoph's patch series for the devmap & hmm rework finally made it
into linux-next, sorry, it took quite a few iterations on the list to
get all the reviews and tests, and figure out how to resolve some
other conflicting things. So it just made it this week.

Recall, this is the patch series I asked you about routing a few weeks
ago, as it really exceeded the small area that hmm.git was supposed to
cover. I think we are both caught off guard how big the conflict is!

> A bunch of new material has just been introduced into linux-next.
> I've partially unpicked the resulting mess, haven't dared trying to
> compile it yet.  To get this far I'll need to drop two patch series
> and one individual patch:
 =20
> mm-clean-up-is_device__page-definitions.patch
> mm-introduce-arch_has_pte_devmap.patch
> arm64-mm-implement-pte_devmap-support.patch
> arm64-mm-implement-pte_devmap-support-fix.patch

This one we discussed, and I thought we agreed would go to your 'stage
after linux-next' flow (see above). I think the conflict was minor
here.

> mm-sparsemem-introduce-struct-mem_section_usage.patch
> mm-sparsemem-introduce-a-section_is_early-flag.patch
> mm-sparsemem-add-helpers-track-active-portions-of-a-section-at-boot.patch
> mm-hotplug-prepare-shrink_zone-pgdat_span-for-sub-section-removal.patch
> mm-sparsemem-convert-kmalloc_section_memmap-to-populate_section_memmap.pa=
tch
> mm-hotplug-kill-is_dev_zone-usage-in-__remove_pages.patch
> mm-kill-is_dev_zone-helper.patch
> mm-sparsemem-prepare-for-sub-section-ranges.patch
> mm-sparsemem-support-sub-section-hotplug.patch
> mm-document-zone_device-memory-model-implications.patch
> mm-document-zone_device-memory-model-implications-fix.patch
> mm-devm_memremap_pages-enable-sub-section-remap.patch
> libnvdimm-pfn-fix-fsdax-mode-namespace-info-block-zero-fields.patch
> libnvdimm-pfn-stop-padding-pmem-namespaces-to-section-alignment.patch

Dan pointed to this while reviewing CH's series and said the conflicts
would be manageable, but they are certainly larger than I expected!

This series is the one that seems to be the really big trouble. I
already checked all the other stuff that Stephen resolved, and it
looks OK and managable. Just this one conflict with kernel/memremap.c
is beyond me.=20

What approach do you want to take to go forward? Here are some thoughts:

CH has said he is away for the long weekend, so the path that involves
the fewest people is if Dan respins the above on linux-next and it
goes later with the arm patches above, assuming defering it for now
has no other adverse effects on -mm.

Pushing CH's series to -mm would need a respin on top of Dan's series
above and would need to carry along the whole hmm.git (about 44
patches). Signs are that this could be managed with the code currently
in the GPU trees.

If we give up on CH's series the hmm.git will not have conflicts,
however we just kick the can to the next merge window where we will be
back to having to co-ordinate amd/nouveau/rdma git trees and -mm's
patch workflow - and I think we will be worse off as we will have
totally given up on a git based work flow for this. :(

> mm-sparsemem-cleanup-section-number-data-types.patch
> mm-sparsemem-cleanup-section-number-data-types-fix.patch

Stephen used a minor conflict resolution for this one, I checked it
carefully and it looked OK.

> I thought you were just going to move material out of -mm and into
> hmm.git. =20

Dan brought up a patch from Ira conflicting with CH's work and we did
handle that by moving a single patch, as well I moved several hmm
specific patches early in the cycle.

> Didn't begin to suspect that new and quite disruptive material would
> be introduced late in -rc7!!

Unfortunately a non-rebasing tree like hmm.git should only get patches
into linux-next once they are fully reviewed and done on the list. I
did not attempt to run separately patches 'under review' into
linux-next as you do.=20

Actually I didn't even know this would benefit your workflow, rebasing
patches on top of linux-next is not part of the git based workflow I'm
using :(

AFAIK Dan and CH were both tracking conflicts with linux-next, so I'd
like to hear from Dan what he thinks about his series, maybe the
rebase is simple & safe for him? Dan and CH were working pretty
closely on CH's series.

Jason
