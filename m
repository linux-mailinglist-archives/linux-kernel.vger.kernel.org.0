Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E84FDCF41F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 09:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730404AbfJHHoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 03:44:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:39908 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730222AbfJHHn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 03:43:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0DF5FAB98;
        Tue,  8 Oct 2019 07:43:58 +0000 (UTC)
Date:   Tue, 8 Oct 2019 09:43:57 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org,
        sergey.senozhatsky.work@gmail.com, rostedt@goodmis.org,
        peterz@infradead.org, linux-mm@kvack.org,
        john.ogness@linutronix.de, david@redhat.com,
        linux-kernel@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
Message-ID: <20191008074357.f33f6pbs4cw5majk@pathway.suse.cz>
References: <1570228005-24979-1-git-send-email-cai@lca.pw>
 <20191007143002.l37bt2lzqtnqjqxu@pathway.suse.cz>
 <20191007144937.GO2381@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007144937.GO2381@dhcp22.suse.cz>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-10-07 16:49:37, Michal Hocko wrote:
> [Cc s390 maintainers - the lockdep is http://lkml.kernel.org/r/1570228005-24979-1-git-send-email-cai@lca.pw
>  Petr has explained it is a false positive
>  http://lkml.kernel.org/r/20191007143002.l37bt2lzqtnqjqxu@pathway.suse.cz]
> On Mon 07-10-19 16:30:02, Petr Mladek wrote:
> [...]
> > I believe that it cannot really happen because:
> > 
> > 	static int __init
> > 	sclp_console_init(void)
> > 	{
> > 	[...]
> > 		rc = sclp_rw_init();
> > 	[...]
> > 		register_console(&sclp_console);
> > 		return 0;
> > 	}
> > 
> > sclp_rw_init() is called before register_console(). And
> > console_unlock() will never call sclp_console_write() before
> > the console is registered.
> > 
> > AFAIK, lockdep only compares existing chain of locks. It does
> > not know about console registration that would make some
> > code paths mutually exclusive.
> > 
> > I believe that it is a false positive. I do not know how to
> > avoid this lockdep report. I hope that it will disappear
> > by deferring all printk() calls rather soon.
> 
> Thanks a lot for looking into this Petr. I have also checked the code
> and I really fail to see why the allocation has to be done under the
> lock in the first place. sclp_read_sccb and sclp_init_sccb are global
> variables but I strongly suspect that they need a synchronization during
> early init, callbacks are registered only later IIUC:

Good idea. It would work when the init function is called only once.
But see below.

> diff --git a/drivers/s390/char/sclp.c b/drivers/s390/char/sclp.c
> index d2ab3f07c008..4b1c033e3255 100644
> --- a/drivers/s390/char/sclp.c
> +++ b/drivers/s390/char/sclp.c
> @@ -1169,13 +1169,13 @@ sclp_init(void)
>  	unsigned long flags;
>  	int rc = 0;
>  
> +	sclp_read_sccb = (void *) __get_free_page(GFP_ATOMIC | GFP_DMA);
> +	sclp_init_sccb = (void *) __get_free_page(GFP_ATOMIC | GFP_DMA);
>  	spin_lock_irqsave(&sclp_lock, flags);
>  	/* Check for previous or running initialization */
>  	if (sclp_init_state != sclp_init_state_uninitialized)
>  		goto fail_unlock;

It seems that sclp_init() could be called several times in parallel.
I see it called from sclp_register() and sclp_initcall().

I am not sure if it is really needed or if it is just a strange
desing.

It might be still possible to always do the allocation without the lock
and free the memory when it is not really used. But I am not sure
if we want to do this exercise just to avoid lockdep false positive.

Best Regards,
Petr
