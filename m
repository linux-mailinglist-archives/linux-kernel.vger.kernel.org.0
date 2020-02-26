Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4EE170983
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 21:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbgBZUZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 15:25:48 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37240 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbgBZUZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 15:25:47 -0500
Received: by mail-ot1-f65.google.com with SMTP id b3so726320otp.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 12:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KwWaD9UNYEDZjJ4EPfYXtQOHPHFo1HH/Frc1ArcblIg=;
        b=YuXdKjW0oghU8BUd9VZISKdnbYPb7Iij9fXMHDfJe6Jc2da/+3gxW0hpZVtNmG9HsD
         EgJ+RO+EF51ANqkErW6DkmniTVm1OuwWvXCS/DeUCFFoC7Vg6l0+rsecJFI2MCsws2YZ
         j4Ug5p4cr2T4EyGr7MQJ58Uc1nWUvJ0ZHX6WNhJ/sYLo7ClXiBwKQFJKsYPpYPRZi/LX
         pcEkyCMRg5juMyH3rQD2+4+jjLvkP2F0mKSQ2RVAxPF4/BaYnCqS+LfpnBHSfSbsCrW2
         ZSHA29PXfqFjNpsuNhDYO25EiDZCs+AABYp7G36xqJMvHoBYN0RH5TR4yiHd6KoaXuk8
         dJKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KwWaD9UNYEDZjJ4EPfYXtQOHPHFo1HH/Frc1ArcblIg=;
        b=UVIV3NgRcUmpxGprkEaB/cfWHWNZn1n42TFWY70f/naoQ9NcCimOL9WAKscs1e9GxZ
         JsjsfByozDTew0Ma/2SQo+sFeUGPRG9ksK2Y5NiFjfmM1SXk15pWIfkT/7U0gMRNcrX9
         hsfZjkr6x99Kr1ji7IJsoA1r/LNOcUI/67ecFj/czU5AhRo1jv/5BRkw0TTNsOLW96Dz
         BzhiBfwbkc768E3QEHTJP3p+gHQY1mRB4jEhQrzZmV7KnM4v7W7vBO/U06OL5bSx0o00
         YThbzQZVN3n9kaEGE/XPMzpe46zrn87ciEL9pOFWSoRK+YveNg5AjDon8ievMDxls3Gr
         HsOg==
X-Gm-Message-State: APjAAAVBdCHpnko+X6UJuhWPg89JhS5+dFcaIyEsHwXKY2kYW2nhdY1q
        cgLusZixIhyy3Qa6Kn7Lwtb8oHbPYvcj6Lv78j+4ZQ==
X-Google-Smtp-Source: APXvYqzHU2SxaDMnNTVfBJNIjx/bUh8/7WP9i2EqHRNqU74ZzhmkAOB+zj/HsL3Z5tGRsMjcKCesJovREGO3/obZoLM=
X-Received: by 2002:a05:6830:1e2b:: with SMTP id t11mr449644otr.81.1582748745385;
 Wed, 26 Feb 2020 12:25:45 -0800 (PST)
MIME-Version: 1.0
References: <20200219181219.54356-1-hannes@cmpxchg.org>
In-Reply-To: <20200219181219.54356-1-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 26 Feb 2020 12:25:33 -0800
Message-ID: <CALvZod7fya+o8mO+qo=FXjk3WgNje=2P=sxM5StgdBoGNeXRMg@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: asynchronous reclaim for memory.high
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 10:12 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> We have received regression reports from users whose workloads moved
> into containers and subsequently encountered new latencies. For some
> users these were a nuisance, but for some it meant missing their SLA
> response times. We tracked those delays down to cgroup limits, which
> inject direct reclaim stalls into the workload where previously all
> reclaim was handled my kswapd.
>
> This patch adds asynchronous reclaim to the memory.high cgroup limit
> while keeping direct reclaim as a fallback. In our testing, this
> eliminated all direct reclaim from the affected workload.
>
> memory.high has a grace buffer of about 4% between when it becomes
> exceeded and when allocating threads get throttled. We can use the
> same buffer for the async reclaimer to operate in. If the worker
> cannot keep up and the grace buffer is exceeded, allocating threads
> will fall back to direct reclaim before getting throttled.
>
> For irq-context, there's already async memory.high enforcement. Re-use
> that work item for all allocating contexts, but switch it to the
> unbound workqueue so reclaim work doesn't compete with the workload.
> The work item is per cgroup, which means the workqueue infrastructure
> will create at maximum one worker thread per reclaiming cgroup.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/memcontrol.c | 60 +++++++++++++++++++++++++++++++++++++------------
>  mm/vmscan.c     | 10 +++++++--

This reminds me of the per-memcg kswapd proposal from LSFMM 2018
(https://lwn.net/Articles/753162/).

If I understand this correctly, the use-case is that the job instead
of direct reclaiming (potentially in latency sensitive tasks), prefers
a background non-latency sensitive task to do the reclaim. I am
wondering if we can use the memory.high notification along with a new
memcg interface (like memory.try_to_free_pages) to implement a user
space background reclaimer. That would resolve the cpu accounting
concerns as the user space background reclaimer can share the cpu cost
with the task.

One concern with this approach will be that the memory.high
notification is too late and the latency sensitive task has faced the
stall. We can either introduce a threshold notification or another
notification only limit like memory.near_high which can be set based
on the job's rate of allocations and when the usage hits this limit
just notify the user space.

Shakeel
