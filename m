Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2C05562FC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 09:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfFZHQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 03:16:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45239 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfFZHQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 03:16:21 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1hg2A8-0006V9-Lf; Wed, 26 Jun 2019 09:16:12 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v2 1/2] printk-rb: add a new printk ringbuffer implementation
References: <20190607162349.18199-1-john.ogness@linutronix.de>
        <20190607162349.18199-2-john.ogness@linutronix.de>
        <20190618045117.GA7419@jagdpanzerIV> <87imt2bl0k.fsf@linutronix.de>
        <20190625064543.GA19050@jagdpanzerIV>
        <20190625071500.GB19050@jagdpanzerIV> <875zoujbq4.fsf@linutronix.de>
        <20190625090620.wufhvdxxiryumdra@pathway.suse.cz>
        <20190625100322.GD532@jagdpanzerIV> <87woh9hnxg.fsf@linutronix.de>
        <20190626020837.GA25178@jagdpanzerIV>
Date:   Wed, 26 Jun 2019 09:16:11 +0200
In-Reply-To: <20190626020837.GA25178@jagdpanzerIV> (Sergey Senozhatsky's
        message of "Wed, 26 Jun 2019 11:08:37 +0900")
Message-ID: <87mui43jgk.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-06-26, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
> [..]
>> > CPU0								CPU1
>> > printk(...)
>> >  sz = vscprintf(NULL, "Comm %s\n", current->comm);
>> > 								ia64_mca_modify_comm()
>> > 								  snprintf(comm, sizeof(comm), "%s %d", current->comm, previous_current->pid);
>> > 								  memcpy(current->comm, comm, sizeof(current->comm));
>> >  if ((buf = prb_reserve(... sz))) {
>> >    vscnprintf(buf, "Comm %s\n", current->comm);
>> > 				^^^^^^^^^^^^^^ ->comm has changed.
>> > 					       Nothing critical, we
>> > 					       should not corrupt
>> > 					       anything, but we will
>> > 					       truncate ->comm if its
>> > 					       new size is larger than
>> > 					       what it used to be when
>> > 					       we did vscprintf(NULL).
>> >    prb_commit(...);
>> >  }
>
> [..]
>> In my v1 rfc series, I avoided this issue by having a separate dedicated
>> ringbuffer (rb_sprintf) that was used to allocate a temporary max-size
>> (2KB) buffer for sprinting to. Then _that_ was used for the real
>> ringbuffer input (strlen, prb_reserve, memcpy, prb_commit). That would
>> still be the approach of my choice.
>
> In other words per-CPU buffering, AKA printk_safe ;)

Actually, no. I made use of a printk_ringbuffer (which is global). It
was used for temporary memory allocation for sprintf, but the result was
immediately written into the printk buffer from the same context. In
contrast, printk_safe triggers a different context to handle the
insertion.

It is still my intention to eliminate the buffering component of
printk_safe.

After we get a lockless ringbuffer that we are happy with, my next
series to integrate the buffer into printk will again use the sprint_rb
solution to avoid the issue discussed in this thread. Perhaps it would
be best to continue this discussion after I've posted that series.

John Ogness
