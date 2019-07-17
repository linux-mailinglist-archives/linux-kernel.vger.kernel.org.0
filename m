Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDD206C009
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2019 19:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbfGQRCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 13:02:25 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:36411 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbfGQRCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 13:02:25 -0400
Received: by mail-yb1-f196.google.com with SMTP id d9so3528878ybf.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 10:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BgLO7AOlxApfrZ8As7HxY8L1byop/yjZk5edDlBCjHc=;
        b=BIgpOWELXYgjF12yzOPDUoGbuLq1zi1FwFQmt9xkcQGc5AVH1aQ1fmd7au9DmtxE77
         SY+UU54YPYCG1nAZxTVSGzseRtCjafwhDZ4sq+T155nDh5SQweIb9Kv9bmYkXEF0rBAi
         Jce01AB+F19yWiKmos650B41EbFmKiIZJwLInUaHQalp7zYlU1jxlVWD9vhSa/fRuu6a
         b7nzcGo609oS8EbLaA+IMQnzkmWt+L0RtcEdtpSxuAl99/rSV6wMPBnSXbct22f0l89n
         1tIqPXgR2BPMAU6RK7mybiSNYzP5Ck/ztcB15ywooaPz0qniKKdifZmb+u3kc6V6fdgA
         eNUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BgLO7AOlxApfrZ8As7HxY8L1byop/yjZk5edDlBCjHc=;
        b=hiR0EMwrmveXKvbRiFEgX+MmfNj0LPeLR4PyPKPb82PeS5BztataQRZMPIruDg5rGK
         w0wJEBToxShoPJWoCPStxI7ebk1mkyWORmmYGIRBHdPlcSQa9WRVx8aKv9UJavSlpjau
         RFbOZ7zMNWfv0myz+iaAVtpTcuO8LFw34Gel4OSw8w/XltuWvx6nTXOKBX1/WpAFIKDz
         Sc0czHMXwoxaggCBOaijbRG7QKVUNm/MJX84pKki3ZdNC7aw0bnzEyIfdThk1vH5JkQ0
         FTv/If8nbHfUeY0x2nKKfNj3EKzVy6+k9NICyDQkbNxrYUrwimgSaJ6f9yWHiXohMQd3
         zUMw==
X-Gm-Message-State: APjAAAWS02rgV1/Mr8gHkNiVmgIlgw/eyg0Z/y7sYvduSVnVT4Bvv0wF
        Z1eFIGzBVpCoBeV6BE5SRGTisNfVhenJUaB7J3WuhA==
X-Google-Smtp-Source: APXvYqyzz4GHd+f0tyqhFDhqf2xn/zwFnrM7OEtFPR5C7USenjzkjt+qzoGBfAeU/vHGi6p5DKvh/u3O85iL5H8T2SE=
X-Received: by 2002:a25:6412:: with SMTP id y18mr13200161ybb.100.1563382943463;
 Wed, 17 Jul 2019 10:02:23 -0700 (PDT)
MIME-Version: 1.0
References: <1562795006.8510.19.camel@lca.pw> <cd6e10bc-cb79-65c5-ff2b-4c244ae5eb1c@linux.alibaba.com>
 <1562879229.8510.24.camel@lca.pw> <b38ee633-f8e0-00ee-55ee-2f0aaea9ed6b@linux.alibaba.com>
 <1563225798.4610.5.camel@lca.pw> <5c853e6e-6367-d83c-bb97-97cd67320126@linux.alibaba.com>
 <8A64D551-FF5B-4068-853E-9E31AF323517@lca.pw> <e5aa1f5b-b955-5b8e-f502-7ac5deb141a7@linux.alibaba.com>
 <CALvZod7+ComCUROSBaj==r0VmCczs=npP4u6C9LuJWNWdfB0Pg@mail.gmail.com> <50f57bf8-a71a-c61f-74f7-31fb7bfe3253@linux.alibaba.com>
In-Reply-To: <50f57bf8-a71a-c61f-74f7-31fb7bfe3253@linux.alibaba.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 17 Jul 2019 10:02:11 -0700
Message-ID: <CALvZod7Je+gekSGR61LMeHdYoC_PJune_0qGNiDfNH2=oNeOgw@mail.gmail.com>
Subject: Re: list corruption in deferred_split_scan()
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Qian Cai <cai@lca.pw>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 5:12 PM Yang Shi <yang.shi@linux.alibaba.com> wrote=
:
>
>
>
> On 7/16/19 4:36 PM, Shakeel Butt wrote:
> > Adding related people.
> >
> > The thread starts at:
> > http://lkml.kernel.org/r/1562795006.8510.19.camel@lca.pw
> >
> > On Mon, Jul 15, 2019 at 8:01 PM Yang Shi <yang.shi@linux.alibaba.com> w=
rote:
> >>
> >>
> >> On 7/15/19 6:36 PM, Qian Cai wrote:
> >>>> On Jul 15, 2019, at 8:22 PM, Yang Shi <yang.shi@linux.alibaba.com> w=
rote:
> >>>>
> >>>>
> >>>>
> >>>> On 7/15/19 2:23 PM, Qian Cai wrote:
> >>>>> On Fri, 2019-07-12 at 12:12 -0700, Yang Shi wrote:
> >>>>>>> Another possible lead is that without reverting the those commits=
 below,
> >>>>>>> kdump
> >>>>>>> kernel would always also crash in shrink_slab_memcg() at this lin=
e,
> >>>>>>>
> >>>>>>> map =3D rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_=
map, true);
> >>>>>> This looks a little bit weird. It seems nodeinfo[nid] is NULL? I d=
idn't
> >>>>>> think of where nodeinfo was freed but memcg was still online. Mayb=
e a
> >>>>>> check is needed:
> >>>>> Actually, "memcg" is NULL.
> >>>> It sounds weird. shrink_slab() is called in mem_cgroup_iter which do=
es pin the memcg. So, the memcg should not go away.
> >>> Well, the commit =E2=80=9Cmm: shrinker: make shrinker not depend on m=
emcg kmem=E2=80=9D changed this line in shrink_slab_memcg(),
> >>>
> >>> -     if (!memcg_kmem_enabled() || !mem_cgroup_online(memcg))
> >>> +     if (!mem_cgroup_online(memcg))
> >>>                return 0;
> >>>
> >>> Since the kdump kernel has the parameter =E2=80=9Ccgroup_disable=3Dme=
mory=E2=80=9D, shrink_slab_memcg() will no longer be able to handle NULL me=
mcg from mem_cgroup_iter() as,
> >>>
> >>> if (mem_cgroup_disabled())
> >>>        return NULL;
> >> Aha, yes. memcg_kmem_enabled() implicitly checks !mem_cgroup_disabled(=
).
> >> Thanks for figuring this out. I think we need add mem_cgroup_dsiabled(=
)
> >> check before calling shrink_slab_memcg() as below:
> >>
> >> diff --git a/mm/vmscan.c b/mm/vmscan.c
> >> index a0301ed..2f03c61 100644
> >> --- a/mm/vmscan.c
> >> +++ b/mm/vmscan.c
> >> @@ -701,7 +701,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, i=
nt
> >> nid,
> >>           unsigned long ret, freed =3D 0;
> >>           struct shrinker *shrinker;
> >>
> >> -       if (!mem_cgroup_is_root(memcg))
> >> +       if (!mem_cgroup_disabled() && !mem_cgroup_is_root(memcg))
> >>                   return shrink_slab_memcg(gfp_mask, nid, memcg, prior=
ity);
> >>
> >>           if (!down_read_trylock(&shrinker_rwsem))
> >>
> > We were seeing unneeded oom-kills on kernels with
> > "cgroup_disabled=3Dmemory" and Yang's patch series basically expose the
> > bug to crash. I think the commit aeed1d325d42 ("mm/vmscan.c:
> > generalize shrink_slab() calls in shrink_node()") missed the case for
> > "cgroup_disabled=3Dmemory". However I am surprised that root_mem_cgroup
> > is allocated even for "cgroup_disabled=3Dmemory" and it seems like
> > css_alloc() is called even before checking if the corresponding
> > controller is disabled.
>
> I'm surprised too. A quick test with drgn shows root memcg is definitely
> allocated:
>
>  >>> prog['root_mem_cgroup']
> *(struct mem_cgroup *)0xffff8902cf058000 =3D {
> [snip]
>
> But, isn't this a bug?

It can be treated as a bug as this is not expected but we can discuss
and take care of it later. I think we need your patch urgently as
memory reclaim and /proc/sys/vm/drop_caches is broken for
"cgroup_disabled=3Dmemory" kernel. So, please send your patch asap.

thanks,
Shakeel
