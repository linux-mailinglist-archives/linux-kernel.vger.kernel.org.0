Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF68111920B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 21:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfLJUcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 15:32:33 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41778 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfLJUcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 15:32:33 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iemBF-00016E-EJ; Tue, 10 Dec 2019 21:32:25 +0100
Date:   Tue, 10 Dec 2019 21:32:25 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        David Howells <dhowells@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: Problem with WARN_ON in mutex_trylock() and rxrpc
Message-ID: <20191210203225.2kvykwn35gnethjn@linutronix.de>
References: <26229.1575547344@warthog.procyon.org.uk>
 <20191205132212.GK2827@hirez.programming.kicks-ass.net>
 <87wob4hvyq.fsf@nanos.tec.linutronix.de>
 <20191210192538.GB11457@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191210192538.GB11457@worktop.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-10 20:25:38 [+0100], Peter Zijlstra wrote:
> AFAICT the only assumption it relies on are:
> 
>  - that the softirq will cleanly preempt a task. That is, the task
>    context must not change under the softirq execution.
> 
>  - that the softirq runs non-preemptible.
> 
> Now, both these properties are rather fundamental to how our softirqs
> work. And can, therefore, be relied upon, irrespective of the mutex
> implementation.

softirq is preemptible on -RT (I think you know that already but just in
case).

Sebastian
