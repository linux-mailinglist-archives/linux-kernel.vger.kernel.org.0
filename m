Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0A468FAD4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 08:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfHPGVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 02:21:09 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40055 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfHPGVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 02:21:09 -0400
Received: by mail-oi1-f196.google.com with SMTP id h21so4055827oie.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 23:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bnzSBHY/JdeQAgbtdAEAW270/fKb4r8flWE61wbC5Lo=;
        b=UVlNUshcEIlU+yobZlz2y42/ujMlRlo+ct+0p80oBP1RIOLjVgza5yLAH9kiWJ0ywH
         rn5w4IcTB48oHSkKlTlUwiOfhTg79xGXAcMQPEun+qGn+KaPE/v6hTzroIHT9rozR67E
         6n0mNYDqP9fJbFBUtd9FG2uXYDGCCqC+daSJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bnzSBHY/JdeQAgbtdAEAW270/fKb4r8flWE61wbC5Lo=;
        b=L+zTHLkbVkjuCwfX9rHcYPSYCq5EgtP16jNgi01oDcAq/Z0XMWiZhAd/1aITNZW8uR
         geJdaOE+ZVUIubAYlO6euITjT+xrHos183nL2MwBJTOcW+9DkqBIJ4AszIpvEM99hU/C
         XNQIJpZoa9zIVJyeZ6Y14DOqm8fXG4SY6yTSi4eI6TjhXLjc+6c3dq/1hnSq7IUNlaUI
         fUvJKLTgZKbtjJ6gmlaWaLq29y4+b6GLSXYutzuHeizCe+vj7qkxwSMuvdE1Y4CVEFan
         Ofi1uRyVW/aF27NywxBCs1PFttM+GVEFLWrsDRZ9LJoCzaVdlsPMBFxelITy7vASDxip
         hUDQ==
X-Gm-Message-State: APjAAAWJMsrRgbpQghdE8YiNIh+QcIxFWlyliXRKeAj8YFGbgsaZO6nu
        BLJ5dSEFVa2jyo66vLklDgMUUHGWC/1s2Fyl9wox5Q==
X-Google-Smtp-Source: APXvYqzph7HTCPvGlJkLaGSjiEYiCfosASP1QBmSLU+nI/ANvScaJ5s0IeM0Q21xXCjaiRcxA2KwuJ63i1nnQocpq20=
X-Received: by 2002:aca:1a0b:: with SMTP id a11mr4149187oia.128.1565936467928;
 Thu, 15 Aug 2019 23:21:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190815155950.GN9477@dhcp22.suse.cz> <20190815165631.GK21596@ziepe.ca>
 <20190815174207.GR9477@dhcp22.suse.cz> <20190815182448.GP21596@ziepe.ca>
 <20190815190525.GS9477@dhcp22.suse.cz> <20190815191810.GR21596@ziepe.ca>
 <20190815193526.GT9477@dhcp22.suse.cz> <CAKMK7uH42EgdxL18yce-7yay=x=Gb21nBs3nY7RA92Nsd-HCNA@mail.gmail.com>
 <20190815202721.GV21596@ziepe.ca> <CAKMK7uER0u1TqeJBXarKakphnyZTHOmedOfXXqLGVDE2mE-mAQ@mail.gmail.com>
 <20190816010036.GA9915@ziepe.ca>
In-Reply-To: <20190816010036.GA9915@ziepe.ca>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 16 Aug 2019 08:20:55 +0200
Message-ID: <CAKMK7uH0oa10LoCiEbj1NqAfWitbdOa-jQm9hM=iNL-=8gH9nw@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH 2/5] kernel.h: Add non_block_start/end()
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Michal Hocko <mhocko@kernel.org>, Feng Tang <feng.tang@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Jann Horn <jannh@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux MM <linux-mm@kvack.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Rientjes <rientjes@google.com>,
        Wei Wang <wvw@google.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 3:00 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> On Thu, Aug 15, 2019 at 10:49:31PM +0200, Daniel Vetter wrote:
> > On Thu, Aug 15, 2019 at 10:27 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > On Thu, Aug 15, 2019 at 10:16:43PM +0200, Daniel Vetter wrote:
> > > > So if someone can explain to me how that works with lockdep I can of
> > > > course implement it. But afaics that doesn't exist (I tried to explain
> > > > that somewhere else already), and I'm no really looking forward to
> > > > hacking also on lockdep for this little series.
> > >
> > > Hmm, kind of looks like it is done by calling preempt_disable()
> >
> > Yup. That was v1, then came the suggestion that disabling preemption
> > is maybe not the best thing (the oom reaper could still run for a long
> > time comparatively, if it's cleaning out gigabytes of process memory
> > or what not, hence this dedicated debug infrastructure).
>
> Oh, I'm coming in late, sorry
>
> Anyhow, I was thinking since we agreed this can trigger on some
> CONFIG_DEBUG flag, something like
>
>     /* This is a sleepable region, but use preempt_disable to get debugging
>      * for calls that are not allowed to block for OOM [.. insert
>      * Michal's explanation.. ] */
>     if (IS_ENABLED(CONFIG_DEBUG_ATOMIC_SLEEP) && !mmu_notifier_range_blockable(range))
>         preempt_disable();
>     ops->invalidate_range_start();

I think we also discussed that, and some expressed concerns it would
change behaviour/timing too much for testing. Since this does does
disable preemption for real, not just for might_sleep.

> And I have also been idly mulling doing something like
>
>    if (IS_ENABLED(CONFIG_DEBUG_NOTIFIERS) &&
>        rand &&
>        mmu_notifier_range_blockable(range)) {
>      range->flags = 0
>      if (!ops->invalidate_range_start(range))
>         continue
>
>      // Failed, try again as blockable
>      range->flags = MMU_NOTIFIER_RANGE_BLOCKABLE
>    }
>    ops->invalidate_range_start(range);
>
> Which would give coverage for this corner case without forcing OOM.

Hm, this sounds like a neat idea to slap on top. The rand is going to
be a bit tricky though, but I guess for this we could stuff another
counter into task_struct and just e.g. do this every 1000th or so
invalidate (well need to pick a prime so we cycle through notifiers in
case there's multiple). I like.

Michal, thoughts?
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
