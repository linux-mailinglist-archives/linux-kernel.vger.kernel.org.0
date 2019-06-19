Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC62E4BCE8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 17:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbfFSPgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 11:36:04 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:37822 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfFSPgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 11:36:00 -0400
Received: by mail-yw1-f65.google.com with SMTP id 186so8466025ywo.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 08:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dwSXE2HJvCidsxfi3LfOlPWV76WiyrJo+zGle1/Posk=;
        b=shPcVD/RnA32q5R954zhbHbCNmUv9WV3y1RqIyqvsdpscKxDrx898pdEDLhp5LN0to
         DbXYXu+gvach7KLfWm2FSbsVhYhvyvmXGjhENsRkiMKSnzsr2EcXvlHfynmEaSSmHkie
         5Yts8FyiwXSFtBQH6RFnmuWPot9WB3/pECxotkeyoOEWY/zSS12ndpAUC0/eRSSv0R9U
         yZ3R5iGCjfEkm/U8Cqn+k5IXrPvpygVj1VJXilucmRW00bBqpvtpm69ynGQS7hLw53mK
         vTA414ToCI8UTtvUA421mNTNbwrVbYtIQ7ja94Ya4nfK98Lsk+qkHykltGKqlw+41fs5
         JPBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dwSXE2HJvCidsxfi3LfOlPWV76WiyrJo+zGle1/Posk=;
        b=d+38NmZneiBChFmJAfUjRafTlqdkDXjhQmKRXX84smHPSZWPxn/cAhvRZ9ifjgyxyC
         dBCfR/sv/2dUYu0QDU6oqOdVkMQhAPLdTthqcuNS3BzPvHIBhoFDiAJRzlHAn/OzSL1x
         Lzq+lJ6VwJbCW7G/mf8xPz9cdt0nzv57x5LXu4hetl6XnlEWeinZOvwuzSGP9qipxtnP
         RdMfh8Y3W8/ppEQP+d7CS+gk9LGuGlKt+10tEnIESLDppQuE/oCwlFiooL6sXIZa0TAv
         uICLg5cOwHekjfP0wMe3s9qKsd6BPmkBLrPY88K732TXZc2rHykId7VK6gsiJ554zA0c
         tHYA==
X-Gm-Message-State: APjAAAUoGbR14rPeZxQC0PjldJJRDJtM451yqmZzdZ+Pswi4FdwGCF2P
        tq0Qa3zUY05cOh4cJPpvL15mZCK4dJdW4R2zoLw9iw==
X-Google-Smtp-Source: APXvYqxkP5tURjFEv1pLRgOMle49c6W6qB/eYRu2b+HirEU7vb0z2HAUJr63bUo2XJQhzwumW474OnOIqm7cAPB2g2Y=
X-Received: by 2002:a81:3a0f:: with SMTP id h15mr70130882ywa.34.1560958558977;
 Wed, 19 Jun 2019 08:35:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190619144610.12520-1-longman@redhat.com> <CALvZod5yHbtYe2x3TGQKGtxjvTDpAGjvSc8Pvphbn00pdRfs2g@mail.gmail.com>
 <20831975-590f-ecab-53db-5d7e6b1a053f@redhat.com>
In-Reply-To: <20831975-590f-ecab-53db-5d7e6b1a053f@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 19 Jun 2019 08:35:47 -0700
Message-ID: <CALvZod6T31z2P+wdUz3LVYO3dTSbOc89cKDn=8LKpN+ZovL8jw@mail.gmail.com>
Subject: Re: [PATCH] mm, memcg: Add a memcg_slabinfo debugfs file
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

On Wed, Jun 19, 2019 at 8:30 AM Waiman Long <longman@redhat.com> wrote:
>
> On 6/19/19 11:18 AM, Shakeel Butt wrote:
> > On Wed, Jun 19, 2019 at 7:46 AM Waiman Long <longman@redhat.com> wrote:
> >> There are concerns about memory leaks from extensive use of memory
> >> cgroups as each memory cgroup creates its own set of kmem caches. There
> >> is a possiblity that the memcg kmem caches may remain even after the
> >> memory cgroup removal. Therefore, it will be useful to show how many
> >> memcg caches are present for each of the kmem caches.
> >>
> >> This patch introduces a new <debugfs>/memcg_slabinfo file which is
> >> somewhat similar to /proc/slabinfo in format, but lists only slabs that
> >> are in memcg kmem caches. Information available in /proc/slabinfo are
> >> not repeated in memcg_slabinfo.
> >>
> > At Google, we have an interface /proc/slabinfo_full which shows each
> > kmem cache (root and memcg) on a separate line i.e. no accumulation.
> > This interface has helped us a lot for debugging zombies and memory
> > leaks. The name of the memcg kmem caches include the memcg name, css
> > id and "dead" for offlined memcgs. I think these extra information is
> > much more useful for debugging. What do you think?
> >
> > Shakeel
>
> Yes, I think that can be a good idea. My only concern is that it can be
> very verbose. Will work on a v2 patch.
>

Yes, it is very verbose but it is only for debugging and normal users
should not be (continuously) reading that interface.

Shakeel
