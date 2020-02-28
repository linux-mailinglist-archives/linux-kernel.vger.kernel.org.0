Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8D31738DD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 14:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgB1Nt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 08:49:58 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36773 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgB1Nt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 08:49:58 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j7g1J-00089K-6p; Fri, 28 Feb 2020 14:49:37 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id E3351104097; Fri, 28 Feb 2020 14:49:36 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 8/8] x86/entry: Move irqflags tracing to do_int80_syscall_32()
In-Reply-To: <fee191b3-bcce-3a72-92ab-6c15992d3ece@oracle.com>
References: <20200225220801.571835584@linutronix.de> <20200225221306.026841950@linutronix.de> <fee191b3-bcce-3a72-92ab-6c15992d3ece@oracle.com>
Date:   Fri, 28 Feb 2020 14:49:36 +0100
Message-ID: <875zfqhle7.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexandre Chartre <alexandre.chartre@oracle.com> writes:
> On 2/25/20 11:08 PM, Thomas Gleixner wrote:
>> which cleans up the ASM maze.
>> 
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> ---
>>   arch/x86/entry/common.c          |    8 +++++++-
>>   arch/x86/entry/entry_32.S        |    9 ++-------
>>   arch/x86/entry/entry_64_compat.S |   14 +++++---------
>>   3 files changed, 14 insertions(+), 17 deletions(-)
>> 
>> --- a/arch/x86/entry/common.c
>> +++ b/arch/x86/entry/common.c
>> @@ -333,6 +333,7 @@ void do_syscall_64_irqs_on(unsigned long
>>   {
>>   	syscall_entry_fixups();
>>   	do_syscall_64_irqs_on(nr, regs);
>> +	trace_hardirqs_on();
>>   }
>
> trace_hardirqs_on() is already called through syscall_return_slowpath()
> (from the previous patch):
>
> do_syscall_64()
>    -> do_syscall_64_irqs_on()
>      -> syscall_return_slowpath()
>        -> trace_hardirqs_on()

Duh, indeed.
