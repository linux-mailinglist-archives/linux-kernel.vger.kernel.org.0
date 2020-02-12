Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 117F615AAE9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 15:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbgBLOYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 09:24:49 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49015 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727963AbgBLOYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 09:24:48 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1j1swX-0006Bj-Uq; Wed, 12 Feb 2020 15:24:46 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v1] printk: Declare log_wait as external variable
References: <20200203131528.52825-1-andriy.shevchenko@linux.intel.com>
        <20200211124317.x5erhl7kvxj2nq6a@pathway.suse.cz>
        <20200212013133.GB13208@google.com>
        <20200212140355.56drih2wfcryjjtl@pathway.suse.cz>
Date:   Wed, 12 Feb 2020 15:24:44 +0100
In-Reply-To: <20200212140355.56drih2wfcryjjtl@pathway.suse.cz> (Petr Mladek's
        message of "Wed, 12 Feb 2020 15:03:55 +0100")
Message-ID: <8736bfdgsz.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-12, Petr Mladek <pmladek@suse.com> wrote:
> I would prefer to split it:
>
>     + printk.c is already too big and would deserve splitting.
>
>     + The two different kmgs interfaces are confusing on its
>       own. IMHO, it will be even more confusing when they
>       live in one huge source file.
>
>
>> I can take a look at dev_ksmg.c/proc_kmsg.c option, unless
>> someone else wants to spend their time on this.
>
> It would be lovely from my POV. I am only concerned about
> the lockless printk() stuff. I would prefer to avoid creating
> too many conflicts in the same merge window. Well, I am
> not sure how many conflicts there would be. Adding John
> into CC.

I would also love to see these changes. But can we _please_ focus on the
lockless printk ringbuffer merge first? The patches already exist and
are (hopefully) being reviewed. I would prefer that such a heavy API
replacement is done _before_ we start any massive refactoring.

John Ogness
