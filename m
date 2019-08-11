Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7D7E89313
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2019 20:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfHKSLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Aug 2019 14:11:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55430 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbfHKSLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 14:11:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0BEA97FD45;
        Sun, 11 Aug 2019 18:11:22 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6DF0B7C777;
        Sun, 11 Aug 2019 18:11:17 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id x7BIBHNa014830;
        Sun, 11 Aug 2019 14:11:17 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id x7BIBGRG014826;
        Sun, 11 Aug 2019 14:11:16 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Sun, 11 Aug 2019 14:11:16 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Huaisheng Ye <yehs2007@zoho.com>
cc:     snitzer@redhat.com, agk@redhat.com, prarit@redhat.com,
        tyu1@lenovo.com, dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        Huaisheng Ye <yehs1@lenovo.com>
Subject: Re: dm writecache: add unlikely for getting two block with same
 LBA
In-Reply-To: <20190811161233.7616-2-yehs2007@zoho.com>
Message-ID: <alpine.LRH.2.02.1908111410590.13454@file01.intranet.prod.int.rdu2.redhat.com>
References: <20190811161233.7616-1-yehs2007@zoho.com> <20190811161233.7616-2-yehs2007@zoho.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Sun, 11 Aug 2019 18:11:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 12 Aug 2019, Huaisheng Ye wrote:

> From: Huaisheng Ye <yehs1@lenovo.com>
> 
> In function writecache_writeback, entries g and f has same original
> sector only happens at entry f has been committed, but entry g has
> NOT yet.
> 
> The probability of this happening is very low in the following
>  256 blocks at most of entry e, so add unlikely for the result.
> 
> Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>

Acked-by: Mikulas Patocka <mpatocka@redhat.com>

> ---
>  drivers/md/dm-writecache.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
> index 5c7009d..3643084 100644
> --- a/drivers/md/dm-writecache.c
> +++ b/drivers/md/dm-writecache.c
> @@ -1628,8 +1628,8 @@ static void writecache_writeback(struct work_struct *work)
>  			if (unlikely(!next_node))
>  				break;
>  			g = container_of(next_node, struct wc_entry, rb_node);
> -			if (read_original_sector(wc, g) ==
> -			    read_original_sector(wc, f)) {
> +			if (unlikely(read_original_sector(wc, g) ==
> +			    read_original_sector(wc, f))) {
>  				f = g;
>  				continue;
>  			}
> -- 
> 1.8.3.1
> 
> 
