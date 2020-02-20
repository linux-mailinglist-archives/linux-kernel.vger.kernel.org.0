Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BABE9166600
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 19:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbgBTSO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 13:14:57 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44060 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbgBTSO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 13:14:57 -0500
Received: by mail-ot1-f67.google.com with SMTP id h9so4532076otj.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 10:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uUKdgkaufxLmLYOt3TduZTiePIKaOkl8sejxXEeQJug=;
        b=uEXDpSnvxNGx/1g8in8h2Lps6UF2cwI0Ci30lm3NqVXZaApTkzuDK+720dgSH9vb6k
         KPzL7duyHh9m0BqEDV45tazOognY/d0scMRdl2OcG1JPE/lSbuZQK0NgSRFEE6JZ1ocE
         bqLEMcVwBuFDRo16e9ImN9DFgGBbY4Rh3WKWen7Cz5Tan7f1NIIGTAN0UdCsrXlhKb2x
         xp82sXN5MddaQ9Fo3jlxRRZOvEG5C3dmzkLPX1is1Moe0S017U8Ajd4vA0J68kr+ivdJ
         DDHGyxImOHKFItW4eCZUYeAX2LdHOyh93fukcpNbkzLACAa56EL81Jnugc/MS1xxyks7
         aVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uUKdgkaufxLmLYOt3TduZTiePIKaOkl8sejxXEeQJug=;
        b=mDgo7bipT/BBc4dgsJkozwq7yOX91Ad9baDNnnsNff0JakXwnTr3ongtKh8QmBt+z+
         r89NxHCNR31/E4bwNFysNW30wVSf2nPHQ9vjOiv7ZRzTPyVIsMhUnD74Qu661ZXN3di8
         cRROye21B3vEVLHjPcqSaolKaDg1D6Fh3K6S02bFDtZmkrXR7udJCm+Il3LqR6GWRHLd
         N8IfFlpn05HnzGz1TphgTMnP+OXRgCGuiPuEQ1LL3ucTgnok6bH53zJAEyWoupYCum6n
         PGiTA1XdTNBHdrD3+ncNA1TloUOcr6e0XyOdX8kh43bJVLnuHBTkgsBbRU9+lalyomEn
         QuTw==
X-Gm-Message-State: APjAAAXJjiJfERmF0UD13I0gyiH6esMwxO202nG3oeQ6+luKa8AuTvhj
        ox1NAyFQ6gV3cOINH7ma1ja9rBayzRzryb8C2A36rw==
X-Google-Smtp-Source: APXvYqwEhtHawQMBwvmDc5WZ+GbpmKPP7mgN5ZpRyswR3p1ZNH4wKythp6ijBG51PHDBpY+92/+km74sS2lSGrcqxRE=
X-Received: by 2002:a05:6830:11:: with SMTP id c17mr24335278otp.360.1582222496058;
 Thu, 20 Feb 2020 10:14:56 -0800 (PST)
MIME-Version: 1.0
References: <cover.1582216294.git.schatzberg.dan@gmail.com> <0a27b6fcbd1f7af104d7f4cf0adc6a31e0e7dd19.1582216294.git.schatzberg.dan@gmail.com>
In-Reply-To: <0a27b6fcbd1f7af104d7f4cf0adc6a31e0e7dd19.1582216294.git.schatzberg.dan@gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 20 Feb 2020 10:14:45 -0800
Message-ID: <CALvZod5bDQvYHTMCHoWbhiEbcBs4KATv=QLdjjivJ33kb6ZY+w@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] mm: Charge active memcg when no mm is set
To:     Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 8:52 AM Dan Schatzberg <schatzberg.dan@gmail.com> wrote:
>
> memalloc_use_memcg() worked for kernel allocations but was silently
> ignored for user pages.
>
> This patch establishes a precedence order for who gets charged:
>
> 1. If there is a memcg associated with the page already, that memcg is
>    charged. This happens during swapin.
>
> 2. If an explicit mm is passed, mm->memcg is charged. This happens
>    during page faults, which can be triggered in remote VMs (eg gup).
>
> 3. Otherwise consult the current process context. If it has configured
>    a current->active_memcg, use that.

What if css_tryget_online(current->active_memcg) in
get_mem_cgroup_from_current() fails? Do we want to change this to
css_tryget() and even if that fails should we fallback to
root_mem_cgroup or current->mm->memcg?

> Otherwise, current->mm->memcg.
>
> Previously, if a NULL mm was passed to mem_cgroup_try_charge (case 3) it
> would always charge the root cgroup. Now it looks up the current
> active_memcg first (falling back to charging the root cgroup if not
> set).
>
> Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Tejun Heo <tj@kernel.org>
> ---
>  mm/memcontrol.c | 11 ++++++++---
>  mm/shmem.c      |  2 +-
>  2 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 6f6dc8712e39..b174aff4f069 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6317,7 +6317,8 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
>   * @compound: charge the page as compound or small page
>   *
>   * Try to charge @page to the memcg that @mm belongs to, reclaiming
> - * pages according to @gfp_mask if necessary.
> + * pages according to @gfp_mask if necessary. If @mm is NULL, try to
> + * charge to the active memcg.
>   *
>   * Returns 0 on success, with *@memcgp pointing to the charged memcg.
>   * Otherwise, an error code is returned.
> @@ -6361,8 +6362,12 @@ int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
>                 }
>         }
>
> -       if (!memcg)
> -               memcg = get_mem_cgroup_from_mm(mm);
> +       if (!memcg) {
> +               if (!mm)
> +                       memcg = get_mem_cgroup_from_current();
> +               else
> +                       memcg = get_mem_cgroup_from_mm(mm);
> +       }
>
>         ret = try_charge(memcg, gfp_mask, nr_pages);
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index c8f7540ef048..7c7f5acf89d6 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1766,7 +1766,7 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
>         }
>
>         sbinfo = SHMEM_SB(inode->i_sb);
> -       charge_mm = vma ? vma->vm_mm : current->mm;
> +       charge_mm = vma ? vma->vm_mm : NULL;
>
>         page = find_lock_entry(mapping, index);
>         if (xa_is_value(page)) {
> --
> 2.17.1
>
