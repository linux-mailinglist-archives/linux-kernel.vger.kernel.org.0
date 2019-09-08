Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 457C4AD0A3
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2019 22:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbfIHUpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Sep 2019 16:45:18 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46159 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729263AbfIHUpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 16:45:18 -0400
Received: by mail-pl1-f194.google.com with SMTP id t1so5602323plq.13
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 13:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=YFDt2p4CFgyTp80Sbfxw8GrfHYWi+qSB2/ENmbYz5BM=;
        b=otTM7bYvBhBq3Yv3RVix/LtrdR8BElsdYKEA+1pvcDJFJvhP1buipkD+FlibLgdvU+
         0txjlK8gu+jVXrEcYOSIQm5SPwB/zoC+AtdWfewqk6Jne0NCEx59fw/SmKAI5Aecm9uv
         flnhtV5lPsv/5Aq8jtaLJeGDw3Y8Kbki7cp97+Y+RJmUUeMH7vTzeyoY9kE6l+DjMWUo
         eaERwBrPv6+zlKiLYiUmkBXQ2WPWLzB92K8VOkReLfQv/kxaQlQcHBDT9cQ5+VBAUuIj
         C+GOKtkFOKEn4WEwreZqdPQvSd/bG8FWSlKHRDsgR5mBs5CVIymR2og/H7EoEe21/5Br
         tytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=YFDt2p4CFgyTp80Sbfxw8GrfHYWi+qSB2/ENmbYz5BM=;
        b=EIYgtjtb7+IvPElRQrz+RxtTE8viRxL8FvGZSxiJF9GaWp3O4vXuOmo+jQudTTbkQQ
         bPWQCY92+OntuCA5zbBrWiQ74fHhI1RKeyTLCNmSPCX14r5t4/ez4uck6j5kAZm7vwTs
         kLKevqiVFtvwTl6bXV9HgmLU5nUbYbjCIj6gqvVpzhmgr0oflQBc6Q4jkD1IG8OyKpDM
         wtG+M+ahZZqHrDjXrRTyMVZcmDyJIUgKf0FoZ79EV1QsYe21f0E5heXzZxGpHxa0jtzY
         aYd/j04oMB2BEluA32fm4S3v/eE4s1ISJyYZZuyjvoSVKTbsS+TOTs/SMW/ZPYFvF6ZA
         I6Vg==
X-Gm-Message-State: APjAAAWhoK8S8mP6+3jO79sa91HbgbBOhlYNGiCFK2mMcps9RDwGhMeZ
        W4Kc4GSFMYnL2stpamuxJKKqvg==
X-Google-Smtp-Source: APXvYqwnj4ZZ9mNJnkBMoiehgQjiZomwZ11H6cpGoTbTEDARRAcvax5jQ5ZSiuIWRT1qrdfGhl+W3w==
X-Received: by 2002:a17:902:a98b:: with SMTP id bh11mr20839738plb.40.1567975515397;
        Sun, 08 Sep 2019 13:45:15 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id q204sm18643828pfc.11.2019.09.08.13.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 13:45:14 -0700 (PDT)
Date:   Sun, 8 Sep 2019 13:45:13 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [patch for-5.3 0/4] revert immediate fallback to remote
 hugepages
In-Reply-To: <d76f8cc3-97aa-8da5-408d-397467ea768b@suse.cz>
Message-ID: <alpine.DEB.2.21.1909081328220.178796@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1909041252230.94813@chino.kir.corp.google.com> <CAHk-=wjmF_MGe5sBDmQB1WGpr+QFWkqboHpL37JYB5WgnG8nMA@mail.gmail.com> <alpine.DEB.2.21.1909051345030.217933@chino.kir.corp.google.com> <alpine.DEB.2.21.1909071249180.81471@chino.kir.corp.google.com>
 <CAHk-=wifuQ68e6Q4F2txGS48WgcoX2REE4te5_j36ypV-T2ZKw@mail.gmail.com> <alpine.DEB.2.21.1909071829440.200558@chino.kir.corp.google.com> <d76f8cc3-97aa-8da5-408d-397467ea768b@suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Sep 2019, Vlastimil Babka wrote:

> > On Sat, 7 Sep 2019, Linus Torvalds wrote:
> > 
> >>> Andrea acknowledges the swap storm that he reported would be fixed with
> >>> the last two patches in this series
> >>
> >> The problem is that even you aren't arguing that those patches should
> >> go into 5.3.
> >>
> > 
> > For three reasons: (a) we lack a test result from Andrea,
> 
> That's argument against the rfc patches 3+4s, no? But not for including
> the reverts of reverts of reverts (patches 1+2).
> 

Yes, thanks: I would strongly prefer not to propose rfc patches 3-4 
without a testing result from Andrea and collaboration to fix the 
underlying issue.  My suggestion to Linus is to merge patches 1-2 so we 
don't have additional semantics for MADV_HUGEPAGE or thp enabled=always 
configs based on kernel version, especially since they are already 
conflated.

> > (b) there's 
> > on-going discussion, particularly based on Vlastimil's feedback, and 
> 
> I doubt this will be finished and tested with reasonable confidence even
> for the 5.4 merge window.
> 

Depends, but I probably suspect the same.  If the reverts to 5.3 are not 
applied, then I'm not at all confident that forward progress on this issue 
will be made: my suggestion about changes to the page allocator when the 
patches were initially proposed went unresponded to, as did the ping on 
those suggestions, and now we have a simplistic "this will fix the swap 
storms" but no active involvement from Andrea to improve this; he likely 
is quite content on lumping NUMA policy onto an already overloaded madvise 
mode.

 [ NOTE! The rest of this email and my responses are about how to address
   the default page allocation behavior which we can continue to discuss
   but I'd prefer it separated from the discussion of reverts for 5.3
   which needs to be done to not conflate madvise modes with mempolicies
   for a subset of kernel versions. ]

> > It indicates that progress has been made to address the actual bug without 
> > introducing long-lived access latency regressions for others, particularly 
> > those who use MADV_HUGEPAGE.  In the worst case, some systems running 
> > 5.3-rc4 and 5.3-rc5 have the same amount of memory backed by hugepages but 
> > on 5.3-rc5 the vast majority of it is allocated remotely.  This incurs a
> 
> It's been said before, but such sensitive code generally relies on
> mempolicies or node reclaim mode, not THP __GFP_THISNODE implementation
> details. Or if you know there's enough free memory and just needs to be
> compacted, you could do it once via sysfs before starting up your workload.
> 

This entire discussion is based on the long standing and default behavior 
of page allocation for transparent hugepages.  Your suggestions are not 
possible for two reasons: (1) I cannot enforce a mempolicy of MPOL_BIND 
because this doesn't allow fallback at all and would oom kill if the local 
node is oom, and (2) node reclaim mode is a system-wide setting so all 
workloads are affected for every page allocation, not only users of 
MADV_HUGEPAGE who specifically opt-in to expensive allocation.

We could make the argument that Andrea's qemu usecase could simply use 
MPOL_PREFERRED for memory that should be faulted remotely which would 
provide more control and would work for all versions of Linux regardless 
of MADV_HUGEPAGE or not; that's a much more simple workaround than 
conflating MADV_HUGEPAGE for NUMA locality, asking users who are adversely 
affected by 5.3 to create new mempolicies to work around something that 
has always worked fine, or asking users to tune page allocator policies 
with sysctls.

> > I'm arguing to revert 5.3 back to the behavior that we have had for years 
> > and actually fix the bug that everybody else seems to be ignoring and then 
> > *backport* those fixes to 5.3 stable and every other stable tree that can 
> > use them.  Introducing a new mempolicy for NUMA locality into 5.3.0 that
> 
> I think it's rather removing the problematic implicit mempolicy of
> __GFP_THISNODE.
> 

I'm referring to a solution that is backwards compatible for existing 
users which 5.3 is certainly not.

> I might have missed something, but you were asked for a reproducer of
> your use case so others can develop patches with it in mind? Mel did
> provide a simple example that shows the swap storms very easily.
> 

Are you asking for a synthetic kernel module that you can inject to induce 
fragmentation on a local node where memory compaction would be possible 
and then a userspace program that uses MADV_HUGEPAGE and fits within that 
node?  The regression I'm reporting is for workloads that fit within a 
socket, it requires local fragmentation to show a regression.

For the qemu case, it's quite easy to fill a local node and require 
additional hugepage allocations with MADV_HUGEPAGE in a test case, but for
without synthetically inducing fragmentation I cannot provide a testcase 
that will show performance regression because memory is quickly faulted 
remotely rather than compacting locally.
