Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC5A152B3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2019 19:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfEFRXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 13:23:41 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56778 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbfEFRXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 13:23:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97678374;
        Mon,  6 May 2019 10:23:40 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FBF13F575;
        Mon,  6 May 2019 10:23:39 -0700 (PDT)
Date:   Mon, 6 May 2019 18:23:36 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 4/7] sched: Add sched_load_rq tracepoint
Message-ID: <20190506172336.cxbfwasv7rfegbi3@e107158-lin.cambridge.arm.com>
References: <20190505115732.9844-1-qais.yousef@arm.com>
 <20190505115732.9844-5-qais.yousef@arm.com>
 <20190506090859.GK2606@hirez.programming.kicks-ass.net>
 <20190506095239.08577b3e@gandalf.local.home>
 <20190506144200.z4s63nm7untol2tr@e107158-lin.cambridge.arm.com>
 <20190506104618.2fa49e13@gandalf.local.home>
 <20190506153317.fv73wpdwsn7xcyc4@e107158-lin.cambridge.arm.com>
 <20190506120119.12d98042@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190506120119.12d98042@gandalf.local.home>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/19 12:01, Steven Rostedt wrote:
> On Mon, 6 May 2019 16:33:17 +0100
> Qais Yousef <qais.yousef@arm.com> wrote:
> 
> > On 05/06/19 10:46, Steven Rostedt wrote:
> > > On Mon, 6 May 2019 15:42:00 +0100
> > > Qais Yousef <qais.yousef@arm.com> wrote:
> > >   
> > > > I can control that for the wrappers I'm introducing. But the actual tracepoint
> > > > get the 'trace_' part prepended automatically by the macros.
> > > > 
> > > > ie DECLARE_TRACE(pelt_rq, ...) will automatically generate a function called
> > > > trace_pelt_se(...)
> > > > 
> > > > Or am I missing something?  
> > > 
> > > No trace comes from the trace points.  
> 
> Re-reading that line, I see I totally didn't express what I meant :-p
> 
> > 
> > If you want I can do something like below to help create a distinction. It is
> > none enforcing though.
> > 
> > diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> > index 9c3186578ce0..f654ced20045 100644
> > --- a/include/linux/tracepoint.h
> > +++ b/include/linux/tracepoint.h
> > @@ -232,6 +232,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
> >   */
> >  #define __DECLARE_TRACE(name, proto, args, cond, data_proto, data_args) \
> >         extern struct tracepoint __tracepoint_##name;                   \
> > +       static inline void tp_##name(proto) __alias(trace_##name);      \
> >         static inline void trace_##name(proto)                          \
> >         {                                                               \
> >                 if (static_key_false(&__tracepoint_##name.key))         \
> > 
> > 
> > Another option is to extend DECLARE_TRACE() to take a new argument IS_TP and
> > based on that select the function name. This will be enforcing but I will have
> > to go fixup many places.
> > 
> > Of course 'TP' can be replaced with anything more appealing.
> 
> No no no, I meant to say...
> 
>  "No that's OK. The "trace_" *is* from the trace points, and trace
>  events build on top of them."

I did have to stare at the original statement for a bit :-)
This makes more sense now. Thanks for the clarification.

--
Qais Yousef
