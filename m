Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76A2FCBBE9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 15:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388654AbfJDNjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 09:39:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:39234 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388462AbfJDNjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 09:39:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B6B7BB193;
        Fri,  4 Oct 2019 13:39:29 +0000 (UTC)
Date:   Fri, 4 Oct 2019 15:39:29 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2] mm/swap: piggyback lru_add_drain_all() calls
Message-ID: <20191004133929.GN9578@dhcp22.suse.cz>
References: <157019456205.3142.3369423180908482020.stgit@buzz>
 <20191004131230.GL9578@dhcp22.suse.cz>
 <c1617cff-847f-4cbf-d314-0382a3e9233d@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1617cff-847f-4cbf-d314-0382a3e9233d@yandex-team.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 04-10-19 16:32:39, Konstantin Khlebnikov wrote:
> On 04/10/2019 16.12, Michal Hocko wrote:
> > On Fri 04-10-19 16:09:22, Konstantin Khlebnikov wrote:
> > > This is very slow operation. There is no reason to do it again if somebody
> > > else already drained all per-cpu vectors while we waited for lock.
> > > 
> > > Piggyback on drain started and finished while we waited for lock:
> > > all pages pended at the time of our enter were drained from vectors.
> > > 
> > > Callers like POSIX_FADV_DONTNEED retry their operations once after
> > > draining per-cpu vectors when pages have unexpected references.
> > 
> > This describes why we need to wait for preexisted pages on the pvecs but
> > the changelog doesn't say anything about improvements this leads to.
> > In other words what kind of workloads benefit from it?
> 
> Right now POSIX_FADV_DONTNEED is top user because it have to freeze page
> reference when removes it from cache. invalidate_bdev calls it for same reason.
> Both are triggered from userspace, so it's easy to generate storm.
> 
> mlock/mlockall no longer calls lru_add_drain_all - I've seen here
> serious slowdown on older kernel.
> 
> There are some less obvious paths in memory migration/CMA/offlining
> which shouldn't be called frequently.

Can you back those claims by any numbers?
-- 
Michal Hocko
SUSE Labs
