Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8177250404
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 09:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbfFXHzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 03:55:35 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41492 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfFXHzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 03:55:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YKFDzPGybk5R8ch9oFESg0knJ0Pigl4fK6opa7BBhXs=; b=V/yp/xFpxovkcAEcUvqU2xT2w
        qZ1urH3v0huiIIxE8ng2FZ16RZ70VMmsBfveNRAEXtlOyufCpaMhYw5iQet+dPtxzV5LunBfZeJ4G
        4HajUwoG5PQce29O0CDx+kZL3A4lJ9hid6H9v4p9Mt1D5Dol+Ojc/CJ2vzLWHFJS2+7kha2UZzvZ6
        5tgGA4cI/PBbY8Rxb8LXuyMjwd0kVzzVQ4+xNgyOld88OQwXHIu67FDhw7S3qOdyMm2FcHyPTqDCq
        hys5xkq/YBuxtuq2/4aE3VveM5+I8weU1ke5TsvZC4dQefBvmASfU7DAcAaHIb8JZ4LgMzMKgTEBa
        l+qv6HU3w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfJov-0005PR-8T; Mon, 24 Jun 2019 07:55:21 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2002D203C05DA; Mon, 24 Jun 2019 09:55:20 +0200 (CEST)
Date:   Mon, 24 Jun 2019 09:55:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf cgroups: Don't rotate events for cgroups
 unnecessarily
Message-ID: <20190624075520.GC3436@hirez.programming.kicks-ass.net>
References: <20190601082722.44543-1-irogers@google.com>
 <20190621082422.GH3436@hirez.programming.kicks-ass.net>
 <CAP-5=fW7sMjQEHm+1e=cdAi+ZyP53UyU7xhAbnouMApuxYqrhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fW7sMjQEHm+1e=cdAi+ZyP53UyU7xhAbnouMApuxYqrhw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 11:01:29AM -0700, Ian Rogers wrote:
> On Fri, Jun 21, 2019 at 1:24 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Sat, Jun 01, 2019 at 01:27:22AM -0700, Ian Rogers wrote:
> > > @@ -3325,6 +3331,15 @@ static int flexible_sched_in(struct perf_event *event, void *data)
> > >                       sid->can_add_hw = 0;
> > >       }
> > >
> > > +     /*
> > > +      * If the group wasn't scheduled then set that multiplexing is necessary
> > > +      * for the context. Note, this won't be set if the event wasn't
> > > +      * scheduled due to event_filter_match failing due to the earlier
> > > +      * return.
> > > +      */
> > > +     if (event->state == PERF_EVENT_STATE_INACTIVE)
> > > +             sid->ctx->rotate_necessary = 1;
> > > +
> > >       return 0;
> > >  }
> >
> > That looked odd; which had me look harder at this function which
> > resulted in the below. Should we not terminate the context interation
> > the moment one flexible thingy fails to schedule?
> 
> If we knew all the events were hardware events then this would be
> true, as there may be software events that always schedule then the
> continued iteration is necessary.

But this is the 'old' code, where this is guaranteed by the context.
That is, if this is a hardware context; there wil only be software
events due to them being in a group with hardware events.

If this is a software group, then we'll never fail to schedule and we'll
not get in this branch to begin with.

Or am I now confused for having been staring at two different code-bases
at the same time?
