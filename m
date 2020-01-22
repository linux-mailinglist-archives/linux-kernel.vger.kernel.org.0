Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31107144A30
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 04:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbgAVDIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 22:08:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:40062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728779AbgAVDIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 22:08:50 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3717024655;
        Wed, 22 Jan 2020 03:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579662529;
        bh=oTNgMfzgiFlWv+o+FtS0H6iJQyTPuY25XfjA6TFiIek=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Yxrl8wBG4h/s6p7tA2xfOe/gOsohzh7z0E4xk9RQV4kQQc0W4kdb2NAM1i5bfaJ47
         510X+shvdbbMEguELULpTScXHPcuB2UvBOaheDSzlnxfs6HUmniZ5NusdCISyuX6lI
         ZL2+hhSYgV+UXF3He7kqB1wKdWx2CIeWRVESCyE4=
Date:   Wed, 22 Jan 2020 12:08:43 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Namhyung Kim <namhyung@kernel.org>,
        Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= 
        <thoiland@redhat.com>, Jean-Tsung Hsiao <jhsiao@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing/uprobe: Fix to make trace_uprobe_filter
 alignment safe
Message-Id: <20200122120843.493c7bd2718371af25787206@kernel.org>
In-Reply-To: <20200121105055.6a8b097e@gandalf.local.home>
References: <20200120124022.GA14897@hirez.programming.kicks-ass.net>
        <157959277950.16074.9855390705890955393.stgit@devnote2>
        <20200121105055.6a8b097e@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jan 2020 10:50:55 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 21 Jan 2020 16:46:19 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Commit 99c9a923e97a ("tracing/uprobe: Fix double perf_event
> > linking on multiprobe uprobe") moved trace_uprobe_filter on
> > trace_probe_event. However, since it introduced a flexible
> > data structure with char array and type casting, the
> > alignment of trace_uprobe_filter can be broken.
> > 
> > This changes the type of the array to trace_uprobe_filter
> > data strucure to fix it.
> > 
> > Fixes: 99c9a923e97a ("tracing/uprobe: Fix double perf_event linking on multiprobe uprobe")
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  kernel/trace/trace_kprobe.c |    2 +-
> >  kernel/trace/trace_probe.c  |    9 ++++++---
> >  kernel/trace/trace_probe.h  |   10 ++++++++--
> >  kernel/trace/trace_uprobe.c |   29 +++++++----------------------
> >  4 files changed, 22 insertions(+), 28 deletions(-)
> 
> 
> I hit the following build error with this:

Hmm, I missed something... let me check and update it.

Thank you,

> 
> /work/git/linux-trace.git/kernel/trace/trace_uprobe.c: In function $B!F(Balloc_trace_uprobe$B!G(B:
> /work/git/linux-trace.git/kernel/trace/trace_uprobe.c:355:39: error: $B!F(Btu->tp.event$B!G(B is a pointer; did you mean to use $B!F(B->$B!G(B?
>   init_trace_uprobe_filter(tu->tp.event.filter);
>                                        ^
>                                        ->
> In file included from /work/git/linux-trace.git/arch/x86/include/asm/bug.h:83,
>                  from /work/git/linux-trace.git/include/linux/bug.h:5,
>                  from /work/git/linux-trace.git/arch/x86/include/asm/paravirt.h:15,
>                  from /work/git/linux-trace.git/arch/x86/include/asm/irqflags.h:72,
>                  from /work/git/linux-trace.git/include/linux/irqflags.h:16,
>                  from /work/git/linux-trace.git/include/linux/rcupdate.h:26,
>                  from /work/git/linux-trace.git/include/linux/rbtree.h:22,
>                  from /work/git/linux-trace.git/include/linux/key.h:15,
>                  from /work/git/linux-trace.git/include/linux/security.h:26,
>                  from /work/git/linux-trace.git/kernel/trace/trace_uprobe.c:10:
> /work/git/linux-trace.git/kernel/trace/trace_uprobe.c: In function $B!F(B__probe_event_disable$B!G(B:
> /work/git/linux-trace.git/kernel/trace/trace_uprobe.c:1064:46: error: $B!F(Btu->tp.event$B!G(B is a pointer; did you mean to use $B!F(B->$B!G(B?
>   WARN_ON(!uprobe_filter_is_empty(tu->tp.event.filter));
>                                               ^
> /work/git/linux-trace.git/include/asm-generic/bug.h:113:25: note: in definition of macro $B!F(BWARN_ON$B!G(B
>   int __ret_warn_on = !!(condition);    \
>                          ^~~~~~~~~
> /work/git/linux-trace.git/kernel/trace/trace_uprobe.c: In function $B!F(Bprobe_event_enable$B!G(B:
> /work/git/linux-trace.git/kernel/trace/trace_uprobe.c:1105:46: error: $B!F(Btu->tp.event$B!G(B is a pointer; did you mean to use $B!F(B->$B!G(B?
>   WARN_ON(!uprobe_filter_is_empty(tu->tp.event.filter));
>                                               ^
> /work/git/linux-trace.git/include/asm-generic/bug.h:113:25: note: in definition of macro $B!F(BWARN_ON$B!G(B
>   int __ret_warn_on = !!(condition);    \
>                          ^~~~~~~~~
> /work/git/linux-trace.git/kernel/trace/trace_uprobe.c: In function $B!F(Buprobe_perf_close$B!G(B:
> /work/git/linux-trace.git/kernel/trace/trace_uprobe.c:1269:45: error: $B!F(Btu->tp.event$B!G(B is a pointer; did you mean to use $B!F(B->$B!G(B?
>   if (trace_uprobe_filter_remove(tu->tp.event.filter, event))
>                                              ^
>                                              ->
> /work/git/linux-trace.git/kernel/trace/trace_uprobe.c: In function $B!F(Buprobe_perf_open$B!G(B:
> /work/git/linux-trace.git/kernel/trace/trace_uprobe.c:1294:42: error: $B!F(Btu->tp.event$B!G(B is a pointer; did you mean to use $B!F(B->$B!G(B?
>   if (trace_uprobe_filter_add(tu->tp.event.filter, event))
>                                           ^
>                                           ->
> /work/git/linux-trace.git/kernel/trace/trace_uprobe.c: In function $B!F(Buprobe_perf_filter$B!G(B:
> /work/git/linux-trace.git/kernel/trace/trace_uprobe.c:1316:23: error: $B!F(Btu->tp.event$B!G(B is a pointer; did you mean to use $B!F(B->$B!G(B?
>   filter = tu->tp.event.filter;
>                        ^
>                        ->
> make[3]: *** [/work/git/linux-trace.git/scripts/Makefile.build:266: kernel/trace/trace_uprobe.o] Error 1
> make[3]: *** Waiting for unfinished jobs....
> 
> 
> Config attached.
> 
> -- Steve


-- 
Masami Hiramatsu <mhiramat@kernel.org>
