Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3221A155327
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Feb 2020 08:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgBGHnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Feb 2020 02:43:47 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39155 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgBGHnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 02:43:46 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1izyIf-00071r-RG; Fri, 07 Feb 2020 08:43:41 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        lijiang <lijiang@redhat.com>, Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] printk: replace ringbuffer
References: <20200128161948.8524-1-john.ogness@linutronix.de>
        <dc4ca9b5-d2a2-03af-c186-204a3aad2399@redhat.com>
        <20200205044848.GH41358@google.com>
        <20200205050204.GI41358@google.com>
        <88827ae2-7af5-347b-29fb-cffb94350f8f@redhat.com>
        <20200205063640.GJ41358@google.com> <877e11h0ir.fsf@linutronix.de>
        <20200205110522.GA456@jagdpanzerIV.localdomain>
        <87wo919grz.fsf@linutronix.de>
        <20200206204012.0cbfc941@oasis.local.home>
Date:   Fri, 07 Feb 2020 08:43:39 +0100
In-Reply-To: <20200206204012.0cbfc941@oasis.local.home> (Steven Rostedt's
        message of "Thu, 6 Feb 2020 20:40:12 -0500")
Message-ID: <87k14yx2ok.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-07, Steven Rostedt <rostedt@goodmis.org> wrote:
>> The quick fixup:
>> 
>> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>> index d0d24ee1d1f4..5ad67ff60cd9 100644
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -883,6 +883,7 @@ static int devkmsg_open(struct inode *inode, struct file *file)
>>  	user->record.text_buf_size = sizeof(user->text_buf);
>>  	user->record.dict_buf = &user->dict_buf[0];
>>  	user->record.dict_buf_size = sizeof(user->dict_buf);
>> +	user->record.text_line_count = NULL;
>>  
>>  	logbuf_lock_irq();
>>  	user->seq = prb_first_seq(prb);
>
> FYI, I used your patch set to test out Konstantin's new get-lore-mbox
> script, and then applied them. It locked up on boot up as well, and
> applying this appears to fix it.

Yes, this is a horrible bug. In preparation for my v2 I implemented:

    prb_rec_init_rd()
    prb_rec_init_wr()

as static inline functions to initialize the records. There is a reader
and writer variant because they initialize the records differently:
readers provide buffers, writers request buffers. This eliminates the
manual twiddling with the record struct and ensures that the struct is
always properly initialized.

John Ogness
