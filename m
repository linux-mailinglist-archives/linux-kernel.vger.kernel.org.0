Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B73ADAF1E7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 21:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfIJTbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 15:31:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:47518 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725937AbfIJTbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 15:31:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6ED4FAE68;
        Tue, 10 Sep 2019 19:31:21 +0000 (UTC)
Date:   Tue, 10 Sep 2019 21:31:20 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     sunqiuyang <sunqiuyang@huawei.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/1] mm/migrate: fix list corruption in migration of
 non-LRU movable pages
Message-ID: <20190910193120.GF4023@dhcp22.suse.cz>
References: <20190903082746.20736-1-sunqiuyang@huawei.com>
 <20190910192304.GA220078@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910192304.GA220078@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10-09-19 12:23:04, Minchan Kim wrote:
> On Tue, Sep 03, 2019 at 04:27:46PM +0800, sunqiuyang wrote:
> > From: Qiuyang Sun <sunqiuyang@huawei.com>
> > 
> > Currently, after a page is migrated, it
> > 1) has its PG_isolated flag cleared in move_to_new_page(), and
> > 2) is deleted from its LRU list (cc->migratepages) in unmap_and_move().
> > However, between steps 1) and 2), the page could be isolated by another
> > thread in isolate_movable_page(), and added to another LRU list, leading
> > to list_del corruption later.
> 
> Once non-LRU page is migrated out successfully, driver should clear
> the movable flag in the page. Look at reset_page in zs_page_migrate.
> So, other thread couldn't isolate the page during the window.
> 
> If I miss something, let me know it.

Please have a look at http://lkml.kernel.org/r/157FC541501A9C4C862B2F16FFE316DC190C5990@dggeml512-mbx.china.huawei.com
-- 
Michal Hocko
SUSE Labs
