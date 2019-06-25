Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67831556E9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 20:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732859AbfFYSRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 14:17:53 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:40674 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbfFYSRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 14:17:53 -0400
Received: by mail-yw1-f65.google.com with SMTP id b143so7929570ywb.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 11:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gd8q8neCT5NqLNWSpySLJWRTGAUdIgC+KA84NV729mY=;
        b=klsFVayIWMeB3zp53s+cnxO5MakpqSwu+FbhTn0qaAt2J28Cz+esm64Q93IABrDnNu
         sokI3N0pH2PmqCl1w3A0IP6HdmtNX4ywdBo18UR7Bo7cz8V3au0JpCDMUaxgMc6yeDLB
         vlMgFhlHZiTn9UKmTWnSprBOAjqkbl9m/u0RmyKP55ZYdyymlOtfmsLHcZ29tGPNYZ6F
         WiRfnNZ/XuN2mPbITcOveBBSo86VQVWHdiOQAgbxAMTBDKlO0ZD+yqRhrnt1vY3Sf5Zx
         SYEguYD+3ir/4pUe5Sa+mK+rD0QkKiAnZfXR1A3PB4aRhNEg4NvFaXQc+ENV7rnH8KfZ
         WYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gd8q8neCT5NqLNWSpySLJWRTGAUdIgC+KA84NV729mY=;
        b=qfZIb4hRixyvhLuoNv1IvIXOxnw38VGGFpf8JxBPFq9NvN6P7fZPIb+UVHUOzFzSC4
         rirdzJ8DNTzt5bZth6rVcq5LH5wN9oJr9w5MnyaqpoEKu/LlICcna84hkHIDx2z+Dw84
         +UBu18XjnOrRSby9mFDsTpa/Sa+zsEhXZTx5tXWkip9k/oVIRdrb632I58LhmHuozLBo
         GhqyZjz0TLV1TPgZiNExgoLL8KvHoAaYmD0STdZ7m2492/7iAC5IiKAZs6lqZoUaN8/N
         JV24CCupKLp6DLz+s8Sj/ufYj7HNZ05TF8ZWALtdm2uH9wAINkk5X/sxbmNPrH6mfQCv
         RgdA==
X-Gm-Message-State: APjAAAV3U8fjsKFNaMcPrPF5fe3PjONmQb+jNapi6aRsV48W0bonG3N6
        QkCHCPSLeBacBuQlHNbUHpw6SfMG2gTdTsDPBk6xcA==
X-Google-Smtp-Source: APXvYqyVMnkA1t4NbNAV4JVhrMm4t4SwyJ72YWdgbiRiIkMwuLjLpgN9kbkazuSPnykjjIk2gg0tKuSHrLqTodgR7E8=
X-Received: by 2002:a81:3a0f:: with SMTP id h15mr66887ywa.34.1561486672366;
 Tue, 25 Jun 2019 11:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190611231813.3148843-1-guro@fb.com> <20190611231813.3148843-4-guro@fb.com>
In-Reply-To: <20190611231813.3148843-4-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 25 Jun 2019 11:17:41 -0700
Message-ID: <CALvZod44+GuDxXSqWOZB3uhvdxJeH+vnXevx+=iy-azv74ueqA@mail.gmail.com>
Subject: Re: [PATCH v7 03/10] mm: generalize postponed non-root kmem_cache deactivation
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Waiman Long <longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 4:18 PM Roman Gushchin <guro@fb.com> wrote:
>
> Currently SLUB uses a work scheduled after an RCU grace period
> to deactivate a non-root kmem_cache. This mechanism can be reused
> for kmem_caches release, but requires generalization for SLAB
> case.
>
> Introduce kmemcg_cache_deactivate() function, which calls
> allocator-specific __kmem_cache_deactivate() and schedules
> execution of __kmem_cache_deactivate_after_rcu() with all
> necessary locks in a worker context after an rcu grace period.
>
> Here is the new calling scheme:
>   kmemcg_cache_deactivate()
>     __kmemcg_cache_deactivate()                  SLAB/SLUB-specific
>     kmemcg_rcufn()                               rcu
>       kmemcg_workfn()                            work
>         __kmemcg_cache_deactivate_after_rcu()    SLAB/SLUB-specific
>
> instead of:
>   __kmemcg_cache_deactivate()                    SLAB/SLUB-specific
>     slab_deactivate_memcg_cache_rcu_sched()      SLUB-only
>       kmemcg_rcufn()                             rcu
>         kmemcg_workfn()                          work
>           kmemcg_cache_deact_after_rcu()         SLUB-only
>
> For consistency, all allocator-specific functions start with "__".
>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
