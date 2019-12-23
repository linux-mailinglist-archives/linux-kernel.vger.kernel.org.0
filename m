Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D61AC12988C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Dec 2019 17:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfLWQBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Dec 2019 11:01:24 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37989 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfLWQBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 11:01:24 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1ijQ8k-0004jA-Bx; Mon, 23 Dec 2019 17:01:02 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        kexec@lists.infradead.org
Subject: Re: [RFC PATCH v5 1/3] printk-rb: new printk ringbuffer implementation (writer)
References: <20191128015235.12940-1-john.ogness@linutronix.de>
        <20191128015235.12940-2-john.ogness@linutronix.de>
        <20191221142235.GA7824@andrea>
Date:   Mon, 23 Dec 2019 17:01:00 +0100
Message-ID: <87imm7820z.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,

On 2019-12-21, Andrea Parri <parri.andrea@gmail.com> wrote:
>> +	*desc_out = READ_ONCE(*desc);
>> +
>> +	/* Load data before re-checking state. */
>> +	smp_rmb(); /* matches LMM_REF(desc_reserve:A) */
>
> I looked for a matching WRITE_ONCE() or some other type of marked write,
> but I could not find it.  What is the rationale?  Or what did I miss?

This smp_rmb() matches LMM_TAG(desc_reserve:A).

>> +	do {
>> +		next_lpos = get_next_lpos(data_ring, begin_lpos, size);
>> +
>> +		if (!data_push_tail(rb, data_ring,
>> +				    next_lpos - DATA_SIZE(data_ring))) {
>> +			/* Failed to allocate, specify a data-less block. */
>> +			blk_lpos->begin = INVALID_LPOS;
>> +			blk_lpos->next = INVALID_LPOS;
>> +			return NULL;
>> +		}
>> +	} while (!atomic_long_try_cmpxchg(&data_ring->head_lpos, &begin_lpos,
>> +					  next_lpos));
>> +
>> +	/*
>> +	 * No barrier is needed here. The data validity is defined by
>> +	 * the state of the associated descriptor. They are marked as
>> +	 * invalid at the moment. And only the winner of the above
>> +	 * cmpxchg() could write here.
>> +	 */
>
> The (successful) CMPXCHG provides a full barrier.  This comment suggests
> that that could be somehow relaxed?  Or the comment could be improved?

You are correct. There is no need for the full barrier here. This code
is based on Petr's POC. I focussed on making sure needed barriers are in
place, but did not try to eliminate excessive barriers.

> (The patch introduces a number of CMPXCHG: similar questions would
> apply to those other instances...)

LMM_TAG(data_push_tail:A) is the only CMPXCHG that requires its full
barrier. All others can be relaxed. I will make this change for the next
series.

Thanks for taking time for this.

John Ogness
