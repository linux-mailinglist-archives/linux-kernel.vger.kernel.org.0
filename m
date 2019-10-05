Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76074CCD4B
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2019 01:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbfJEX3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Oct 2019 19:29:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:58642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbfJEX3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 19:29:44 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85930222C0;
        Sat,  5 Oct 2019 23:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570318183;
        bh=a6XM1Yn2qKqpclLE3O6pWGTOswkBysO7P8yFEqrXrSE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QxIakgB8lssbg3woZR4Pj+XaSbqv+RA0jEPO2ajsCu0y9obT4Pck0JHOi5JQh2NKD
         huhHPQnW9C9Ur40INZX1cmppJQuDyclASwTA2p7LqMuroXo5hR5Y7y5GRw/inMUivm
         YFkBLILCmJRr8X3H8sOcBQ0PtV+z8kO9CeTHycEw=
Date:   Sat, 5 Oct 2019 16:29:42 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Qian Cai <cai@lca.pw>
Cc:     mhocko@kernel.org, sergey.senozhatsky.work@gmail.com,
        pmladek@suse.com, rostedt@goodmis.org, peterz@infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_isolation: fix a deadlock with printk()
Message-Id: <20191005162942.b392b9336b860e245106faa2@linux-foundation.org>
In-Reply-To: <1570207346-30477-1-git-send-email-cai@lca.pw>
References: <1570207346-30477-1-git-send-email-cai@lca.pw>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  4 Oct 2019 12:42:26 -0400 Qian Cai <cai@lca.pw> wrote:

> It is unsafe to call printk() while zone->lock was held, i.e.,
> 
> zone->lock --> console_sem
> 
> because the console could always allocate some memory in different code
> paths and form locking chains in an opposite order,
> 
> console_sem --> * --> zone->lock
> 
> As the result, it triggers lockdep splats like below and in [1]. It is
> fine to take zone->lock after has_unmovable_pages() (which has
> dump_stack()) in set_migratetype_isolate(). While at it, remove a
> problematic printk() in __offline_isolated_pages() only for debugging as
> well which will always disable lockdep on debug kernels.
> 
> The problem is probably there forever, but neither many developers will
> run memory offline with the lockdep enabled nor admins in the field are
> lucky enough yet to hit a perfect timing which required to trigger a
> real deadlock. In addition, there aren't many places that call printk()
> while zone->lock was held.
> 
> WARNING: possible circular locking dependency detected
> ------------------------------------------------------
> test.sh/1724 is trying to acquire lock:
> 0000000052059ec0 (console_owner){-...}, at: console_unlock+0x
> 01: 328/0xa30
> 
> but task is already holding lock:
> 000000006ffd89c8 (&(&zone->lock)->rlock){-.-.}, at: start_iso
> 01: late_page_range+0x216/0x538
> 
> which lock already depends on the new lock.
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #2 (&(&zone->lock)->rlock){-.-.}:
>        lock_acquire+0x21a/0x468
>        _raw_spin_lock+0x54/0x68
>        get_page_from_freelist+0x8b6/0x2d28
>        __alloc_pages_nodemask+0x246/0x658
>        __get_free_pages+0x34/0x78
>        sclp_init+0x106/0x690
>        sclp_register+0x2e/0x248
>        sclp_rw_init+0x4a/0x70
>        sclp_console_init+0x4a/0x1b8
>        console_init+0x2c8/0x410
>        start_kernel+0x530/0x6a0
>        startup_continue+0x70/0xd0

This appears to be the core of our problem?  At initialization time,
the sclp driver registers an inappropriate dependency with lockdep.  It
does this by calling into the page allocator while holding sclp_lock. 
But we don't *want* to teach lockdep that sclp_lock nests outside
zone->lock.  We want the opposite.

So can we address this class of problem by declaring "thou shalt not
call the page allocator while holding a lock which can be taken on the
prink path?".  And then declare sclp to be defective.


And I think sclp is kinda buggy-but-lucky anyway: if console output is
directed to sclp device #0 and we're then trying to initialize sclp
device #1 then any printk which happens during that initialization will
deadlock.  The driver escapes this by only supporting a single device
system-wide but it's not a model which drivers should generally follow.

(And if sclp will only ever support a single device system-wide, why
the heck does it need to take sclp_lock() on the device initialization
path??)


