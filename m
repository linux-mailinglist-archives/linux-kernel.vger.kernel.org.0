Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8194D0BE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 16:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfFTOtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 10:49:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45280 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbfFTOtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 10:49:04 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 08B4BC057F2C;
        Thu, 20 Jun 2019 14:48:48 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AC71960624;
        Thu, 20 Jun 2019 14:48:38 +0000 (UTC)
Subject: Re: [PATCH v2] mm, memcg: Add a memcg_slabinfo debugfs file
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
References: <20190619171621.26209-1-longman@redhat.com>
 <CALvZod7pdOx0a1v4oX5-7ZfCykM8iwRwPkW-+gbO1B4+j1SXqw@mail.gmail.com>
 <cfc6c800-1cb4-e2f2-e6d9-f0571c11a47b@redhat.com>
 <CALvZod4oOddDvuvuXyp=p2Dq=h354a-D72daagfya_Ewp_ggSA@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <7ef40b7a-5473-d5d8-6b56-3943fbce91ec@redhat.com>
Date:   Thu, 20 Jun 2019 10:48:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CALvZod4oOddDvuvuXyp=p2Dq=h354a-D72daagfya_Ewp_ggSA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 20 Jun 2019 14:49:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/20/19 10:39 AM, Shakeel Butt wrote:
> On Thu, Jun 20, 2019 at 7:24 AM Waiman Long <longman@redhat.com> wrote:
>> On 6/19/19 7:48 PM, Shakeel Butt wrote:
>>> Hi Waiman,
>>>
>>> On Wed, Jun 19, 2019 at 10:16 AM Waiman Long <longman@redhat.com> wrote:
>>>> There are concerns about memory leaks from extensive use of memory
>>>> cgroups as each memory cgroup creates its own set of kmem caches. There
>>>> is a possiblity that the memcg kmem caches may remain even after the
>>>> memory cgroups have been offlined. Therefore, it will be useful to show
>>>> the status of each of memcg kmem caches.
>>>>
>>>> This patch introduces a new <debugfs>/memcg_slabinfo file which is
>>>> somewhat similar to /proc/slabinfo in format, but lists only information
>>>> about kmem caches that have child memcg kmem caches. Information
>>>> available in /proc/slabinfo are not repeated in memcg_slabinfo.
>>>>
>>>> A portion of a sample output of the file was:
>>>>
>>>>   # <name> <css_id[:dead]> <active_objs> <num_objs> <active_slabs> <num_slabs>
>>>>   rpc_inode_cache   root          13     51      1      1
>>>>   rpc_inode_cache     48           0      0      0      0
>>>>   fat_inode_cache   root           1     45      1      1
>>>>   fat_inode_cache     41           2     45      1      1
>>>>   xfs_inode         root         770    816     24     24
>>>>   xfs_inode           92          22     34      1      1
>>>>   xfs_inode           88:dead      1     34      1      1
>>>>   xfs_inode           89:dead     23     34      1      1
>>>>   xfs_inode           85           4     34      1      1
>>>>   xfs_inode           84           9     34      1      1
>>>>
>>>> The css id of the memcg is also listed. If a memcg is not online,
>>>> the tag ":dead" will be attached as shown above.
>>>>
>>>> Suggested-by: Shakeel Butt <shakeelb@google.com>
>>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>>> ---
>>>>  mm/slab_common.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 57 insertions(+)
>>>>
>>>> diff --git a/mm/slab_common.c b/mm/slab_common.c
>>>> index 58251ba63e4a..2bca1558a722 100644
>>>> --- a/mm/slab_common.c
>>>> +++ b/mm/slab_common.c
>>>> @@ -17,6 +17,7 @@
>>>>  #include <linux/uaccess.h>
>>>>  #include <linux/seq_file.h>
>>>>  #include <linux/proc_fs.h>
>>>> +#include <linux/debugfs.h>
>>>>  #include <asm/cacheflush.h>
>>>>  #include <asm/tlbflush.h>
>>>>  #include <asm/page.h>
>>>> @@ -1498,6 +1499,62 @@ static int __init slab_proc_init(void)
>>>>         return 0;
>>>>  }
>>>>  module_init(slab_proc_init);
>>>> +
>>>> +#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_MEMCG_KMEM)
>>>> +/*
>>>> + * Display information about kmem caches that have child memcg caches.
>>>> + */
>>>> +static int memcg_slabinfo_show(struct seq_file *m, void *unused)
>>>> +{
>>>> +       struct kmem_cache *s, *c;
>>>> +       struct slabinfo sinfo;
>>>> +
>>>> +       mutex_lock(&slab_mutex);
>>> On large machines there can be thousands of memcgs and potentially
>>> each memcg can have hundreds of kmem caches. So, the slab_mutex can be
>>> held for a very long time.
>> But that is also what /proc/slabinfo does by doing mutex_lock() at
>> slab_start() and mutex_unlock() at slab_stop(). So the same problem will
>> happen when /proc/slabinfo is being read.
>>
>> When you are in a situation that reading /proc/slabinfo take a long time
>> because of the large number of memcg's, the system is in some kind of
>> trouble anyway. I am saying that we should not improve the scalability
>> of this patch. It is just that some nasty race conditions may pop up if
>> we release the lock and re-acquire it latter. That will greatly
>> complicate the code to handle all those edge cases.
>>
> We have been using that interface and implementation for couple of
> years and have not seen any race condition. However I am fine with
> what you have here for now. We can always come back if we think we
> need to improve it.
>
>>> Our internal implementation traverses the memcg tree and then
>>> traverses 'memcg->kmem_caches' within the slab_mutex (and
>>> cond_resched() after unlock).
>> For cgroup v1, the setting of the CONFIG_SLUB_DEBUG option will allow
>> you to iterate and display slabinfo just for that particular memcg. I am
>> thinking of extending the debug controller to do similar thing for
>> cgroup v2.
> I was also planning to look into that and it seems like you are
> already on it. Do CC me the patches.
>
Sure.


>>>> +       seq_puts(m, "# <name> <css_id[:dead]> <active_objs> <num_objs>");
>>>> +       seq_puts(m, " <active_slabs> <num_slabs>\n");
>>>> +       list_for_each_entry(s, &slab_root_caches, root_caches_node) {
>>>> +               /*
>>>> +                * Skip kmem caches that don't have any memcg children.
>>>> +                */
>>>> +               if (list_empty(&s->memcg_params.children))
>>>> +                       continue;
>>>> +
>>>> +               memset(&sinfo, 0, sizeof(sinfo));
>>>> +               get_slabinfo(s, &sinfo);
>>>> +               seq_printf(m, "%-17s root      %6lu %6lu %6lu %6lu\n",
>>>> +                          cache_name(s), sinfo.active_objs, sinfo.num_objs,
>>>> +                          sinfo.active_slabs, sinfo.num_slabs);
>>>> +
>>>> +               for_each_memcg_cache(c, s) {
>>>> +                       struct cgroup_subsys_state *css;
>>>> +                       char *dead = "";
>>>> +
>>>> +                       css = &c->memcg_params.memcg->css;
>>>> +                       if (!(css->flags & CSS_ONLINE))
>>>> +                               dead = ":dead";
>>> Please note that Roman's kmem cache reparenting patch series have made
>>> kmem caches of zombie memcgs a bit tricky. On memcg offlining the
>>> memcg kmem caches are reparented and the css->id can get recycled. So,
>>> we want to know that the a kmem cache is reparented and which memcg it
>>> belonged to initially. Determining if a kmem cache is reparented, we
>>> can store a flag on the kmem cache and for the previous memcg we can
>>> use fhandle. However to not make this more complicated, for now, we
>>> can just have the info that the kmem cache was reparented i.e. belongs
>>> to an offlined memcg.
>> I need to play with Roman's kmem cache reparenting patch a bit more to
>> see how to properly recognize a reparent'ed kmem cache. What I have
>> noticed is that the dead kmem caches that I saw at boot up were gone
>> after applying his patch. So that is a good thing.
>>
> By gone, do you mean the kmem cache got freed or the kmem cache is not
> part of online parent memcg and thus no more dead kmem cache?
I just look at the online flag of the memcg's css. All of them are
online when the iteration is being done after Roman's patch. I will
probably need to check if reparenting has happened.
>
>> For now, I think the current patch is good enough for its purpose. I may
>> send follow-up if I see something that can be improved.
>>
> I would like to see the recognition of reparent'ed kmem cache in this
> patch. However if others are ok with the current status of the patch
> then I will not stand in the way.

As I said, I will work on a follow-up patch to recognize reparenting.

Cheers,
Longman

