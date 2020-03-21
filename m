Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1452B18E2FA
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Mar 2020 17:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbgCUQry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Mar 2020 12:47:54 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:34537 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbgCUQry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 12:47:54 -0400
Received: by mail-yb1-f196.google.com with SMTP id d186so4390356ybh.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Mar 2020 09:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=caR8ypCPoxXX4yuH6qr9XpwXLn7NOQ5LxC4q9t4T6FQ=;
        b=ERZjmKG61TtxLhsjVIwmq/JgPbngacYJoih9nOpdKS4sfVs5j2gWt3CWj+IPyESnu8
         iQV+v2A4LMKca9iWHBTdOBeARcSmPi7dENOSYuQQsIqTpllEzaIegJqzngHc/5nNPGk3
         t5pTLOVF2DTcDwwbs+AgA0GsJkRFQaoWrvzYw5e/2X5Wh9Dama7HZ3UHDJ2KYdREP/ty
         B4JjP1zGhd7PTrdhFKos6JGghhnWBFEm36nYbhWymI+0eaU9fpFz2x5aDM1gN//GFWJW
         8dPGh/KxNNsx1izrTRNMylwoHZz4AtjXFV1IiWZ1UOXq1EYepItT1q03ow/AvzypPcAL
         MGsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=caR8ypCPoxXX4yuH6qr9XpwXLn7NOQ5LxC4q9t4T6FQ=;
        b=cO5Ok5Vu+ihX5T94drn2YxuyvVU0zurd9KSyQRqEZ/LGejV49rOS/exWNXWwRCmWR7
         pTgqH5IaHB7wiaTYNXjn9hnS+kwSnRIERuib1cxrZ+sFyCqqHPX9Dr8THwk3x2ynalP2
         A6tHfPEcWy/jptuGqlLw5PlHk4i+CMi5Kt08pXf6r0nbn71cceySh6V1nuH/Za4jlX14
         jbHIaAiFfjloRNMZHBgjWXxOZmQMdOVe77F8VvLi8HlPBblPcI8nDQX1m0XZVEb5zPY5
         QuFAUZUqqZyrRKbkLlRzZPbSHBYFVMR17Bqxkx/gU9GEZb7JfKRpTxGb6SYptVYUdt24
         JurA==
X-Gm-Message-State: ANhLgQ2Wme1R2QiUrakcXZ2fVfbt25rh/AdBdytd3JPmIkC5nMDPdFP2
        k95psXWB6Q9mOEZv4BKymi44clbkvnj6Gfqd9Gf9qg==
X-Google-Smtp-Source: ADFU+vuLMcWXavrptWunHMwpSG8KpX2IyKVZjMJlBeROiAfWoQMAaiF/GoP/xNADvn2bT/uQs7P5MfSVLpMszCAldZA=
X-Received: by 2002:a25:b105:: with SMTP id g5mr2380673ybj.41.1584809273134;
 Sat, 21 Mar 2020 09:47:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200321013839.197114-1-irogers@google.com> <20200321132515.GI20696@hirez.programming.kicks-ass.net>
In-Reply-To: <20200321132515.GI20696@hirez.programming.kicks-ass.net>
From:   Ian Rogers <irogers@google.com>
Date:   Sat, 21 Mar 2020 09:47:41 -0700
Message-ID: <CAP-5=fVa=cv54h3=zmqkGBJp2ygoCiYceC_7jiZyG+BDt2azMA@mail.gmail.com>
Subject: Re: [PATCH] perf/cgroup: correct indirection in perf_less_group_idx
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 21, 2020 at 6:25 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Mar 20, 2020 at 06:38:39PM -0700, Ian Rogers wrote:
> > The void* in perf_less_group_idx is to a cell in the array which points
> > at a perf_event*, as such it is a perf_event**.
> >
> > Fixes: 6eef8a7116de ("perf/core: Use min_heap in visit_groups_merge()")
> > Author: John Sperbeck <jsperbeck@google.com>
>
> That doesn't make sense, did he write the patch? Then there needs to be
> a From: him and a SoB: him, If he reported the issue, it should be
> Reported-by: him.

Done.
https://lkml.org/lkml/2020/3/21/295

> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  kernel/events/core.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index d22e4ba59dfa..a758c2311c53 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -3503,7 +3503,8 @@ static void cpu_ctx_sched_out(struct perf_cpu_context *cpuctx,
> >
> >  static bool perf_less_group_idx(const void *l, const void *r)
> >  {
> > -     const struct perf_event *le = l, *re = r;
> > +     const struct perf_event *le = *(const struct perf_event **)l;
> > +     const struct perf_event *re = *(const struct perf_event **)r;
>
> How did this not insta explode?

Agreed, a cgroup depth of at least 3 is needed for a heap allocation
and we saw this with kasan. CONFIG_KASAN_STACK should have been able
to catch this in the normal case.

Thanks,
Ian
