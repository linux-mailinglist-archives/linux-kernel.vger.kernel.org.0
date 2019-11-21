Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E40A105BFB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 22:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfKUVbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 16:31:06 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38649 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKUVbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 16:31:06 -0500
Received: by mail-oi1-f195.google.com with SMTP id a14so4613767oid.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 13:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Ih+wdf+T8QIhxXa0Z/BjR6OEVlveBg+npb+LGLRLAs=;
        b=KQXl3u2SVxyMz8rlN77m7iXC4ogPKT54d6c96jwtR1V+9QP6TEJSfb7qFvrb+c8sYn
         K1HETXSPjLCE+ngl2e3oauOhqVrEPFPM/ZhnnrzVqESA+rClKn4LlMg7AyKV4Td5W2Ef
         xZ/qSXNCfrpe4jEh11iqbzoHAebuFk6JndluiFnmlqwAn8qHcNvAmBcFo4YjRec62s+I
         GRFgKzmVkO22wLfhbM8JasOVjj3eAkjRhG06EPVSfLHi7Oxy1zwpIe9LLOjMTDraMIfi
         5/lkMveIVEwgKvw90PoSaktKGc7LanP0P3AO+m//ciW9Hi25i5albVbdjQTMnkwoR8HF
         Truw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Ih+wdf+T8QIhxXa0Z/BjR6OEVlveBg+npb+LGLRLAs=;
        b=mVi7tenEhJo13CnKgSW4nOxeU2hHzyk66eClWi4bGoWhUgtJ3gkHrMg6OvocLLULnk
         z7Wq6aevP6gtH7jGtOC8HhKlFP09K6KFv3m48gWK/e4HNpRXa+JjMx0rtltW3vMNCRDY
         xQHNMsEp/fX0jwIREVJ3XPm4WROBs2KyzriBLYFOfk/LdD9Mp4cMRis8iXqjuxH38MiJ
         LHKUZsS+WKHT+AY9g25xif4rlgQnx3JkOGaYbSCdv4hJkk5PdKJ72cyByqWUrd1epbmC
         jzRmg9a/dFH1RK+pbx0yOsIHtaOYRHFs7tMebDQy/sDqAET3v2qRxPUfzOFc78lIfJj4
         TPbg==
X-Gm-Message-State: APjAAAXHoYj/XU5UKHoVhUTlFdZ7QG1MgGgcezpLhwbFkAXy91sftPH0
        Dj4bO8HCIc6065KTlIoNhtfdWXY7uFIQVVlJSMP0tg==
X-Google-Smtp-Source: APXvYqyyYZQan3opx0rXCprghR1vY7gbbQA4CJmeQnXT2oWPmvhKt0mBKHrMonq2HYj1qOct6NiLQYx4svVuB+BfkVI=
X-Received: by 2002:aca:7516:: with SMTP id q22mr9124234oic.144.1574371864860;
 Thu, 21 Nov 2019 13:31:04 -0800 (PST)
MIME-Version: 1.0
References: <20191120165847.423540-1-hannes@cmpxchg.org> <alpine.LSU.2.11.1911201836220.1090@eggly.anvils>
 <20191121205631.GA487872@cmpxchg.org>
In-Reply-To: <20191121205631.GA487872@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 21 Nov 2019 13:30:52 -0800
Message-ID: <CALvZod7FG+fTFE89j8E6-1RBG6st1Y9sSju-ModT9Rj6SzrVLw@mail.gmail.com>
Subject: Re: [PATCH] mm: fix unsafe page -> lruvec lookups with cgroup charge migration
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 12:56 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Wed, Nov 20, 2019 at 07:15:27PM -0800, Hugh Dickins wrote:
> > It like the way you've rearranged isolate_lru_page() there, but I
> > don't think it amounts to more than a cleanup.  Very good thinking
> > about the odd "lruvec->pgdat = pgdat" case tucked away inside
> > mem_cgroup_page_lruvec(), but actually, what harm does it do, if
> > mem_cgroup_move_account() changes page->mem_cgroup concurrently?
> >
> > You say use-after-free, but we have spin_lock_irq here, and the
> > struct mem_cgroup (and its lruvecs) cannot be freed until an RCU
> > grace period expires, which we rely upon in many places, and which
> > cannot happen until after the spin_unlock_irq.
>
> You are correct, I missed the rcu locking implied by the
> spinlock. With this, the justification for this patch is wrong.
>
> But all of this is way too fragile and error-prone for my taste. We're
> looking up a page's lruvec in a scope that does not promise at all
> that the lruvec will be the page's. Luckily we currently don't touch
> the lruvec outside of the PageLRU branch, but this subtlety is
> entirely non-obvious from the code.
>
> I will put more thought into this. Let's scrap this patch for now.

What about the comment on mem_cgroup_page_lruvec()? I feel that
comment is a good documentation independent of the original patch.
