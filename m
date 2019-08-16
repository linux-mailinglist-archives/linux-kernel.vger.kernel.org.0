Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 890D58FF35
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 11:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfHPJlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 05:41:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41840 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfHPJlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 05:41:49 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1hyYjA-0006SV-I7; Fri, 16 Aug 2019 11:40:56 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Dave Young <dyoung@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: Re: [RFC PATCH v4 9/9] printk: use a new ringbuffer implementation
References: <20190807222634.1723-1-john.ogness@linutronix.de>
        <20190807222634.1723-10-john.ogness@linutronix.de>
        <20190816054651.GA4403@dhcp-128-65.nay.redhat.com>
Date:   Fri, 16 Aug 2019 11:40:54 +0200
In-Reply-To: <20190816054651.GA4403@dhcp-128-65.nay.redhat.com> (Dave Young's
        message of "Fri, 16 Aug 2019 13:46:51 +0800")
Message-ID: <87y2ztwiqh.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-16, Dave Young <dyoung@redhat.com> wrote:
> John, can you cc kexec list for your later series?

Sure.

> On 08/08/19 at 12:32am, John Ogness wrote:
>> This is a major change because the API (and underlying workings) of
>> the new ringbuffer are completely different than the previous
>> ringbuffer. Since there are several components of the printk
>> infrastructure that use the ringbuffer API (console, /dev/kmsg,
>> syslog, kmsg_dump), there are quite a few changes throughout the
>> printk implementation.
>> 
>> This is also a conservative change because it continues to use the
>> logbuf_lock raw spinlock even though the new ringbuffer is lockless.
>> 
>> The externally visible changes are:
>> 
>> 1. The exported vmcore info has changed:
>> 
>>     - VMCOREINFO_SYMBOL(log_buf);
>>     - VMCOREINFO_SYMBOL(log_buf_len);
>>     - VMCOREINFO_SYMBOL(log_first_idx);
>>     - VMCOREINFO_SYMBOL(clear_idx);
>>     - VMCOREINFO_SYMBOL(log_next_idx);
>>     + VMCOREINFO_SYMBOL(printk_rb_static);
>>     + VMCOREINFO_SYMBOL(printk_rb_dynamic);
>
> I assumed this needs some userspace work in kexec, how did you test
> them?

I did not test any direct userspace access to the ringbuffer structures.

> makedumpfile should need changes to dump the kernel log.
>
> Also kexec-tools includes a vmcore-dmesg.c to extrace dmesg from
> /proc/vmcore.

Thanks for the heads up. I'll take a look at it. The code changes should
be straight forward. I expect there will need to be backwards
compatibility. Perhaps it would check first for "printk_rb_*" then
fallback to "log_*"?

John Ogness
