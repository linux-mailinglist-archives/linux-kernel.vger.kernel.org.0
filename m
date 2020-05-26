Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 819C5199949
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 17:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730810AbgCaPLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 11:11:07 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:39857 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730592AbgCaPLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 11:11:07 -0400
Received: by mail-qv1-f65.google.com with SMTP id v38so11012597qvf.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 08:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cL08A4+kp0Y65AGLtqIoipG3SABzeYJkBubqqjwQrYg=;
        b=wAFNN/UMuvu+vH9ES4W5SFNAVQYgWw45te05ekS4MQu7vEn7mxRosfgjeRbU3HiEAq
         hUnlFE/DdeULkB891pVk8cdhRoYRQZSTgsAVDJP6Pg/ZtPIN2xPS+7aCiX/i9kpstFZC
         nI3k03KbtEY+bcIQriZyQl90tTpaRsfj9nIEafKhQ1sxNc1fu3xTpgYwPDmQNRO9MpC+
         BTqrNwSsj9qOUOdsTvZcPfw35IbXlLcCKCARpsi4Y/nSexlhABrVoP5pWvOPRHZFpltY
         76ctavOq5D/flZ8NBqsajomS/yb4+k8cLYxHZLXCIIRGpFZm38okEgNvLePyq2IPU0WQ
         5Xvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cL08A4+kp0Y65AGLtqIoipG3SABzeYJkBubqqjwQrYg=;
        b=X7Zn2lpNYhj8TDunEU2WZSn4VEMF+3XxVExlmOiVJuNWKHN+jVkjeupt8DgS9PGPdc
         GJlEIbUtaskEMhs9cC0Hrs5Li65W7fEeKwHhYUK0bKIU8UfCTEcCTiagm8FsNVEeaMga
         8NmtvXFgE2K00XcJ6IJLMk2ln3eV8w2TwyfeTLdtoIHqtOBhQpNQ7nNuRuTMe7lkVtPa
         3kNLwPvwEzbmE2G1gDyubkPrBTrdJgU5+YFOSRPCf4N2rBFZXocKBcv2euamV/wf3jCd
         WJX0FsO9TodIce1WDE6mb4vIdOaSIilNmcl8ekZ7lc60bMromxd/yew+QKs/BZb+Qdft
         nyqw==
X-Gm-Message-State: ANhLgQ2BaLuJ0XknOkwlJgrc9c9uISULkiXHFN3ovM0Bs1UdJCjFA5sh
        yOavB0lcZBlXi6RrsnqQ8S10lQ==
X-Google-Smtp-Source: ADFU+vt3LCjS0xkXV3rjTOBSJRA2OF5NbQ3lYcpN2wK4TAg1p0cskQb+ade5qXppPN1vNqf2ot/j1A==
X-Received: by 2002:ad4:4364:: with SMTP id u4mr16331097qvt.58.1585667465461;
        Tue, 31 Mar 2020 08:11:05 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id t43sm13933859qtc.14.2020.03.31.08.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 08:11:04 -0700 (PDT)
Date:   Tue, 31 Mar 2020 11:11:03 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        mgorman@suse.de, Steven Rostedt <rostedt@goodmis.org>,
        mingo@redhat.com, Linux MM <linux-mm@kvack.org>,
        linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] psi: enhance psi with the help of ebpf
Message-ID: <20200331151103.GB2089@cmpxchg.org>
References: <1585221127-11458-1-git-send-email-laoar.shao@gmail.com>
 <20200326143102.GB342070@cmpxchg.org>
 <CALOAHbCe9msQ+7uON=7iXnud-hzDcrnz_2er4PMQRXtNLM2BSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbCe9msQ+7uON=7iXnud-hzDcrnz_2er4PMQRXtNLM2BSQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 09:17:59AM +0800, Yafang Shao wrote:
> On Thu, Mar 26, 2020 at 10:31 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Thu, Mar 26, 2020 at 07:12:05AM -0400, Yafang Shao wrote:
> > > PSI gives us a powerful way to anaylze memory pressure issue, but we can
> > > make it more powerful with the help of tracepoint, kprobe, ebpf and etc.
> > > Especially with ebpf we can flexiblely get more details of the memory
> > > pressure.
> > >
> > > In orderc to achieve this goal, a new parameter is added into
> > > psi_memstall_{enter, leave}, which indicates the specific type of a
> > > memstall. There're totally ten memstalls by now,
> > >         MEMSTALL_KSWAPD
> > >         MEMSTALL_RECLAIM_DIRECT
> > >         MEMSTALL_RECLAIM_MEMCG
> > >         MEMSTALL_RECLAIM_HIGH
> > >         MEMSTALL_KCOMPACTD
> > >         MEMSTALL_COMPACT
> > >         MEMSTALL_WORKINGSET_REFAULT
> > >         MEMSTALL_WORKINGSET_THRASHING
> > >         MEMSTALL_MEMDELAY
> > >         MEMSTALL_SWAPIO
> >
> > What does this provide over the events tracked in /proc/vmstats?
> >
> 
> /proc/vmstat only tells us which events occured, but it can't tell us
> how long these events take.
> Sometimes we really want to know how long the event takes and PSI can
> provide us the data
> For example, in the past days when I did performance tuning for a
> database service, I monitored that the latency spike is related with
> the workingset_refault counter in /proc/vmstat, and at that time I
> really want to know the spread of latencies caused by
> workingset_refault, but there's no easy way to get it. Now with newly
> added MEMSTALL_WORKINGSET_REFAULT, I can get the latencies caused by
> workingset refault.

Okay, but how do you use that information in practice?

> > Can you elaborate a bit how you are using this information? It's not
> > quite clear to me from the example in patch #2.
> >
> 
> From the traced data in patch #2, we can find that the high latencies
> of user tasks are always type 7 of memstall , which is
> MEMSTALL_WORKINGSET_THRASHING,  and then we should look into the
> details of wokingset of the user tasks and think about how to improve
> it - for example, by reducing the workingset.

That's an analyses we run frequently as well: we see high pressure,
and then correlate it with the events.

High rate of refaults? The workingset is too big.

High rate of compaction work? Somebody is asking for higher order
pages under load; check THP events next.

etc.

This works fairly reliably. I'm curious what the extra per-event
latency breakdown would add and where it would be helpful.

I'm not really opposed to your patches it if it is, I just don't see
the usecase right now.
