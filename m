Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5940814224
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2019 21:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbfEETng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 May 2019 15:43:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:42178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbfEETnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 15:43:35 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B577F20578;
        Sun,  5 May 2019 19:43:34 +0000 (UTC)
Date:   Sun, 5 May 2019 15:43:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Viktor Rosendahl <viktor.rosendahl@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] ftrace: Implement fs notification for
 preempt/irqsoff tracers
Message-ID: <20190505154333.56f3a187@oasis.local.home>
In-Reply-To: <20190504164710.GA55790@google.com>
References: <20190501203650.29548-1-viktor.rosendahl@gmail.com>
        <20190501203650.29548-2-viktor.rosendahl@gmail.com>
        <20190504164710.GA55790@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 May 2019 12:47:10 -0400
Joel Fernandes <joel@joelfernandes.org> wrote:

 
> I agree with the general idea, but I don't really like how it is done in the
> patch.

+1

> 
> We do have a notification mechanism already in the form of trace_pipe. Can we
> not improve that in some way to be notified of a new trace data? In theory,
> the trace_pipe does fit into the description in the documentation: "Reads
> from this file will block until new data is retrieved"
> 
> More comment below:
> 
> 

> > +	config PREEMPTIRQ_FSNOTIFY
> > +	bool "Generate fsnotify events for the latency tracers"
> > +	default n
> > +	depends on (IRQSOFF_TRACER || PREEMPT_TRACER) && FSNOTIFY
> > +	help
> > +	  This option will enable the generation of fsnotify events for the
> > +	  trace file. This makes it possible for userspace to be notified about
> > +	  modification of /sys/kernel/debug/tracing/trace through the inotify
> > +	  interface.  
> 
> Does this have to be a CONFIG option? If prefer if the code automatically
> does the notification and it is always enabled. I don't see any drawbacks of
> that.

I mentioned that anything it needs to be an option.


> > +#ifdef CONFIG_PREEMPTIRQ_FSNOTIFY
> > +
> > +static void trace_notify_workfn(struct work_struct *work)  
> [snip]
> 
> I prefer if this facility is available to other tracers as well such as
> the wakeup tracer which is similar in output (check
> Documentation/trace/ftrace.txt). I believe this should be a generic trace
> facility, and not tracer specific.


For what it's worth, I agree with everything Joel just stated.

Thanks,

-- Steve
