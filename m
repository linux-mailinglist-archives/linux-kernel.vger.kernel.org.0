Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC43314B3C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2019 15:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfEFNwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 09:52:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbfEFNwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 09:52:42 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B38A2054F;
        Mon,  6 May 2019 13:52:41 +0000 (UTC)
Date:   Mon, 6 May 2019 09:52:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Qais Yousef <qais.yousef@arm.com>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 4/7] sched: Add sched_load_rq tracepoint
Message-ID: <20190506095239.08577b3e@gandalf.local.home>
In-Reply-To: <20190506090859.GK2606@hirez.programming.kicks-ass.net>
References: <20190505115732.9844-1-qais.yousef@arm.com>
        <20190505115732.9844-5-qais.yousef@arm.com>
        <20190506090859.GK2606@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 May 2019 11:08:59 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> These functions really should be called trace_*()
> 
> Also; I _really_ hate how fat they are. Why can't we do simple straight
> forward things like:
> 
> 	trace_pelt_cfq(cfq);
> 	trace_pelt_rq(rq);
> 	trace_pelt_se(se);
> 
> And then have the thing attached to the event do the fat bits like
> extract the path and whatnot.

I'd like to avoid functions called "trace_*" that are not trace events.
It's getting confusing when I see a "trace_*()" function and then go
look for the corresponding TRACE_EVENT() just to find out that one does
not exist.

 sched_trace_*()  maybe?

-- Steve
