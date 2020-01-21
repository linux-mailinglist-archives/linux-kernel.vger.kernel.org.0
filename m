Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45FE7144213
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 17:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729467AbgAUQWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 11:22:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:55986 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727817AbgAUQWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 11:22:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2B23DAFDC;
        Tue, 21 Jan 2020 16:22:15 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 78A021E0A4E; Tue, 21 Jan 2020 17:22:15 +0100 (CET)
Date:   Tue, 21 Jan 2020 17:22:15 +0100
From:   Jan Kara <jack@suse.cz>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/quota: remove unused macro
Message-ID: <20200121162215.GB5803@quack2.suse.cz>
References: <1579602334-57039-1-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579602334-57039-1-git-send-email-alex.shi@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 21-01-20 18:25:34, Alex Shi wrote:
> __QUOTA_V2_PARANOIA  macro is never used. better to remove it.
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Jan Kara <jack@suse.com> 
> Cc: linux-kernel@vger.kernel.org 

Thanks. I've merged the patch.

								Honza

> ---
>  fs/quota/quota_v2.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/quota/quota_v2.c b/fs/quota/quota_v2.c
> index 53429c29c784..58fc2a7c7fd1 100644
> --- a/fs/quota/quota_v2.c
> +++ b/fs/quota/quota_v2.c
> @@ -22,8 +22,6 @@
>  MODULE_DESCRIPTION("Quota format v2 support");
>  MODULE_LICENSE("GPL");
>  
> -#define __QUOTA_V2_PARANOIA
> -
>  static void v2r0_mem2diskdqb(void *dp, struct dquot *dquot);
>  static void v2r0_disk2memdqb(struct dquot *dquot, void *dp);
>  static int v2r0_is_id(void *dp, struct dquot *dquot);
> -- 
> 1.8.3.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
