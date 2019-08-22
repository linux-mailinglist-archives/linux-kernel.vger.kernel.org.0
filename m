Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4164D99418
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 14:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388720AbfHVMo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 08:44:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:42376 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387868AbfHVMo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 08:44:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DB271ACD8;
        Thu, 22 Aug 2019 12:44:26 +0000 (UTC)
Date:   Thu, 22 Aug 2019 14:44:26 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: comments style: Re: [RFC PATCH v4 1/9] printk-rb: add a new
 printk ringbuffer implementation
Message-ID: <20190822124426.3qw2rm6f2xw4m2fy@pathway.suse.cz>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190807222634.1723-2-john.ogness@linutronix.de>
 <20190820085554.deuejmxn4kbqnq7n@pathway.suse.cz>
 <87h86bf50e.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h86bf50e.fsf@linutronix.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2019-08-21 07:42:57, John Ogness wrote:
> On 2019-08-20, Petr Mladek <pmladek@suse.com> wrote:
> >> --- /dev/null
> >> +++ b/kernel/printk/dataring.c
> >> +/**
> >> + * _datablock_valid() - Check if given positions yield a valid data block.
> >> + *
> >> + * @dr:         The associated data ringbuffer.
> >> + *
> >> + * @head_lpos:  The newest data logical position.
> >> + *
> >> + * @tail_lpos:  The oldest data logical position.
> >> + *
> >> + * @begin_lpos: The beginning logical position of the data block to check.
> >> + *
> >> + * @next_lpos:  The logical position of the next adjacent data block.
> >> + *              This value is used to identify the end of the data block.
> >> + *
> >
> > Please remove the empty lines between arguments description. They make
> > the comments too scattered.
> 
> Your feedback is contradicting what PeterZ requested[0]. Particularly
> when multiple lines are involved with a description, I find the spacing
> helpful. I've grown to like the spacing, but I won't fight for it.

I do not want to fight over it. Just note that >90% of argument
descriptors seem to be one liners.

Best Regards,
Petr
