Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF3B4F34A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2019 04:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbfFVC45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 22:56:57 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:41393 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfFVC45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 22:56:57 -0400
Received: by mail-yw1-f67.google.com with SMTP id y185so3554492ywy.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 19:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/g9EiwqrPvEcGP2ni72jxssRku07PD+BBNFgfPzyheY=;
        b=mYbRmL5/P2mRzNOQSsSEJmGQWFcVIzmw0SVxH6/kO00xVRkQXvbGTzwNqSaOScTjWB
         NHe6cCqxuiNoFoCBP+2+JLyNbzb644qpJWhOw5dt+Ans39QxbhA4zcRsBusIzJ+hAKYY
         TfYxeV4uWgb7WwKWbr7iOeaRr3OL+RLTRvDA5oR5rHx6q+BH5Ydn/3NzL8zIkMA3Xb+Z
         kCyfe+Pt4VRUpawyN+ajT7qbUup5s/4CkWFzXb3Y1GXcvKBKGeqZ85/BNlzgJmwrvAkH
         4MAPxqyyRXjPUaM5bKehs6KgDYPv+ActooRkzqnEFYi+YsCj98tmxl7JeGUZyr2SrHF9
         KICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/g9EiwqrPvEcGP2ni72jxssRku07PD+BBNFgfPzyheY=;
        b=azOlysfLn4f9wy5lqe7fHGnQPfq3yVy++AbnP1e/ImOEOkzIQsJt+QvsXF/JM/p4GQ
         OqOXJuBV4c7uVBeVl2+oS7yVWtj9dguPLt4GnedzPBaySlnSL90vTfq1T5/fBdn9F+nn
         /Mb/03rfln16DNpEK/eJl41K2KCX3QUZKzFaWQwi5vdAgGA4m58OsFaj1QufZ0tvXdnS
         riP4hgnJ9Lbvq2wTV1IYHfCWbC45ttSwb7Zv31OhnFHM28X2b84zyiTHOCCsc5JHR9ZD
         2U3lu9gTf7D5NrKHtJa2u0PchBA8VS+7HhZRLTk4OHQ5HtWMU9HxUk5YTf4r+V/vEc6G
         bNGg==
X-Gm-Message-State: APjAAAXqQ3rxQeg2cIw1IqJldktHavAzno6xHGD3AhJFVX6WaIRLVFss
        YwcF+Ua0/6m8pX1iANPpTzPR8L9DvZ153d0V5FHTlg==
X-Google-Smtp-Source: APXvYqxFuhE0Kf5yAADli3a4wL8we59okF0BtHIRD++QuwlaOJlXqbkRZzRIR+nIVbqVOcPqNt3u2NLWkIRfajq57vw=
X-Received: by 2002:a81:ae0e:: with SMTP id m14mr61725056ywh.308.1561172215649;
 Fri, 21 Jun 2019 19:56:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190621173005.31514-1-longman@redhat.com>
In-Reply-To: <20190621173005.31514-1-longman@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 21 Jun 2019 19:56:44 -0700
Message-ID: <CALvZod51uMXsS+1DpyG+=1nC-6pYNc8C6yOwQUdiRLD0yrp4ZA@mail.gmail.com>
Subject: Re: [PATCH-next] mm, memcg: Add ":deact" tag for reparented kmem
 caches in memcg_slabinfo
To:     Waiman Long <longman@redhat.com>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 10:30 AM Waiman Long <longman@redhat.com> wrote:
>
> With Roman's kmem cache reparent patch, multiple kmem caches of the same
> type can be seen attached to the same memcg id. All of them, except
> maybe one, are reparent'ed kmem caches. It can be useful to tag those
> reparented caches by adding a new slab flag "SLAB_DEACTIVATED" to those
> kmem caches that will be reparent'ed if it cannot be destroyed completely.
>
> For the reparent'ed memcg kmem caches, the tag ":deact" will now be
> shown in <debugfs>/memcg_slabinfo.
>
> Signed-off-by: Waiman Long <longman@redhat.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

> ---
>  include/linux/slab.h |  4 ++++
>  mm/slab.c            |  1 +
>  mm/slab_common.c     | 14 ++++++++------
>  mm/slub.c            |  1 +
>  4 files changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index fecf40b7be69..19ab1380f875 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -116,6 +116,10 @@
>  /* Objects are reclaimable */
>  #define SLAB_RECLAIM_ACCOUNT   ((slab_flags_t __force)0x00020000U)
>  #define SLAB_TEMPORARY         SLAB_RECLAIM_ACCOUNT    /* Objects are short-lived */
> +
> +/* Slab deactivation flag */
> +#define SLAB_DEACTIVATED       ((slab_flags_t __force)0x10000000U)
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
> +       cachep->flags |= SLAB_DEACTIVATED;
>         __kmem_cache_shrink(cachep);
>  }
>
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 146d8eaa639c..85cf0c374303 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1533,7 +1533,7 @@ static int memcg_slabinfo_show(struct seq_file *m, void *unused)
>         struct slabinfo sinfo;
>
>         mutex_lock(&slab_mutex);
> -       seq_puts(m, "# <name> <css_id[:dead]> <active_objs> <num_objs>");
> +       seq_puts(m, "# <name> <css_id[:dead|deact]> <active_objs> <num_objs>");
>         seq_puts(m, " <active_slabs> <num_slabs>\n");
>         list_for_each_entry(s, &slab_root_caches, root_caches_node) {
>                 /*
> @@ -1544,22 +1544,24 @@ static int memcg_slabinfo_show(struct seq_file *m, void *unused)
>
>                 memset(&sinfo, 0, sizeof(sinfo));
>                 get_slabinfo(s, &sinfo);
> -               seq_printf(m, "%-17s root      %6lu %6lu %6lu %6lu\n",
> +               seq_printf(m, "%-17s root       %6lu %6lu %6lu %6lu\n",
>                            cache_name(s), sinfo.active_objs, sinfo.num_objs,
>                            sinfo.active_slabs, sinfo.num_slabs);
>
>                 for_each_memcg_cache(c, s) {
>                         struct cgroup_subsys_state *css;
> -                       char *dead = "";
> +                       char *status = "";
>
>                         css = &c->memcg_params.memcg->css;
>                         if (!(css->flags & CSS_ONLINE))
> -                               dead = ":dead";
> +                               status = ":dead";
> +                       else if (c->flags & SLAB_DEACTIVATED)
> +                               status = ":deact";
>
>                         memset(&sinfo, 0, sizeof(sinfo));
>                         get_slabinfo(c, &sinfo);
> -                       seq_printf(m, "%-17s %4d%5s %6lu %6lu %6lu %6lu\n",
> -                                  cache_name(c), css->id, dead,
> +                       seq_printf(m, "%-17s %4d%-6s %6lu %6lu %6lu %6lu\n",
> +                                  cache_name(c), css->id, status,
>                                    sinfo.active_objs, sinfo.num_objs,
>                                    sinfo.active_slabs, sinfo.num_slabs);
>                 }
> diff --git a/mm/slub.c b/mm/slub.c
> index a384228ff6d3..c965b4413658 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4057,6 +4057,7 @@ void __kmemcg_cache_deactivate(struct kmem_cache *s)
>          */
>         slub_set_cpu_partial(s, 0);
>         s->min_partial = 0;
> +       s->flags |= SLAB_DEACTIVATED;
>  }
>  #endif /* CONFIG_MEMCG */
>
> --
> 2.18.1
>
