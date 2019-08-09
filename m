Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC2458741F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 10:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405819AbfHIIcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 04:32:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:37384 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726059AbfHIIcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 04:32:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8E435AF3F;
        Fri,  9 Aug 2019 08:32:17 +0000 (UTC)
Date:   Fri, 9 Aug 2019 10:32:16 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     kirill.shutemov@linux.intel.com, hannes@cmpxchg.org,
        vbabka@suse.cz, rientjes@google.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 1/2 -mm] mm: account lazy free pages separately
Message-ID: <20190809083216.GM18351@dhcp22.suse.cz>
References: <1565308665-24747-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565308665-24747-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 09-08-19 07:57:44, Yang Shi wrote:
> When doing partial unmap to THP, the pages in the affected range would
> be considered to be reclaimable when memory pressure comes in.  And,
> such pages would be put on deferred split queue and get minus from the
> memory statistics (i.e. /proc/meminfo).
> 
> For example, when doing THP split test, /proc/meminfo would show:
> 
> Before put on lazy free list:
> MemTotal:       45288336 kB
> MemFree:        43281376 kB
> MemAvailable:   43254048 kB
> ...
> Active(anon):    1096296 kB
> Inactive(anon):     8372 kB
> ...
> AnonPages:       1096264 kB
> ...
> AnonHugePages:   1056768 kB
> 
> After put on lazy free list:
> MemTotal:       45288336 kB
> MemFree:        43282612 kB
> MemAvailable:   43255284 kB
> ...
> Active(anon):    1094228 kB
> Inactive(anon):     8372 kB
> ...
> AnonPages:         49668 kB
> ...
> AnonHugePages:     10240 kB
> 
> The THPs confusingly look disappeared although they are still on LRU if
> you are not familair the tricks done by kernel.

Is this a fallout of the recent deferred freeing work?

> Accounted the lazy free pages to NR_LAZYFREE, and show them in meminfo
> and other places.  With the change the /proc/meminfo would look like:
> Before put on lazy free list:

The name is really confusing because I have thought of MADV_FREE immediately.

> +LazyFreePages: Cleanly freeable pages under memory pressure (i.e. deferred
> +               split THP).

What does that mean actually? I have hard time imagine what cleanly
freeable pages mean.
-- 
Michal Hocko
SUSE Labs
