Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADEF763732
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 15:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfGINps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 09:45:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54794 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfGINps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 09:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nZgy+BqTOIJcy5TYK73FngoSKvFB8Vl2NL5heGDPFZ0=; b=VoB4E+NLP8Zw1Wncbb5g7l3dm
        Z5zyGW5ZfgY7bwlPzA6af9a50zladxhORhX1WZ+g4HISfOcrmBTznGZMcAmBeWTaKDFVDapbDa9v+
        qtEjJ2saH3h8aaWWzezwgJHKSwpvce5hCPHCazlYIqdlqopBiqJcntaHLjrfdmDEY1G68q/+jU7g5
        lyqxH8vaeabC5nXFAcg164XCh9PbZelPsbqlBB06WIwFgiawed7+Z6ZWbc8AdlcwxagmQEuiAdiJZ
        evVAwsW/RE7q/CJ9Y5sQIx5t01QxCp90nVcBu5Ei5BUk++prXdC/aaxyQj8nTvhBGnlMvBmz2vORj
        Be58gfdTQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hkqRE-0005sg-6F; Tue, 09 Jul 2019 13:45:44 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7A08620976D60; Tue,  9 Jul 2019 15:45:42 +0200 (CEST)
Date:   Tue, 9 Jul 2019 15:45:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yuyang Du <duyuyang@gmail.com>
Cc:     will.deacon@arm.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, frederic@kernel.org, arnd@arndb.de,
        cai@lca.pw
Subject: Re: [PATCH] locking/lockdep: Fix lock used or unused stats error
Message-ID: <20190709134542.GE3402@hirez.programming.kicks-ass.net>
References: <20190709101522.9117-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709101522.9117-1-duyuyang@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 06:15:22PM +0800, Yuyang Du wrote:
> The stats variable nr_unused_locks is incremented every time a new lock
> class is register and decremented when the lock is first used in
> __lock_acquire(). And after all, it is shown and checked in lockdep_stats.
> 
> However, under configurations that either CONFIG_TRACE_IRQFLAGS or
> CONFIG_PROVE_LOCKING is not defined:
> 
> The commit:
> 
>   091806515124b20 ("locking/lockdep: Consolidate lock usage bit initialization")
> 
> missed marking the LOCK_USED flag at IRQ usage initialization because
> as mark_usage() is not called. And the commit:
> 
>   886532aee3cd42d ("locking/lockdep: Move mark_lock() inside
> CONFIG_TRACE_IRQFLAGS && CONFIG_PROVE_LOCKING")
> 
> further made mark_lock() not defined such that the LOCK_USED cannot be
> marked at all when the lock is first acquired.
> 
> As a result, we fix this by not showing and checking the stats under such
> configurations for lockdep_stats.
> 
> Reported-by: Qian Cai <cai@lca.pw>
> Signed-off-by: Yuyang Du <duyuyang@gmail.com>

Thanks!
