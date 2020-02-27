Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50313172297
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 16:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbgB0PxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 10:53:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34680 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729110AbgB0PxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 10:53:18 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j7LTB-0000G5-Ed; Thu, 27 Feb 2020 16:53:01 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 27C2C1040A9; Thu, 27 Feb 2020 16:53:00 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 5/8] x86/entry/common: Provide trace/kprobe safe exit to user space functions
In-Reply-To: <71271e39-1dbd-0bd6-2435-fc8a30f47b7d@oracle.com>
References: <20200225220801.571835584@linutronix.de> <20200225221305.719921962@linutronix.de> <71271e39-1dbd-0bd6-2435-fc8a30f47b7d@oracle.com>
Date:   Thu, 27 Feb 2020 16:53:00 +0100
Message-ID: <87h7zcm3hf.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexandre Chartre <alexandre.chartre@oracle.com> writes:

> On 2/25/20 11:08 PM, Thomas Gleixner wrote:
>> Split prepare_enter_to_user_mode() and mark it notrace/noprobe so the irq
>> flags tracing on return can be put into it.
>
> This splits prepare_exit_to_usermode() not prepare_enter_to_user_mode().

Ooops

>>   /* Called with IRQs disabled. */
>> -__visible inline void prepare_exit_to_usermode(struct pt_regs *regs)
>> +static inline void __prepare_exit_to_usermode(struct pt_regs *regs)
>>   {
>>   	struct thread_info *ti = current_thread_info();
>>   	u32 cached_flags;
>> @@ -241,6 +241,12 @@ static void exit_to_usermode_loop(struct
>>   	mds_user_clear_cpu_buffers();
>>   }
>>   
>> +__visible inline notrace void prepare_exit_to_usermode(struct pt_regs *regs)
>> +{
>> +	__prepare_exit_to_usermode(regs);
>> +}
>> +NOKPROBE_SYMBOL(prepare_exit_to_usermode);
>
>
> Would it be worth grouping local_irq_disable() and prepare_exit_to_usermode()
> (similarly to what was done entry with syscall_entry_fixups()) and then put
> trace_hardirqs_on() there too. For example:
>
> static __always_inline void syscall_exit_fixups(struct pt_regs *regs)
> {
>          local_irq_disable();
>          prepare_exit_to_usermode(regs);
>          trace_hardirqs_on();
> }
>
> Or is this planned once prepare_exit_from_usermode() is not used by idtentry
> anymore?

This should be consolidated at the very end when all the interrupt muck
is done, but maybe I forgot.
