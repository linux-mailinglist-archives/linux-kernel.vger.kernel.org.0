Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A241A5276
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 11:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730812AbfIBJF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Sep 2019 05:05:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:39448 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730361AbfIBJF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 05:05:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BA11FAC4A;
        Mon,  2 Sep 2019 09:05:25 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C80201E406C; Mon,  2 Sep 2019 10:56:28 +0200 (CEST)
Date:   Mon, 2 Sep 2019 10:56:28 +0200
From:   Jan Kara <jack@suse.cz>
To:     Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [block/for-next] writeback: don't access page->mapping directly
 in track_foreign_dirty TP
Message-ID: <20190902085628.GC14207@quack2.suse.cz>
References: <20190830233954.GC2263813@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830233954.GC2263813@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 30-08-19 16:39:54, Tejun Heo wrote:
> page->mapping may encode different values in it and page_mapping()
> should always be used to access the mapping pointer.
> track_foreign_dirty tracepoint was incorrectly accessing page->mapping
> directly.  Use page_mapping() instead.  Also, add NULL checks while at
> it.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Jan Kara <jack@suse.cz>
> Fixes: 3a8e9ac89e6a ("writeback: add tracepoints for cgroup foreign writebacks")

I can see Jens already picked this up so this is just informative: The patch
now looks good to me.

								Honza

> ---
>  include/trace/events/writeback.h |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
> index 3dc9fb9e7c78..3a27335fce2c 100644
> --- a/include/trace/events/writeback.h
> +++ b/include/trace/events/writeback.h
> @@ -251,9 +251,12 @@ TRACE_EVENT(track_foreign_dirty,
>  	),
>  
>  	TP_fast_assign(
> +		struct address_space *mapping = page_mapping(page);
> +		struct inode *inode = mapping ? mapping->host : NULL;
> +
>  		strncpy(__entry->name,	dev_name(wb->bdi->dev), 32);
>  		__entry->bdi_id		= wb->bdi->id;
> -		__entry->ino		= page->mapping->host->i_ino;
> +		__entry->ino		= inode ? inode->i_ino : 0;
>  		__entry->memcg_id	= wb->memcg_css->id;
>  		__entry->cgroup_ino	= __trace_wb_assign_cgroup(wb);
>  		__entry->page_cgroup_ino = page->mem_cgroup->css.cgroup->kn->id.ino;
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
