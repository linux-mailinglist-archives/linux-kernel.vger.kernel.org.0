Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5353B4B6EA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 13:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731565AbfFSLUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 07:20:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:33702 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727076AbfFSLUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 07:20:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 649E0B002;
        Wed, 19 Jun 2019 11:20:04 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BC8081E15DD; Wed, 19 Jun 2019 13:20:03 +0200 (CEST)
Date:   Wed, 19 Jun 2019 13:20:03 +0200
From:   Jan Kara <jack@suse.cz>
To:     Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, jbacik@fb.com, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, kernel-team@fb.com, dennis@kernel.org,
        jack@suse.cz
Subject: Re: [PATCH 5/5] blkcg, writeback: dead memcgs shouldn't contribute
 to writeback ownership arbitration
Message-ID: <20190619112003.GD27954@quack2.suse.cz>
References: <20190613223041.606735-1-tj@kernel.org>
 <20190613223041.606735-6-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613223041.606735-6-tj@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 13-06-19 15:30:41, Tejun Heo wrote:
> wbc_account_io() collects information on cgroup ownership of writeback
> pages to determine which cgroup should own the inode.  Pages can stay
> associated with dead memcgs but we want to avoid attributing IOs to
> dead blkcgs as much as possible as the association is likely to be
> stale.  However, currently, pages associated with dead memcgs
> contribute to the accounting delaying and/or confusing the
> arbitration.
> 
> Fix it by ignoring pages associated with dead memcgs.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Jan Kara <jack@suse.cz>

I see Jens has already pulled the changes so this is mostly informative but
the patch looks good to me.

								Honza
> ---
>  fs/fs-writeback.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index e41cbe8e81b9..9ebfb1b28430 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -715,6 +715,7 @@ void wbc_detach_inode(struct writeback_control *wbc)
>  void wbc_account_io(struct writeback_control *wbc, struct page *page,
>  		    size_t bytes)
>  {
> +	struct cgroup_subsys_state *css;
>  	int id;
>  
>  	/*
> @@ -726,7 +727,12 @@ void wbc_account_io(struct writeback_control *wbc, struct page *page,
>  	if (!wbc->wb)
>  		return;
>  
> -	id = mem_cgroup_css_from_page(page)->id;
> +	css = mem_cgroup_css_from_page(page);
> +	/* dead cgroups shouldn't contribute to inode ownership arbitration */
> +	if (!(css->flags & CSS_ONLINE))
> +		return;
> +
> +	id = css->id;
>  
>  	if (id == wbc->wb_id) {
>  		wbc->wb_bytes += bytes;
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
