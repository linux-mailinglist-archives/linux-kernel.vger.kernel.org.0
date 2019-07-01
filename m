Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2B5253F1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 17:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbfEUPcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 11:32:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60358 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728137AbfEUPcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 11:32:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 18E00883D7;
        Tue, 21 May 2019 15:32:05 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1505C5378A;
        Tue, 21 May 2019 15:32:02 +0000 (UTC)
Date:   Tue, 21 May 2019 11:32:00 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 3/4] mm, notifier: Catch sleeping/blocking for !blockable
Message-ID: <20190521153200.GB3836@redhat.com>
References: <20190520213945.17046-1-daniel.vetter@ffwll.ch>
 <20190520213945.17046-3-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190520213945.17046-3-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 21 May 2019 15:32:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 11:39:44PM +0200, Daniel Vetter wrote:
> We need to make sure implementations don't cheat and don't have a
> possible schedule/blocking point deeply burried where review can't
> catch it.
> 
> I'm not sure whether this is the best way to make sure all the
> might_sleep() callsites trigger, and it's a bit ugly in the code flow.
> But it gets the job done.
> 
> Inspired by an i915 patch series which did exactly that, because the
> rules haven't been entirely clear to us.
> 
> v2: Use the shiny new non_block_start/end annotations instead of
> abusing preempt_disable/enable.
> 
> v3: Rebase on top of Glisse's arg rework.
> 
> v4: Rebase on top of more Glisse rework.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: "Christian K�nig" <christian.koenig@amd.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: "J�r�me Glisse" <jglisse@redhat.com>
> Cc: linux-mm@kvack.org
> Reviewed-by: Christian K�nig <christian.koenig@amd.com>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> ---
>  mm/mmu_notifier.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
> index c05e406a7cd7..a09e737711d5 100644
> --- a/mm/mmu_notifier.c
> +++ b/mm/mmu_notifier.c
> @@ -176,7 +176,13 @@ int __mmu_notifier_invalidate_range_start(struct mmu_notifier_range *range)
>  	id = srcu_read_lock(&srcu);
>  	hlist_for_each_entry_rcu(mn, &range->mm->mmu_notifier_mm->list, hlist) {
>  		if (mn->ops->invalidate_range_start) {
> -			int _ret = mn->ops->invalidate_range_start(mn, range);
> +			int _ret;
> +
> +			if (!mmu_notifier_range_blockable(range))
> +				non_block_start();
> +			_ret = mn->ops->invalidate_range_start(mn, range);
> +			if (!mmu_notifier_range_blockable(range))
> +				non_block_end();

This is a taste thing so feel free to ignore it as maybe other
will dislike more what i prefer:

+			if (!mmu_notifier_range_blockable(range)) {
+				non_block_start();
+				_ret = mn->ops->invalidate_range_start(mn, range);
+				non_block_end();
+			} else
+				_ret = mn->ops->invalidate_range_start(mn, range);

If only we had predicate on CPU like on GPU :)

In any case:

Reviewed-by: J�r�me Glisse <jglisse@redhat.com>


>  			if (_ret) {
>  				pr_info("%pS callback failed with %d in %sblockable context.\n",
>  					mn->ops->invalidate_range_start, _ret,
> -- 
> 2.20.1
> 
