Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB1811696A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2019 10:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbfLIJfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 04:35:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38054 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbfLIJfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 04:35:19 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1ieFRV-0005eV-BF; Mon, 09 Dec 2019 10:35:01 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        kexec@lists.infradead.org
Subject: Re: [RFC PATCH v5 1/3] printk-rb: new printk ringbuffer implementation (writer)
References: <20191128015235.12940-1-john.ogness@linutronix.de>
        <20191128015235.12940-2-john.ogness@linutronix.de>
        <20191209092756.GH88619@google.com>
Date:   Mon, 09 Dec 2019 10:34:59 +0100
In-Reply-To: <20191209092756.GH88619@google.com> (Sergey Senozhatsky's message
        of "Mon, 9 Dec 2019 18:27:56 +0900")
Message-ID: <87muc1zvss.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-09, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
>> + * Sample reader code::
>> + *
>> + *	struct printk_info info;
>> + *	char text_buf[32];
>> + *	char dict_buf[32];
>> + *	u64 next_seq = 0;
>> + *	struct printk_record r = {
>> + *		.info		= &info,
>> + *		.text_buf	= &text_buf[0],
>> + *		.dict_buf	= &dict_buf[0],
>> + *		.text_buf_size	= sizeof(text_buf),
>> + *		.dict_buf_size	= sizeof(dict_buf),
>> + *	};
>> + *
>> + *	while (prb_read_valid(&rb, next_seq, &r)) {
>> + *		if (info.seq != next_seq)
>> + *			pr_warn("lost %llu records\n", info.seq - next_seq);
>> + *
>> + *		if (info.text_len > r.text_buf_size) {
>> + *			pr_warn("record %llu text truncated\n", info.seq);
>> + *			text_buf[sizeof(text_buf) - 1] = 0;
>> + *		}
>> + *
>> + *		if (info.dict_len > r.dict_buf_size) {
>> + *			pr_warn("record %llu dict truncated\n", info.seq);
>> + *			dict_buf[sizeof(dict_buf) - 1] = 0;
>> + *		}
>> + *
>> + *		pr_info("%llu: %llu: %s;%s\n", info.seq, info.ts_nsec,
>> + *			&text_buf[0], info.dict_len ? &dict_buf[0] : "");
>> + *
>> + *		next_seq = info.seq + 1;
>> + *	}
>> + */
>
> Will this loop ever end? :)
>
> pr_info() adds data to ringbuffer, which prb_read_valid() reads, so
> pr_info() can add more data, which prb_read_valid() will read, so
> pr_info()...

The sample code is assuming that @rb is not the same ringbuffer used by
kernel/printk/printk.c. (For example, the test module is doing that to
stress test the ringbuffer code without actually affecting printk.) I
can add a sentence to clarify that.

John Ogness
