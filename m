Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72C7E2476E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 07:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbfEUFO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 01:14:59 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36586 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfEUFO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 01:14:58 -0400
Received: by mail-pl1-f193.google.com with SMTP id d21so7838626plr.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 22:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=awsERbP686n2vbtni9N26u6HQquz9Ce47TX91GWA22Y=;
        b=uMqFKvp4Ww8W8I+eKDvVyb/KNxp84a6Q/Pf3cBUUFp5paFjDEMSdxKkq/ue59FWxdH
         zUy/xLz9sirj7qUGaraAtzd1GL8E3xh6y+T983/HZrykvbbMvAqG8B+78WCHorI5tYPi
         bXyYhDJL0f3co7AT6j0OpIxWM7o6flYqD6dM9fbRoAFOmy+MKlSD/OVA/53ofqup15Mr
         b2t3+XMVC1884q3GXFwkqSZDMpJm29MT5jun6zOXGIEgAGfKMEIL8j4/oBf+ODtJXhi7
         ETiMYEBJehil+nwHrUTqIwZklhmEm9t2i18L76VRk7t7hIl8gQJh6xL0c4U86BQ/LjN1
         3eFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=awsERbP686n2vbtni9N26u6HQquz9Ce47TX91GWA22Y=;
        b=YHxzOrPE/xbDuLlUWQtdHn5La54Gj14lV3+FoqOfvH4a/8Q46/Bx8lsUaDopXCSbHp
         fC6yNAWtYMuxzZ4Wq6gEsoOMPzzApBfIJQIHxIr7JGQeKYkvCxeGImUnfr0e3z2KbakO
         /VVk4SQJ1H/hpShySLlIIgxr36yfxJOmlXgnOk/TFMNv1vWwIDMD4TXEv5/1f+Qpyuwg
         ITBSMkXc2EX98xWLoBhEgAqa4rcWFtrkuFDNI/ks2bfTMd0gCOpxKjJHuPsKwNWjGZ/a
         D99hMB/aKpulWZQgrvyeDwrzvm71qQTfwX+Z3aZaWdYQppYSZCrc8qKXM/yGR9pF7W7q
         5e/g==
X-Gm-Message-State: APjAAAUYXlKn/+4//uvjbHB8co6YJu0zDZN3gcUwOZyKGP3a27lDmK8Y
        +MD9PS/p0VPmH8VAwD3c3VA=
X-Google-Smtp-Source: APXvYqx6+uKIuM7hb/YRgMZxEe9VZOovKMMqIVawqI3F86WSoRcl86Wm7jNxLg/rw5XBlMEozv/vfg==
X-Received: by 2002:a17:902:e08b:: with SMTP id cb11mr21806155plb.122.1558415698048;
        Mon, 20 May 2019 22:14:58 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id u3sm21694200pfn.29.2019.05.20.22.14.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 20 May 2019 22:14:56 -0700 (PDT)
Date:   Tue, 21 May 2019 14:14:51 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Tim Murray <timmurray@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>
Subject: Re: [RFC 0/7] introduce memory hinting API for external process
Message-ID: <20190521051451.GL10039@google.com>
References: <20190520035254.57579-1-minchan@kernel.org>
 <dbe801f0-4bbe-5f6e-9053-4b7deb38e235@arm.com>
 <CAEe=Sxka3Q3vX+7aWUJGKicM+a9Px0rrusyL+5bB1w4ywF6N4Q@mail.gmail.com>
 <1754d0ef-6756-d88b-f728-17b1fe5d5b07@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1754d0ef-6756-d88b-f728-17b1fe5d5b07@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 08:25:55AM +0530, Anshuman Khandual wrote:
> 
> 
> On 05/20/2019 10:29 PM, Tim Murray wrote:
> > On Sun, May 19, 2019 at 11:37 PM Anshuman Khandual
> > <anshuman.khandual@arm.com> wrote:
> >>
> >> Or Is the objective here is reduce the number of processes which get killed by
> >> lmkd by triggering swapping for the unused memory (user hinted) sooner so that
> >> they dont get picked by lmkd. Under utilization for zram hardware is a concern
> >> here as well ?
> > 
> > The objective is to avoid some instances of memory pressure by
> > proactively swapping pages that userspace knows to be cold before
> > those pages reach the end of the LRUs, which in turn can prevent some
> > apps from being killed by lmk/lmkd. As soon as Android userspace knows
> > that an application is not being used and is only resident to improve
> > performance if the user returns to that app, we can kick off
> > process_madvise on that process's pages (or some portion of those
> > pages) in a power-efficient way to reduce memory pressure long before
> > the system hits the free page watermark. This allows the system more
> > time to put pages into zram versus waiting for the watermark to
> > trigger kswapd, which decreases the likelihood that later memory
> > allocations will cause enough pressure to trigger a kill of one of
> > these apps.
> 
> So this opens up bit of LRU management to user space hints. Also because the app
> in itself wont know about the memory situation of the entire system, new system
> call needs to be called from an external process.

That's why process_madvise is introduced here.

> 
> > 
> >> Swapping out memory into zram wont increase the latency for a hot start ? Or
> >> is it because as it will prevent a fresh cold start which anyway will be slower
> >> than a slow hot start. Just being curious.
> > 
> > First, not all swapped pages will be reloaded immediately once an app
> > is resumed. We've found that an app's working set post-process_madvise
> > is significantly smaller than what an app allocates when it first
> > launches (see the delta between pswpin and pswpout in Minchan's
> > results). Presumably because of this, faulting to fetch from zram does
> 
> pswpin      417613    1392647     975034     233.00
> pswpout    1274224    2661731    1387507     108.00
> 
> IIUC the swap-in ratio is way higher in comparison to that of swap out. Is that
> always the case ? Or it tend to swap out from an active area of the working set
> which faulted back again.

I think it's because apps are alive longer via reducing being killed
so turn into from pgpgin to swapin.

> 
> > not seem to introduce a noticeable hot start penalty, not does it
> > cause an increase in performance problems later in the app's
> > lifecycle. I've measured with and without process_madvise, and the
> > differences are within our noise bounds. Second, because we're not
> 
> That is assuming that post process_madvise() working set for the application is
> always smaller. There is another challenge. The external process should ideally
> have the knowledge of active areas of the working set for an application in
> question for it to invoke process_madvise() correctly to prevent such scenarios.

There are several ways to detect workingset more accurately at the cost
of runtime. For example, with idle page tracking or clear_refs. Accuracy
is always trade-off of overhead for LRU aging.

> 
> > preemptively evicting file pages and only making them more likely to
> > be evicted when there's already memory pressure, we avoid the case
> > where we process_madvise an app then immediately return to the app and
> > reload all file pages in the working set even though there was no
> > intervening memory pressure. Our initial version of this work evicted
> 
> That would be the worst case scenario which should be avoided. Memory pressure
> must be a parameter before actually doing the swap out. But pages if know to be
> inactive/cold can be marked high priority to be swapped out.
> 
> > file pages preemptively and did cause a noticeable slowdown (~15%) for
> > that case; this patch set avoids that slowdown. Finally, the benefit
> > from avoiding cold starts is huge. The performance improvement from
> > having a hot start instead of a cold start ranges from 3x for very
> > small apps to 50x+ for larger apps like high-fidelity games.
> 
> Is there any other real world scenario apart from this app based ecosystem where
> user hinted LRU management might be helpful ? Just being curious. Thanks for the
> detailed explanation. I will continue looking into this series.
