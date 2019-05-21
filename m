Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C593725445
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 17:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbfEUPoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 11:44:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59284 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728323AbfEUPoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 11:44:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 53D0AC05E760;
        Tue, 21 May 2019 15:44:15 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3DA9D17F34;
        Tue, 21 May 2019 15:44:13 +0000 (UTC)
Date:   Tue, 21 May 2019 11:44:11 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Rientjes <rientjes@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 1/4] mm: Check if mmu notifier callbacks are allowed to
 fail
Message-ID: <20190521154411.GD3836@redhat.com>
References: <20190520213945.17046-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190520213945.17046-1-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 21 May 2019 15:44:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 11:39:42PM +0200, Daniel Vetter wrote:
> Just a bit of paranoia, since if we start pushing this deep into
> callchains it's hard to spot all places where an mmu notifier
> implementation might fail when it's not allowed to.
> 
> Inspired by some confusion we had discussing i915 mmu notifiers and
> whether we could use the newly-introduced return value to handle some
> corner cases. Until we realized that these are only for when a task
> has been killed by the oom reaper.
> 
> An alternative approach would be to split the callback into two
> versions, one with the int return value, and the other with void
> return value like in older kernels. But that's a lot more churn for
> fairly little gain I think.
> 
> Summary from the m-l discussion on why we want something at warning
> level: This allows automated tooling in CI to catch bugs without
> humans having to look at everything. If we just upgrade the existing
> pr_info to a pr_warn, then we'll have false positives. And as-is, no
> one will ever spot the problem since it's lost in the massive amounts
> of overall dmesg noise.
> 
> v2: Drop the full WARN_ON backtrace in favour of just a pr_warn for
> the problematic case (Michal Hocko).
> 
> v3: Rebase on top of Glisse's arg rework.
> 
> v4: More rebase on top of Glisse reworking everything.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: "Jérôme Glisse" <jglisse@redhat.com>
> Cc: linux-mm@kvack.org
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Reviewed-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>

Reviewed-by: Jérôme Glisse <jglisse@redhat.com>

> ---
>  mm/mmu_notifier.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
> index ee36068077b6..c05e406a7cd7 100644
> --- a/mm/mmu_notifier.c
> +++ b/mm/mmu_notifier.c
> @@ -181,6 +181,9 @@ int __mmu_notifier_invalidate_range_start(struct mmu_notifier_range *range)
>  				pr_info("%pS callback failed with %d in %sblockable context.\n",
>  					mn->ops->invalidate_range_start, _ret,
>  					!mmu_notifier_range_blockable(range) ? "non-" : "");
> +				if (!mmu_notifier_range_blockable(range))
> +					pr_warn("%pS callback failure not allowed\n",
> +						mn->ops->invalidate_range_start);
>  				ret = _ret;
>  			}
>  		}
> -- 
> 2.20.1
> 
