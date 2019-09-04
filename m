Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26A61A7BCC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 08:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbfIDGij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 02:38:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:39962 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725966AbfIDGii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 02:38:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C3364ACE3;
        Wed,  4 Sep 2019 06:38:37 +0000 (UTC)
Date:   Wed, 4 Sep 2019 08:38:36 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     sunqiuyang <sunqiuyang@huawei.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 1/1] mm/migrate: fix list corruption in migration of
 non-LRU movable pages
Message-ID: <20190904063836.GD3838@dhcp22.suse.cz>
References: <20190903082746.20736-1-sunqiuyang@huawei.com>
 <20190903131737.GB18939@dhcp22.suse.cz>
 <157FC541501A9C4C862B2F16FFE316DC190C1B09@dggeml512-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157FC541501A9C4C862B2F16FFE316DC190C1B09@dggeml512-mbx.china.huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 04-09-19 02:18:38, sunqiuyang wrote:
> The isolate path of non-lru movable pages:
> 
> isolate_migratepages_block
> 	isolate_movable_page
> 		trylock_page
> 		// if PageIsolated, goto out_no_isolated
> 		a_ops->isolate_page
> 		__SetPageIsolated
> 		unlock_page
> 	list_add(&page->lru, &cc->migratepages)
> 
> The migration path:
> 
> unmap_and_move
> 	__unmap_and_move
> 		lock_page
> 		move_to_new_page
> 			a_ops->migratepage
> 			__ClearPageIsolated
> 		unlock_page
> 	/* here, the page could be isolated again by another thread, and added into another cc->migratepages,
> 	since PG_Isolated has been cleared, and not protected by page_lock */
> 	list_del(&page->lru)

But the page has been migrated already and not freed yet because there
is still a pin on it. So nobody should be touching it at this stage.
Or do I still miss something?
-- 
Michal Hocko
SUSE Labs
