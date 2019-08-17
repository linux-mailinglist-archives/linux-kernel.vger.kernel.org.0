Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D692911FC
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2019 18:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbfHQQk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Aug 2019 12:40:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:36432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbfHQQk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 12:40:57 -0400
Received: from oasis.local.home (rrcs-76-79-140-27.west.biz.rr.com [76.79.140.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D95B2075E;
        Sat, 17 Aug 2019 16:40:54 +0000 (UTC)
Date:   Sat, 17 Aug 2019 12:40:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 1/1] Fix: trace sched switch start/stop racy updates
Message-ID: <20190817124040.34c38e19@oasis.local.home>
In-Reply-To: <1360102474.23943.1566057317249.JavaMail.zimbra@efficios.com>
References: <241506096.21688.1565977319832.JavaMail.zimbra@efficios.com>
        <CAEXW_YQrh42N5bYMmQJCFb6xa0nwXH8jmZMEAnGVBMjGF8wR1Q@mail.gmail.com>
        <alpine.DEB.2.21.1908162245440.1923@nanos.tec.linutronix.de>
        <CAHk-=wh9qDFfWJscAQw_w+obDmZvcE5jWJRdYPKYP6YhgoGgGA@mail.gmail.com>
        <1642847744.23403.1566005809759.JavaMail.zimbra@efficios.com>
        <20190816221313.4b05b876@oasis.local.home>
        <39888715.23900.1566052831673.JavaMail.zimbra@efficios.com>
        <20190817112655.2277a9c5@oasis.local.home>
        <1360102474.23943.1566057317249.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Aug 2019 11:55:17 -0400 (EDT)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> ----- On Aug 17, 2019, at 11:26 AM, rostedt rostedt@goodmis.org wrote:
> 
> > On Sat, 17 Aug 2019 10:40:31 -0400 (EDT)
> > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> >   
> >> > I'm now even more against adding the READ_ONCE() or WRITE_ONCE().  
> >> 
> >> I'm not convinced by your arguments.  
> > 
> > Prove to me that there's an issue here beyond theoretical analysis,
> > then I'll consider that patch.
> > 
> > Show me a compiler used to compile the kernel that zeros out the
> > increment. Show me were the race actually occurs.
> > 
> > I think the READ/WRITE_ONCE() is more confusing than helpful. And
> > unneeded churn to the code. And really not needed for something that's
> > not critical to execution.  
> 
> I'll have to let the authors of the LWN article speak up on this, because
> I have limited time to replicate this investigation myself.

I'll let Paul McKenney convince me then, if he has any spare cycles ;-)

The one instance in that article is from a 2013 bug, which talks about
storing a 64 bit value on a 32 bit machine. But the ref count is an int
(32 bit), and I highly doubt any compiler will split it into 16 bit
stores for a simple increment. And I don't believe Linux even supports
any architecture that requires 16 bit stores anymore.

-- Steve
