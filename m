Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 452F5CE6F8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 17:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbfJGPMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 11:12:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:42570 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727835AbfJGPMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 11:12:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 38C55AC26;
        Mon,  7 Oct 2019 15:12:38 +0000 (UTC)
Date:   Mon, 7 Oct 2019 17:12:37 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Petr Mladek <pmladek@suse.com>, akpm@linux-foundation.org,
        sergey.senozhatsky.work@gmail.com, rostedt@goodmis.org,
        peterz@infradead.org, linux-mm@kvack.org,
        john.ogness@linutronix.de, david@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
Message-ID: <20191007151237.GP2381@dhcp22.suse.cz>
References: <1570228005-24979-1-git-send-email-cai@lca.pw>
 <20191007143002.l37bt2lzqtnqjqxu@pathway.suse.cz>
 <1570460350.5576.290.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1570460350.5576.290.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 07-10-19 10:59:10, Qian Cai wrote:
[...]
> It is almost impossible to eliminate all the indirect call chains from
> console_sem/console_owner_lock to zone->lock because it is too normal that
> something later needs to allocate some memory dynamically, so as long as it
> directly call printk() with zone->lock held, it will be in trouble.

Do you have any example where the console driver really _has_ to
allocate. Because I have hard time to believe this is going to work at
all as the atomic context doesn't allow to do any memory reclaim and
such an allocation would be too easy to fail so the allocation cannot
really rely on it.

So again, crippling the MM code just because of lockdep false possitives
or a broken console driver sounds like a wrong way to approach the
problem.

> [  297.425964] -> #1 (&port_lock_key){-.-.}:
> [  297.425967]        __lock_acquire+0x5b3/0xb40
> [  297.425967]        lock_acquire+0x126/0x280
> [  297.425968]        _raw_spin_lock_irqsave+0x3a/0x50
> [  297.425969]        serial8250_console_write+0x3e4/0x450
> [  297.425970]        univ8250_console_write+0x4b/0x60
> [  297.425970]        console_unlock+0x501/0x750
> [  297.425971]        vprintk_emit+0x10d/0x340
> [  297.425972]        vprintk_default+0x1f/0x30
> [  297.425972]        vprintk_func+0x44/0xd4
> [  297.425973]        printk+0x9f/0xc5
> [  297.425974]        register_console+0x39c/0x520
> [  297.425975]        univ8250_console_init+0x23/0x2d
> [  297.425975]        console_init+0x338/0x4cd
> [  297.425976]        start_kernel+0x534/0x724
> [  297.425977]        x86_64_start_reservations+0x24/0x26
> [  297.425977]        x86_64_start_kernel+0xf4/0xfb
> [  297.425978]        secondary_startup_64+0xb6/0xc0

This is an early init code again so the lockdep sounds like a false
possitive to me.
-- 
Michal Hocko
SUSE Labs
