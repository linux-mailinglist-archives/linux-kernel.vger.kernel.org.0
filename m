Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 274D2AD502
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2019 10:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389466AbfIIIkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Sep 2019 04:40:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:48794 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389418AbfIIIkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 04:40:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8827BAFCC;
        Mon,  9 Sep 2019 08:40:30 +0000 (UTC)
Date:   Mon, 9 Sep 2019 10:40:29 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     sunqiuyang <sunqiuyang@huawei.com>,
        Minchan Kim <minchan@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 1/1] mm/migrate: fix list corruption in migration of
 non-LRU movable pages
Message-ID: <20190909084029.GE27159@dhcp22.suse.cz>
References: <20190903082746.20736-1-sunqiuyang@huawei.com>
 <20190903131737.GB18939@dhcp22.suse.cz>
 <157FC541501A9C4C862B2F16FFE316DC190C1B09@dggeml512-mbx.china.huawei.com>
 <20190904063836.GD3838@dhcp22.suse.cz>
 <157FC541501A9C4C862B2F16FFE316DC190C2EBD@dggeml512-mbx.china.huawei.com>
 <20190904081408.GF3838@dhcp22.suse.cz>
 <157FC541501A9C4C862B2F16FFE316DC190C3402@dggeml512-mbx.china.huawei.com>
 <20190904125226.GV3838@dhcp22.suse.cz>
 <157FC541501A9C4C862B2F16FFE316DC190C5990@dggeml512-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157FC541501A9C4C862B2F16FFE316DC190C5990@dggeml512-mbx.china.huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 05-09-19 01:44:12, sunqiuyang wrote:
> > 
> > ________________________________________
> > From: Michal Hocko [mhocko@kernel.org]
> > Sent: Wednesday, September 04, 2019 20:52
> > To: sunqiuyang
> > Cc: linux-kernel@vger.kernel.org; linux-mm@kvack.org
> > Subject: Re: [PATCH 1/1] mm/migrate: fix list corruption in migration of non-LRU movable pages
> > 
> > On Wed 04-09-19 12:19:11, sunqiuyang wrote:
> > > > Do not top post please
> > > >
> > > > On Wed 04-09-19 07:27:25, sunqiuyang wrote:
> > > > > isolate_migratepages_block() from another thread may try to isolate the page again:
> > > > >
> > > > > for (; low_pfn < end_pfn; low_pfn++) {
> > > > >   /* ... */
> > > > >   page = pfn_to_page(low_pfn);
> > > > >  /* ... */
> > > > >   if (!PageLRU(page)) {
> > > > >     if (unlikely(__PageMovable(page)) && !PageIsolated(page)) {
> > > > >         /* ... */
> > > > >         if (!isolate_movable_page(page, isolate_mode))
> > > > >           goto isolate_success;
> > > > >       /*... */
> > > > > isolate_success:
> > > > >      list_add(&page->lru, &cc->migratepages);
> > > > >
> > > > > And this page will be added to another list.
> > > > > Or, do you see any reason that the page cannot go through this path?
> > > >
> > > > The page shouldn't be __PageMovable after the migration is done. All the
> > > > state should have been transfered to the new page IIUC.
> > > >
> > >
> > > I don't see where page->mapping is modified after the migration is done.
> > >
> > > Actually, the last comment in move_to_new_page() says,
> > > "Anonymous and movable page->mapping will be cleard by
> > > free_pages_prepare so don't reset it here for keeping
> > > the type to work PageAnon, for example. "
> > >
> > > Or did I miss something? Thanks,
> > 
> > This talks about mapping rather than flags stored in the mapping.
> > I can see that in tree migration handlers (z3fold_page_migrate,
> > vmballoon_migratepage via balloon_page_delete, zs_page_migrate via
> > reset_page) all reset the movable flag. I am not sure whether that is a
> > documented requirement or just a coincidence. Maybe it should be
> > documented. I would like to hear from Minchan.
> 
> I checked the three migration handlers and only found __ClearPageMovable,
> which clears registered address_space val with keeping PAGE_MAPPING_MOVABLE flag,
> so the page should still be __PageMovable when caught by another migration thread. Right?

Minchan, could you have a look at this please? I find __PageMovable
semantic really awkward and I do not want to make misleading statements
here.
-- 
Michal Hocko
SUSE Labs
