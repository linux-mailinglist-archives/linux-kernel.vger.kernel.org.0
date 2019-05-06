Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77CEC145F8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2019 10:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfEFIUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 04:20:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:58746 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726197AbfEFIUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 04:20:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 900D3AEE8;
        Mon,  6 May 2019 08:20:20 +0000 (UTC)
Date:   Mon, 6 May 2019 10:20:20 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RFC: console: hack up console_lock more v2
Message-ID: <20190506082020.zobcuhiy6bkdekv3@pathway.suse.cz>
References: <20190502141643.21080-1-daniel.vetter@ffwll.ch>
 <20190506074553.21464-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506074553.21464-1-daniel.vetter@ffwll.ch>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-05-06 09:45:53, Daniel Vetter wrote:
> console_trylock, called from within printk, can be called from pretty
> much anywhere. Including try_to_wake_up. Note that this isn't common,
> usually the box is in pretty bad shape at that point already. But it
> really doesn't help when then lockdep jumps in and spams the logs,
> potentially obscuring the real backtrace we're really interested in.
> One case I've seen (slightly simplified backtrace):
> 
>  Call Trace:
>   <IRQ>
>   console_trylock+0xe/0x60
>   vprintk_emit+0xf1/0x320
>   printk+0x4d/0x69
>   __warn_printk+0x46/0x90
>   native_smp_send_reschedule+0x2f/0x40
>   check_preempt_curr+0x81/0xa0
>   ttwu_do_wakeup+0x14/0x220
>   try_to_wake_up+0x218/0x5f0

try_to_wake_up() takes p->pi_lock. It could deadlock because it
can get called recursively from printk_safe_up().

And there are more locks taken from try_to_wake_up(), for example,
__task_rq_lock() taken from ttwu_remote().

IMHO, the most reliable solution would be do call the entire
up_console_sem() from printk deferred context. We could assign
few bytes for this context in the per-CPU printk_deferred
variable.

Best Regards,
Petr
