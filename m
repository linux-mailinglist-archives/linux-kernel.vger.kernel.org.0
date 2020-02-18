Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDC7163722
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 00:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgBRX1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 18:27:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:40362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727951AbgBRX1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 18:27:15 -0500
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8492422B48;
        Tue, 18 Feb 2020 23:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582068434;
        bh=rUP93xEkDhBdiO8ILugsojP+aU7U9As9cgAaxy/Sn8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=njxulyfwSmUPae6vEWrNK0WrXyb7Os08KUJex733g9Q3dyMQdDq4MQlW4XtlIO0RK
         ORCfyAff92y7OrewyBZODjxSkQIBav7FI8QlooxmPiSrHHuce5EKGtZjqG55yETM06
         1j6iD8ucFY82Hgm1WVhGsIG7GWuXhWHHaV7jaTok=
Date:   Tue, 18 Feb 2020 15:27:14 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 3/3] f2fs: skip migration only when BG_GC is
 called
Message-ID: <20200218232714.GB10213@google.com>
References: <20200214185855.217360-1-jaegeuk@kernel.org>
 <20200214185855.217360-3-jaegeuk@kernel.org>
 <9c497f3e-3399-e4a6-f81c-6c4a1f35e5bb@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c497f3e-3399-e4a6-f81c-6c4a1f35e5bb@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/17, Chao Yu wrote:
> On 2020/2/15 2:58, Jaegeuk Kim wrote:
> > FG_GC needs to move entire section more quickly.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/gc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > index bbf4db3f6bb4..1676eebc8c8b 100644
> > --- a/fs/f2fs/gc.c
> > +++ b/fs/f2fs/gc.c
> > @@ -1203,7 +1203,7 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
> >  
> >  		if (get_valid_blocks(sbi, segno, false) == 0)
> >  			goto freed;
> > -		if (__is_large_section(sbi) &&
> > +		if (gc_type == BG_GC && __is_large_section(sbi) &&
> >  				migrated >= sbi->migration_granularity)
> 
> I knew migrating one large section is a more efficient way, but this can
> increase long-tail latency of f2fs_balance_fs() occasionally, especially in
> extreme fragmented space.

FG_GC requires to wait for whole section migration which shows the entire
latency.

> 
> Thanks,
> 
> >  			goto skip;
> >  		if (!PageUptodate(sum_page) || unlikely(f2fs_cp_error(sbi)))
> > 
