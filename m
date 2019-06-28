Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6D6A5A062
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 18:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfF1QHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 12:07:53 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44694 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbfF1QHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 12:07:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wPqqFg7p91+r5i4m2+PhArhGPY41i3UB1iDCXb/Pbl4=; b=vNKzcnEpqdst05Grn4tHAHiQJ
        itngFKqKaInore25YcKuG7VEMm/Oh6NN6oLtKr6+aQtHodvQd/nnsBIYUiB6nPoe6JCbuXzuwNTLC
        wS/VA6/a4bDbKtUJ3scWkyTo2q3UW1cp/ih0pgXBLHjZtEzCttbmOJ6y+2xmoZtpdG06HTyXzvGuY
        aCaR7bPk6jwR8EIdA9EhDqgMwkKjTclQbXOYQ4yBgw+8AbdUvMaOR3KElt6hRhw6KZZaGm5ZfjNmA
        ALvtyIxaSiS6Q82TZzfrnuQ5k6O1YQEw7BwDo537wHP+W4uAbUb4iU5Vdrzmy2SKpf9F3QoqFj4se
        hVS9ke5JQ==;
Received: from [31.161.200.126] (helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgtPb-0001gR-5n; Fri, 28 Jun 2019 16:07:43 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2BE3E9802C5; Fri, 28 Jun 2019 18:07:40 +0200 (CEST)
Date:   Fri, 28 Jun 2019 18:07:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v2 1/2] printk-rb: add a new printk ringbuffer
 implementation
Message-ID: <20190628160740.GC8451@worktop.programming.kicks-ass.net>
References: <20190607162349.18199-1-john.ogness@linutronix.de>
 <20190607162349.18199-2-john.ogness@linutronix.de>
 <20190618114747.GQ3436@hirez.programming.kicks-ass.net>
 <87k1df28x4.fsf@linutronix.de>
 <20190626224034.GK2490@worktop.programming.kicks-ass.net>
 <87mui2ujh2.fsf@linutronix.de>
 <20190628154435.GZ7905@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628154435.GZ7905@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 05:44:35PM +0200, Peter Zijlstra wrote:
> On Fri, Jun 28, 2019 at 11:50:33AM +0200, John Ogness wrote:

> > cmpxchg_release() vs WRITE_ONCE() is not safe?! Can you point me to
> > documentation about this?
> 
> Documentation/atomic_t.txt has this, see the SEMANTICS section on
> atomic-set.

Also see: arch/parisc/lib/bitops.c for one such case.
