Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84771A3C46
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 18:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfH3QmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 12:42:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:41120 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727976AbfH3QmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 12:42:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A5864B696;
        Fri, 30 Aug 2019 16:42:11 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6CA5F1E099F; Fri, 30 Aug 2019 18:42:11 +0200 (CEST)
Date:   Fri, 30 Aug 2019 18:42:11 +0200
From:   Jan Kara <jack@suse.cz>
To:     Tejun Heo <tj@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH block/for-next] writeback: add tracepoints for cgroup
 foreign writebacks
Message-ID: <20190830164211.GD25069@quack2.suse.cz>
References: <20190829224701.GX2263813@devbig004.ftw2.facebook.com>
 <20190830154023.GC25069@quack2.suse.cz>
 <20190830154921.GZ2263813@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830154921.GZ2263813@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 30-08-19 08:49:21, Tejun Heo wrote:
> Hello, Jan.
> 
> On Fri, Aug 30, 2019 at 05:40:23PM +0200, Jan Kara wrote:
> > > +	TP_fast_assign(
> > > +		strncpy(__entry->name,	dev_name(wb->bdi->dev), 32);
> > > +		__entry->bdi_id		= wb->bdi->id;
> > > +		__entry->ino		= page->mapping->host->i_ino;
> > > +		__entry->memcg_id	= wb->memcg_css->id;
> > > +		__entry->cgroup_ino	= __trace_wb_assign_cgroup(wb);
> > > +		__entry->page_cgroup_ino = page->mem_cgroup->css.cgroup->kn->id.ino;
> > > +	),
> > 
> > Are the page dereferences above safe? I suppose lock_page_memcg() protects
> > the page->mem_cgroup->css.cgroup->kn->id dereference? But page->mapping
> > does not seem to be protected by page lock?
> 
> Hah, I assumed it would work because there are preceding if
> (page_mapping()) tests in the dirty paths -
> e.g. __set_page_dirty_nobuffers().  Oh, regardless of that assumption,
> I should have used page_mapping().

Well, but if you look at __set_page_dirty_nobuffers() it is careful. It
does:

struct address_space *mapping = page_mapping(page);

if (!mapping) {
	bail
}
... use mapping

Exactly because page->mapping can become NULL under your hands if you don't
hold page lock. So I think you either need something similar in your
tracepoint or handle this in the caller.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
