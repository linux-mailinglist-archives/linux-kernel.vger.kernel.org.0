Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16CD357213
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 21:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfFZT67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 15:58:59 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47298 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726104AbfFZT66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 15:58:58 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5QJr6IO008922;
        Wed, 26 Jun 2019 12:58:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=eXlooZuJifFwgXylXX+OEY8KpGxbHwT06IR5u+TuaJc=;
 b=HxK3z5bqhOddGnR6DP4clf3WJCVZFPG9jXQB1h6ORqKwK1c4Kauq5q8otkirpqFZY1a5
 MSGdlt+eQ+UNVURtairf8gfOBMO7LPw8n1JMccku9uL89Om3bpaelDryRbx8AHqtyvDD
 or28+tUicTTnVOEojK3h8PqN12vhWDlKYCs= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2tc80vsrp4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 26 Jun 2019 12:58:07 -0700
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 26 Jun 2019 12:58:04 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 26 Jun 2019 12:58:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXlooZuJifFwgXylXX+OEY8KpGxbHwT06IR5u+TuaJc=;
 b=jwA+yjsat56/A/5QEcUGZICHG+sUSLw2zB9vCTdVUdeGmIHw+mgdmSVxs9KuMzKOsjv9XxXHeYeQEHJ1aUfV5MAiLL+Fjh5qYLbi8YXkqc+8JL+CD9Fftgq8crrI6NZ8SCq/BGmOWlPRkiNaFvrsjK3woYZmkUFNvL2nYZb/uEU=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB3346.namprd15.prod.outlook.com (20.179.75.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Wed, 26 Jun 2019 19:58:02 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::e594:155f:a43:92ad]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::e594:155f:a43:92ad%6]) with mapi id 15.20.2008.018; Wed, 26 Jun 2019
 19:58:02 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Waiman Long <longman@redhat.com>
CC:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        "David Rientjes" <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        "Vladimir Davydov" <vdavydov.dev@gmail.com>
Subject: Re: [PATCH-next] mm, memcg: Add ":deact" tag for reparented kmem
 caches in memcg_slabinfo
Thread-Topic: [PATCH-next] mm, memcg: Add ":deact" tag for reparented kmem
 caches in memcg_slabinfo
Thread-Index: AQHVKFcNglbasX9zCEuQ74vKZQctgaauYjeA
Date:   Wed, 26 Jun 2019 19:58:02 +0000
Message-ID: <20190626195757.GB24698@tower.DHCP.thefacebook.com>
References: <20190621173005.31514-1-longman@redhat.com>
In-Reply-To: <20190621173005.31514-1-longman@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR19CA0009.namprd19.prod.outlook.com
 (2603:10b6:300:d4::19) To BN8PR15MB2626.namprd15.prod.outlook.com
 (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::1:5c5c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24eb911a-de96-4abc-df0a-08d6fa70989e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN8PR15MB3346;
x-ms-traffictypediagnostic: BN8PR15MB3346:
x-microsoft-antispam-prvs: <BN8PR15MB3346A134213FF89F0BB94767BEE20@BN8PR15MB3346.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 00808B16F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(346002)(376002)(396003)(366004)(199004)(189003)(229853002)(71190400001)(6486002)(256004)(5024004)(6436002)(478600001)(486006)(7416002)(46003)(446003)(14444005)(11346002)(476003)(53936002)(6916009)(71200400001)(14454004)(4326008)(86362001)(6246003)(33656002)(9686003)(6512007)(7736002)(305945005)(81166006)(8936002)(6506007)(8676002)(316002)(386003)(81156014)(1076003)(66556008)(66476007)(66946007)(54906003)(99286004)(102836004)(76176011)(52116002)(6116002)(2906002)(25786009)(186003)(68736007)(64756008)(73956011)(66446008)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB3346;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lw9alAOhz9P4hIFTIsnmuNgu27BvNSYa9+vmOzaVy83ggKfuREza0dZuNNPfd6RzsRgZ2H6wOv8wpjeq6ypRC8sAvJDWpUnv2fe6sxhVsYgZtT1DyzOhPwaRu4ye/DdhcjsMaJxSYqWrW7c4WdXC3+vZWHuOPvsIuCHJbljMFQ0jlD5b/LD3LvyFtjTVZcnPd0pZm/n3c9iHwA6CH/QsK6JQ/sMPbOFTNl+OtsdwB01sJ5/loz2b2wvtT5NvsZmCTZYl+ECcs41eDk1Bb1kiBkGwf303gnrFx4IzdiAJUjeyMA/Bhe2Va/eRlijpy3ZXCvtFWlKL0NpfPUMx7tdwqLK0CMT3st8xevwhixk3elWRAVN5t++TnWjENqCodjOtKDmPKbN878h0Vjx2+U6o4ygcsxvxAcVvv0j0Na76/UI=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D278BEA7E85A0F43965A400DA933A352@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 24eb911a-de96-4abc-df0a-08d6fa70989e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2019 19:58:02.6721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guro@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3346
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-26_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906260232
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 01:30:05PM -0400, Waiman Long wrote:
> With Roman's kmem cache reparent patch, multiple kmem caches of the same
> type can be seen attached to the same memcg id. All of them, except
> maybe one, are reparent'ed kmem caches. It can be useful to tag those
> reparented caches by adding a new slab flag "SLAB_DEACTIVATED" to those
> kmem caches that will be reparent'ed if it cannot be destroyed completely=
.
>=20
> For the reparent'ed memcg kmem caches, the tag ":deact" will now be
> shown in <debugfs>/memcg_slabinfo.
>=20
> Signed-off-by: Waiman Long <longman@redhat.com>

Hi Waiman!

Sorry for the late reply. The patch overall looks good to me,
except one nit. Please feel free to use my ack:
Acked-by: Roman Gushchin <guro@fb.com>

> ---
>  include/linux/slab.h |  4 ++++
>  mm/slab.c            |  1 +
>  mm/slab_common.c     | 14 ++++++++------
>  mm/slub.c            |  1 +
>  4 files changed, 14 insertions(+), 6 deletions(-)
>=20
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index fecf40b7be69..19ab1380f875 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -116,6 +116,10 @@
>  /* Objects are reclaimable */
>  #define SLAB_RECLAIM_ACCOUNT	((slab_flags_t __force)0x00020000U)
>  #define SLAB_TEMPORARY		SLAB_RECLAIM_ACCOUNT	/* Objects are short-lived =
*/
> +
> +/* Slab deactivation flag */
> +#define SLAB_DEACTIVATED	((slab_flags_t __force)0x10000000U)
> +
>  /*
>   * ZERO_SIZE_PTR will be returned for zero sized kmalloc requests.
>   *
> diff --git a/mm/slab.c b/mm/slab.c
> index a2e93adf1df0..e8c7743fc283 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -2245,6 +2245,7 @@ int __kmem_cache_shrink(struct kmem_cache *cachep)
>  #ifdef CONFIG_MEMCG
>  void __kmemcg_cache_deactivate(struct kmem_cache *cachep)
>  {
> +	cachep->flags |=3D SLAB_DEACTIVATED;

A nit: it can be done from kmemcg_cache_deactivate() instead,
and then you don't have to do it in slab and slub separately.

Since it's not slab- or slub-specific code, it'd be better, IMO,
to put it into slab_common.c.

Thanks!

>  	__kmem_cache_shrink(cachep);
>  }
> =20
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 146d8eaa639c..85cf0c374303 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1533,7 +1533,7 @@ static int memcg_slabinfo_show(struct seq_file *m, =
void *unused)
>  	struct slabinfo sinfo;
> =20
>  	mutex_lock(&slab_mutex);
> -	seq_puts(m, "# <name> <css_id[:dead]> <active_objs> <num_objs>");
> +	seq_puts(m, "# <name> <css_id[:dead|deact]> <active_objs> <num_objs>");
>  	seq_puts(m, " <active_slabs> <num_slabs>\n");
>  	list_for_each_entry(s, &slab_root_caches, root_caches_node) {
>  		/*
> @@ -1544,22 +1544,24 @@ static int memcg_slabinfo_show(struct seq_file *m=
, void *unused)
> =20
>  		memset(&sinfo, 0, sizeof(sinfo));
>  		get_slabinfo(s, &sinfo);
> -		seq_printf(m, "%-17s root      %6lu %6lu %6lu %6lu\n",
> +		seq_printf(m, "%-17s root       %6lu %6lu %6lu %6lu\n",
>  			   cache_name(s), sinfo.active_objs, sinfo.num_objs,
>  			   sinfo.active_slabs, sinfo.num_slabs);
> =20
>  		for_each_memcg_cache(c, s) {
>  			struct cgroup_subsys_state *css;
> -			char *dead =3D "";
> +			char *status =3D "";
> =20
>  			css =3D &c->memcg_params.memcg->css;
>  			if (!(css->flags & CSS_ONLINE))
> -				dead =3D ":dead";
> +				status =3D ":dead";
> +			else if (c->flags & SLAB_DEACTIVATED)
> +				status =3D ":deact";
> =20
>  			memset(&sinfo, 0, sizeof(sinfo));
>  			get_slabinfo(c, &sinfo);
> -			seq_printf(m, "%-17s %4d%5s %6lu %6lu %6lu %6lu\n",
> -				   cache_name(c), css->id, dead,
> +			seq_printf(m, "%-17s %4d%-6s %6lu %6lu %6lu %6lu\n",
> +				   cache_name(c), css->id, status,
>  				   sinfo.active_objs, sinfo.num_objs,
>  				   sinfo.active_slabs, sinfo.num_slabs);
>  		}
> diff --git a/mm/slub.c b/mm/slub.c
> index a384228ff6d3..c965b4413658 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4057,6 +4057,7 @@ void __kmemcg_cache_deactivate(struct kmem_cache *s=
)
>  	 */
>  	slub_set_cpu_partial(s, 0);
>  	s->min_partial =3D 0;
> +	s->flags |=3D SLAB_DEACTIVATED;
>  }
>  #endif	/* CONFIG_MEMCG */
> =20
> --=20
> 2.18.1
>=20
