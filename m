Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE03016177C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 17:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbgBQQO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 11:14:28 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60203 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbgBQQO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:14:28 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1j3j2N-0001Hx-Sj; Mon, 17 Feb 2020 17:14:23 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     Petr Mladek <pmladek@suse.com>
Cc:     lijiang <lijiang@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: crashdump: Re: [PATCH 2/2] printk: use the lockless ringbuffer
References: <20200128161948.8524-1-john.ogness@linutronix.de>
        <20200128161948.8524-3-john.ogness@linutronix.de>
        <ccbe1383-a4a4-41f8-3330-972f03c97429@redhat.com>
        <87zhdle0s5.fsf@linutronix.de>
        <20200217154026.7x2xyrklprgql4if@pathway.suse.cz>
Date:   Mon, 17 Feb 2020 17:14:22 +0100
In-Reply-To: <20200217154026.7x2xyrklprgql4if@pathway.suse.cz> (Petr Mladek's
        message of "Mon, 17 Feb 2020 16:40:26 +0100")
Message-ID: <87zhdh9oo1.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-17, Petr Mladek <pmladek@suse.com> wrote:
>>> Should the "prb"(printk tb static) symbol be exported into
>>> vmcoreinfo?  Otherwise, do you happen to know how to walk through
>>> the log_buf and get all kernel logs from vmcore?
>> 
>> You are correct. This will need to be exported as well so that the
>> descriptors can be accessed. (log_buf is only the pure human-readable
>> text.) I am currently hacking the crash tool to see exactly what
>> needs to be made available in order to access all the data of the
>> ringbuffer.
>
> I am not sure which parts you are working on. Are you going to provide
> also patch for makedumpfile, please?

I'm working on crash first. makedumpfile is on my list as well.

> I get the following failure when creating the crashdump using:
>
>     echo c >/proc/sysrq-trigger
>
>
> The kernel version is not supported.
> The makedumpfile operation may be incomplete.
> dump_dmesg: Can't find variable-length record symbols
> makedumpfile Failed.
> Running makedumpfile --dump-dmesg /proc/vmcore failed (1).

Yes, the symbols have changed (and some are missing). I will get this
sorted out for v2. And I will provide some heavily hacked code for crash
and makedumpfile to show that the necessary symbols are there and it
works.

John Ogness
