Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 754B710457B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 22:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbfKTVFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 16:05:23 -0500
Received: from merlin.infradead.org ([205.233.59.134]:48158 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfKTVFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 16:05:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=V6mmgxtkXDcIQX6qcqCxCHnDmuVgMT2R3iVxZ3C6yPE=; b=faVO0Z2XZSMV08kbBojdX5+/b
        ifwe+BJWp/QGCOQIWP3sMMKcJaMRH9nOqeh7yQcbLpwaLlSQNdiENL3VlgdsQ227vj5eANPQ23MuL
        iYvzSnvd5b7A4K7NhrnLL3kpiDDufJwztgmuom3zK9RsueuB3gtjGc+8eQEbUUtiKWbYsViSxCn5X
        eZzsOVi1Z6jXHqNKtw8gaQcgCGc2jBMdjsu+s8Bd4F/Hhr+1xptGmlIMhpInlP9QtoAEDYjS+J6sp
        ilZSLfSqeWBBV5VrLi9rd+rbnMjRyYfw6dcOFNjUxI+3WfGPwGvW3lXVO7c9iKEXRLcWvQzC8iCU7
        cTMiVW3SQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iXX9Y-0000QA-65; Wed, 20 Nov 2019 21:04:44 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id F11B3980E2F; Wed, 20 Nov 2019 22:04:40 +0100 (CET)
Date:   Wed, 20 Nov 2019 22:04:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/6] sched/cputime: Support other fields on
 kcpustat_field()
Message-ID: <20191120210440.GR3079@worktop.programming.kicks-ass.net>
References: <20191119232218.4206-1-frederic@kernel.org>
 <20191119232218.4206-2-frederic@kernel.org>
 <20191120115142.GA89662@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120115142.GA89662@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 12:51:42PM +0100, Ingo Molnar wrote:
> * Frederic Weisbecker <frederic@kernel.org> wrote:

> > +		/*
> > +		 * Nice VS unnice cputime accounting may be inaccurate if
> > +		 * the nice value has changed since the last vtime update.
> > +		 * But proper fix would involve interrupting target on nice
> > +		 * updates which is a no go on nohz_full.
> 
> Well, we actually already interrupt the target in both sys_nice() and 
> sys_setpriority() etc. syscall variants: we call set_user_nice() which 
> calls resched_curr() and the task is sent an IPI and runs through a 
> reschedule.

I think we can easily avoid doing that IPI when we find it is the only
task on that runqueue. Which is exactly the case for NOHZ_FULL.

