Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2F872E25A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 18:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbfE2QgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 12:36:09 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60058 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726649AbfE2QgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 12:36:09 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4TGUDbr005372;
        Wed, 29 May 2019 09:34:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=68QJp/9GWPKZeUMv38AINs5dOsOJ0DS3XFPTCQmC9Pc=;
 b=jXRqb5AJV7BkUd+DT8ObPGQ7AvP5VkLh7NUnGACrzNCuYrwb6PjHzFirwHeCb7fucQk1
 6VRayYN28TSHkQWxrM1dnsNpJB36Tx7mFNtdPNjJOKkmwfzfAj4daiuIa/8sEaIv6PBb
 cAuOutxW1J2m6Am3UojNOir/Pzst2K71Y3c= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2sswbt032d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 29 May 2019 09:34:44 -0700
Received: from ash-exhub104.TheFacebook.com (2620:10d:c0a8:82::d) by
 ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 29 May 2019 09:34:43 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 29 May 2019 09:34:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68QJp/9GWPKZeUMv38AINs5dOsOJ0DS3XFPTCQmC9Pc=;
 b=nWcHu1NOiiYo7Hl+DSxb+8A6rZiMAu+YH3sB8XpquwZNkTTTXxL104LqoJHiJ3qZMlxWfkFh/ZGPRtL4Fv/Z8WzKPXcGyyBA2v9X58ogZ+5owPTnHc0+AX2+cmkgDW0TMgmTW6sXbTnryzDSjAhMZ7STEJ3ehiWLcUNtxWgxRHs=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB3239.namprd15.prod.outlook.com (20.179.57.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.16; Wed, 29 May 2019 16:34:40 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a%7]) with mapi id 15.20.1922.021; Wed, 29 May 2019
 16:34:40 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Uladzislau Rezki <urezki@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        "Oleksiy Avramchenko" <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 2/4] mm/vmap: preload a CPU with one object for split
 purpose
Thread-Topic: [PATCH v3 2/4] mm/vmap: preload a CPU with one object for split
 purpose
Thread-Index: AQHVFHAH7qEvKKmW0EiXhNmDjWGv56aArvuAgAF9XoCAACOTgA==
Date:   Wed, 29 May 2019 16:34:40 +0000
Message-ID: <20190529163435.GC3228@tower.DHCP.thefacebook.com>
References: <20190527093842.10701-1-urezki@gmail.com>
 <20190527093842.10701-3-urezki@gmail.com>
 <20190528224217.GG27847@tower.DHCP.thefacebook.com>
 <20190529142715.pxzrjthsthqudgh2@pc636>
In-Reply-To: <20190529142715.pxzrjthsthqudgh2@pc636>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR01CA0038.prod.exchangelabs.com (2603:10b6:300:101::24)
 To BYAPR15MB2631.namprd15.prod.outlook.com (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:d07b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 39e111f0-908c-4206-fff2-08d6e4538bcd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR15MB3239;
x-ms-traffictypediagnostic: BYAPR15MB3239:
x-microsoft-antispam-prvs: <BYAPR15MB3239E70EF2617D42E24323E3BE1F0@BYAPR15MB3239.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(136003)(346002)(376002)(366004)(199004)(189003)(53936002)(386003)(14454004)(6116002)(8936002)(6506007)(186003)(52116002)(1411001)(99286004)(1076003)(2906002)(46003)(9686003)(6436002)(5660300002)(6512007)(54906003)(6486002)(229853002)(76176011)(25786009)(68736007)(6246003)(102836004)(4326008)(71190400001)(73956011)(66946007)(64756008)(66446008)(316002)(11346002)(66476007)(71200400001)(14444005)(7416002)(256004)(33656002)(86362001)(476003)(446003)(478600001)(8676002)(81156014)(81166006)(486006)(305945005)(7736002)(6916009)(66556008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3239;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kEVtILsHANZ1lM8be6+ETNeTUvkV4W6Mlm9hg61IPQSI7soDfpfclwcqRm61Wt6pgDXesxF6p6FHmry+ZOxr/kTvDcL3VvD909CViJp8C/3uWhKL1bBzrdMJjQwmGEAaP1fv9lkIKDR6CyYRMfOyixnV3O7QGebbXsBF0s1tcZBqbt7bXOEJwpSHYZbpye7AptMnN3ARiiI+av1ILpzaudGj8YR53M/z0j40Y82HSODfXw61d7XTJx7s5TwM4oXjACkLErGJvWQNd0XGeUGPICItrhYB+KUgRYhpqVFvrU6l24LWM/Q6isNjJG8OJCG2laSsfEKcPbbQ8rDrF/N2ZMC3MiDgJXzv9stJOPRI4GGb53IGkBthKs1o4BIeKtCgIHLBi9LyFHYuMcUi9JECra/D67G/yQeP+Kjm/msPbq4=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <466CE007B442AC419E80CF8A69C27DA9@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e111f0-908c-4206-fff2-08d6e4538bcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 16:34:40.1673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guro@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3239
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-29_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905290108
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 04:27:15PM +0200, Uladzislau Rezki wrote:
> Hello, Roman!
>=20
> > On Mon, May 27, 2019 at 11:38:40AM +0200, Uladzislau Rezki (Sony) wrote=
:
> > > Refactor the NE_FIT_TYPE split case when it comes to an
> > > allocation of one extra object. We need it in order to
> > > build a remaining space.
> > >=20
> > > Introduce ne_fit_preload()/ne_fit_preload_end() functions
> > > for preloading one extra vmap_area object to ensure that
> > > we have it available when fit type is NE_FIT_TYPE.
> > >=20
> > > The preload is done per CPU in non-atomic context thus with
> > > GFP_KERNEL allocation masks. More permissive parameters can
> > > be beneficial for systems which are suffer from high memory
> > > pressure or low memory condition.
> > >=20
> > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > ---
> > >  mm/vmalloc.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++---
> > >  1 file changed, 76 insertions(+), 3 deletions(-)
> >=20
> > Hi Uladzislau!
> >=20
> > This patch generally looks good to me (see some nits below),
> > but it would be really great to add some motivation, e.g. numbers.
> >=20
> The main goal of this patch to get rid of using GFP_NOWAIT since it is
> more restricted due to allocation from atomic context. IMHO, if we can
> avoid of using it that is a right way to go.
>=20
> From the other hand, as i mentioned before i have not seen any issues
> with that on all my test systems during big rework. But it could be
> beneficial for tiny systems where we do not have any swap and are
> limited in memory size.

Ok, that makes sense to me. Is it possible to emulate such a tiny system
on kvm and measure the benefits? Again, not a strong opinion here,
but it will be easier to justify adding a good chunk of code.

>=20
> > >=20
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index ea1b65fac599..b553047aa05b 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -364,6 +364,13 @@ static LIST_HEAD(free_vmap_area_list);
> > >   */
> > >  static struct rb_root free_vmap_area_root =3D RB_ROOT;
> > > =20
> > > +/*
> > > + * Preload a CPU with one object for "no edge" split case. The
> > > + * aim is to get rid of allocations from the atomic context, thus
> > > + * to use more permissive allocation masks.
> > > + */
> > > +static DEFINE_PER_CPU(struct vmap_area *, ne_fit_preload_node);
> > > +
> > >  static __always_inline unsigned long
> > >  va_size(struct vmap_area *va)
> > >  {
> > > @@ -950,9 +957,24 @@ adjust_va_to_fit_type(struct vmap_area *va,
> > >  		 *   L V  NVA  V R
> > >  		 * |---|-------|---|
> > >  		 */
> > > -		lva =3D kmem_cache_alloc(vmap_area_cachep, GFP_NOWAIT);
> > > -		if (unlikely(!lva))
> > > -			return -1;
> > > +		lva =3D __this_cpu_xchg(ne_fit_preload_node, NULL);
> > > +		if (unlikely(!lva)) {
> > > +			/*
> > > +			 * For percpu allocator we do not do any pre-allocation
> > > +			 * and leave it as it is. The reason is it most likely
> > > +			 * never ends up with NE_FIT_TYPE splitting. In case of
> > > +			 * percpu allocations offsets and sizes are aligned to
> > > +			 * fixed align request, i.e. RE_FIT_TYPE and FL_FIT_TYPE
> > > +			 * are its main fitting cases.
> > > +			 *
> > > +			 * There are a few exceptions though, as an example it is
> > > +			 * a first allocation (early boot up) when we have "one"
> > > +			 * big free space that has to be split.
> > > +			 */
> > > +			lva =3D kmem_cache_alloc(vmap_area_cachep, GFP_NOWAIT);
> > > +			if (!lva)
> > > +				return -1;
> > > +		}
> > > =20
> > >  		/*
> > >  		 * Build the remainder.
> > > @@ -1023,6 +1045,48 @@ __alloc_vmap_area(unsigned long size, unsigned=
 long align,
> > >  }
> > > =20
> > >  /*
> > > + * Preload this CPU with one extra vmap_area object to ensure
> > > + * that we have it available when fit type of free area is
> > > + * NE_FIT_TYPE.
> > > + *
> > > + * The preload is done in non-atomic context, thus it allows us
> > > + * to use more permissive allocation masks to be more stable under
> > > + * low memory condition and high memory pressure.
> > > + *
> > > + * If success it returns 1 with preemption disabled. In case
> > > + * of error 0 is returned with preemption not disabled. Note it
> > > + * has to be paired with ne_fit_preload_end().
> > > + */
> > > +static int
> >=20
> > Cosmetic nit: you don't need a new line here.
> >=20
> > > +ne_fit_preload(int nid)
> >=20
> I can fix that.
>=20
> > > +{
> > > +	preempt_disable();
> > > +
> > > +	if (!__this_cpu_read(ne_fit_preload_node)) {
> > > +		struct vmap_area *node;
> > > +
> > > +		preempt_enable();
> > > +		node =3D kmem_cache_alloc_node(vmap_area_cachep, GFP_KERNEL, nid);
> > > +		if (node =3D=3D NULL)
> > > +			return 0;
> > > +
> > > +		preempt_disable();
> > > +
> > > +		if (__this_cpu_cmpxchg(ne_fit_preload_node, NULL, node))
> > > +			kmem_cache_free(vmap_area_cachep, node);
> > > +	}
> > > +
> > > +	return 1;
> > > +}
> > > +
> > > +static void
> >=20
> > Here too.
> >=20
> > > +ne_fit_preload_end(int preloaded)
> > > +{
> > > +	if (preloaded)
> > > +		preempt_enable();
> > > +}
> I can fix that.
>=20
> >=20
> > I'd open code it. It's used only once, but hiding preempt_disable()
> > behind a helper makes it harder to understand and easier to mess.
> >=20
> > Then ne_fit_preload() might require disabled preemption (which it can
> > temporarily re-enable), so that preempt_enable()/disable() logic
> > will be in one place.
> >=20
> I see your point. One of the aim was to make less clogged the
> alloc_vmap_area() function. But we can refactor it like you say:
>=20
> <snip>
>  static void
> @@ -1091,7 +1089,7 @@ static struct vmap_area *alloc_vmap_area(unsigned l=
ong size,
>                                 unsigned long vstart, unsigned long vend,
>                                 int node, gfp_t gfp_mask)
>  {
> -       struct vmap_area *va;
> +       struct vmap_area *va, *pva;
>         unsigned long addr;
>         int purged =3D 0;
>         int preloaded;
> @@ -1122,16 +1120,26 @@ static struct vmap_area *alloc_vmap_area(unsigned=
 long size,
>          * Just proceed as it is. "overflow" path will refill
>          * the cache we allocate from.
>          */
> -       ne_fit_preload(&preloaded);
> +       preempt_disable();
> +       if (!__this_cpu_read(ne_fit_preload_node)) {
> +               preempt_enable();
> +               pva =3D kmem_cache_alloc_node(vmap_area_cachep, GFP_KERNE=
L, node);
> +               preempt_disable();
> +
> +               if (__this_cpu_cmpxchg(ne_fit_preload_node, NULL, pva)) {
> +                       if (pva)
> +                               kmem_cache_free(vmap_area_cachep, pva);
> +               }
> +       }
> +
>         spin_lock(&vmap_area_lock);
> +       preempt_enable();
> =20
>         /*
>          * If an allocation fails, the "vend" address is
>          * returned. Therefore trigger the overflow path.
>          */
>         addr =3D __alloc_vmap_area(size, align, vstart, vend);
> -       ne_fit_preload_end(preloaded);
> -
>         if (unlikely(addr =3D=3D vend))
>                 goto overflow;
> <snip>
>=20
> Do you mean something like that? If so, i can go with that, unless there =
are no
> any objections from others.

Yes, it looks much better to me!

Thank you!
