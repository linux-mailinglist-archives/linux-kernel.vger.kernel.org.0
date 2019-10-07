Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B073CE081
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 13:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfJGLdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 07:33:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:45764 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727467AbfJGLdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:33:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4BCF5ABD9;
        Mon,  7 Oct 2019 11:33:02 +0000 (UTC)
Date:   Mon, 7 Oct 2019 13:33:01 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org,
        sergey.senozhatsky.work@gmail.com, rostedt@goodmis.org,
        peterz@infradead.org, david@redhat.com, john.ogness@linutronix.de,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
Message-ID: <20191007113301.GG2381@dhcp22.suse.cz>
References: <1570228005-24979-1-git-send-email-cai@lca.pw>
 <20191007080742.GD2381@dhcp22.suse.cz>
 <20191007090553.g5cq7qa4tj5yrtaa@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007090553.g5cq7qa4tj5yrtaa@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 07-10-19 11:05:53, Petr Mladek wrote:
> On Mon 2019-10-07 10:07:42, Michal Hocko wrote:
> > On Fri 04-10-19 18:26:45, Qian Cai wrote:
> > > It is unsafe to call printk() while zone->lock was held, i.e.,
> > > 
> > > zone->lock --> console_lock
> > > 
> > > because the console could always allocate some memory in different code
> > > paths and form locking chains in an opposite order,
> > > 
> > > console_lock --> * --> zone->lock
> > > 
> > > As the result, it triggers lockdep splats like below and in different
> > > code paths in this thread [1]. Since has_unmovable_pages() was only used
> > > in set_migratetype_isolate() and is_pageblock_removable_nolock(). Only
> > > the former will set the REPORT_FAILURE flag which will call printk().
> > > Hence, unlock the zone->lock just before the dump_page() there where
> > > when has_unmovable_pages() returns true, there is no need to hold the
> > > lock anyway in the rest of set_migratetype_isolate().
> > > 
> > > While at it, remove a problematic printk() in __offline_isolated_pages()
> > > only for debugging as well which will always disable lockdep on debug
> > > kernels.
> > 
> > I do not think that removing the printk is the right long term solution.
> > While I do agree that removing the debugging printk __offline_isolated_pages
> > does make sense because it is essentially of a very limited use, this
> > doesn't really solve the underlying problem.  There are likely other
> > printks from zone->lock. It would be much more saner to actually
> > disallow consoles to allocate any memory while printk is called from an
> > atomic context.
> 
> The current "standard" solution for these situations is to replace
> the problematic printk() with printk_deferred(). It would deffer
> the console handling.
> 
> Of course, this is a whack a mole approach. The long term solution
> is to deffer printk() by default. We have finally agreed on this
> few weeks ago on Plumbers conference. It is going to be added
> together with fully lockless log buffer hopefully soon. It will
> be part of upstreaming Real-Time related code.

OK, then we do not really have to do anything here. That is good to hear
because I really detest putting printk_deferred or anything like
that at random places.
-- 
Michal Hocko
SUSE Labs
