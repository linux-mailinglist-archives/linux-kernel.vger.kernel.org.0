Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 226441369F6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 10:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbgAJJXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 04:23:00 -0500
Received: from outbound-smtp36.blacknight.com ([46.22.139.219]:45491 "EHLO
        outbound-smtp36.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727170AbgAJJXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 04:23:00 -0500
Received: from mail.blacknight.com (unknown [81.17.254.11])
        by outbound-smtp36.blacknight.com (Postfix) with ESMTPS id C8F6A132D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 09:22:58 +0000 (GMT)
Received: (qmail 15952 invoked from network); 10 Jan 2020 09:22:58 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 10 Jan 2020 09:22:58 -0000
Date:   Fri, 10 Jan 2020 09:22:56 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org
Subject: Re: [PATCH] mm: avoid blocking lock_page() in kcompactd
Message-ID: <20200110092256.GN3466@techsingularity.net>
References: <20200109225646.22983-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200109225646.22983-1-xiyou.wangcong@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 02:56:46PM -0800, Cong Wang wrote:
> We observed kcompactd hung at __lock_page():
> 
>  INFO: task kcompactd0:57 blocked for more than 120 seconds.
>        Not tainted 4.19.56.x86_64 #1
>  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>  kcompactd0      D    0    57      2 0x80000000
>  Call Trace:
>   ? __schedule+0x236/0x860
>   schedule+0x28/0x80
>   io_schedule+0x12/0x40
>   __lock_page+0xf9/0x120
>   ? page_cache_tree_insert+0xb0/0xb0
>   ? update_pageblock_skip+0xb0/0xb0
>   migrate_pages+0x88c/0xb90
>   ? isolate_freepages_block+0x3b0/0x3b0
>   compact_zone+0x5f1/0x870
>   kcompactd_do_work+0x130/0x2c0
>   ? __switch_to_asm+0x35/0x70
>   ? __switch_to_asm+0x41/0x70
>   ? kcompactd_do_work+0x2c0/0x2c0
>   ? kcompactd+0x73/0x180
>   kcompactd+0x73/0x180
>   ? finish_wait+0x80/0x80
>   kthread+0x113/0x130
>   ? kthread_create_worker_on_cpu+0x50/0x50
>   ret_from_fork+0x35/0x40
> 
> which faddr2line maps to:
> 
>   migrate_pages+0x88c/0xb90:
>   lock_page at include/linux/pagemap.h:483
>   (inlined by) __unmap_and_move at mm/migrate.c:1024
>   (inlined by) unmap_and_move at mm/migrate.c:1189
>   (inlined by) migrate_pages at mm/migrate.c:1419
> 
> Sometimes kcompactd eventually got out of this situation, sometimes not.
> 
> I think for memory compaction, it is a best effort to migrate the pages,
> so it doesn't have to wait for I/O to complete. It is fine to call
> trylock_page() here, which is pretty much similar to
> buffer_migrate_lock_buffers().
> 
> Given MIGRATE_SYNC_LIGHT is used on compaction path, just relax the
> check for it.
> 

Is this a single page being locked for a long time or multiple pages
being locked without reaching a reschedule point?

If it's a single page being locked, it's important to identify what held
page lock for 2 minutes because that is potentially a missing
unlock_page. The kernel in question is old -- 4.19.56. Are there any
other modifications to that kernel?

-- 
Mel Gorman
SUSE Labs
