Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7234ECFD91
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 17:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfJHP06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 11:26:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:47500 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725966AbfJHP06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 11:26:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 495B0AEF1;
        Tue,  8 Oct 2019 15:26:57 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A1CA21E4827; Tue,  8 Oct 2019 17:26:56 +0200 (CEST)
Date:   Tue, 8 Oct 2019 17:26:56 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] quota: check quota type in early stage
Message-ID: <20191008152656.GA5050@quack2.suse.cz>
References: <20191008145059.21402-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008145059.21402-1-cgxu519@mykernel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 08-10-19 22:50:59, Chengguang Xu wrote:
> Check quota type in early stage so we can avoid many
> unncessary operations when the type is wrong.
> 
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>

Yeah, checking earlier makes sense, especially since it consolidates two
checks into one. I've added your patch to my tree. Thanks!

								Honza

> ---
>  fs/quota/quota.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/quota/quota.c b/fs/quota/quota.c
> index cb13fb76dbee..5444d3c4d93f 100644
> --- a/fs/quota/quota.c
> +++ b/fs/quota/quota.c
> @@ -60,8 +60,6 @@ static int quota_sync_all(int type)
>  {
>  	int ret;
>  
> -	if (type >= MAXQUOTAS)
> -		return -EINVAL;
>  	ret = security_quotactl(Q_SYNC, type, 0, NULL);
>  	if (!ret)
>  		iterate_supers(quota_sync_one, &type);
> @@ -686,8 +684,6 @@ static int do_quotactl(struct super_block *sb, int type, int cmd, qid_t id,
>  {
>  	int ret;
>  
> -	if (type >= MAXQUOTAS)
> -		return -EINVAL;
>  	type = array_index_nospec(type, MAXQUOTAS);
>  	/*
>  	 * Quota not supported on this fs? Check this before s_quota_types
> @@ -831,6 +827,9 @@ int kernel_quotactl(unsigned int cmd, const char __user *special,
>  	cmds = cmd >> SUBCMDSHIFT;
>  	type = cmd & SUBCMDMASK;
>  
> +	if (type >= MAXQUOTAS)
> +		return -EINVAL;
> +
>  	/*
>  	 * As a special case Q_SYNC can be called without a specific device.
>  	 * It will iterate all superblocks that have quota enabled and call
> -- 
> 2.21.0
> 
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
