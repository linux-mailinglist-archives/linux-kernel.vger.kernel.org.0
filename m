Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A19ACA3A8B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 17:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbfH3PkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 11:40:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:45286 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727434AbfH3PkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 11:40:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2D789AEF5;
        Fri, 30 Aug 2019 15:40:24 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B91411E43A8; Fri, 30 Aug 2019 17:40:23 +0200 (CEST)
Date:   Fri, 30 Aug 2019 17:40:23 +0200
From:   Jan Kara <jack@suse.cz>
To:     Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH block/for-next] writeback: add tracepoints for cgroup
 foreign writebacks
Message-ID: <20190830154023.GC25069@quack2.suse.cz>
References: <20190829224701.GX2263813@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829224701.GX2263813@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 29-08-19 15:47:19, Tejun Heo wrote:
> cgroup foreign inode handling has quite a bit of heuristics and
> internal states which sometimes makes it difficult to understand
> what's going on.  Add tracepoints to improve visibility.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
...
> +TRACE_EVENT(track_foreign_dirty,
> +
> +	TP_PROTO(struct page *page, struct bdi_writeback *wb),
> +
> +	TP_ARGS(page, wb),
> +
> +	TP_STRUCT__entry(
> +		__array(char,		name, 32)
> +		__field(u64,		bdi_id)
> +		__field(unsigned long,	ino)
> +		__field(unsigned int,	memcg_id)
> +		__field(unsigned int,	cgroup_ino)
> +		__field(unsigned int,	page_cgroup_ino)
> +	),
> +
> +	TP_fast_assign(
> +		strncpy(__entry->name,	dev_name(wb->bdi->dev), 32);
> +		__entry->bdi_id		= wb->bdi->id;
> +		__entry->ino		= page->mapping->host->i_ino;
> +		__entry->memcg_id	= wb->memcg_css->id;
> +		__entry->cgroup_ino	= __trace_wb_assign_cgroup(wb);
> +		__entry->page_cgroup_ino = page->mem_cgroup->css.cgroup->kn->id.ino;
> +	),

Are the page dereferences above safe? I suppose lock_page_memcg() protects
the page->mem_cgroup->css.cgroup->kn->id dereference? But page->mapping
does not seem to be protected by page lock?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
