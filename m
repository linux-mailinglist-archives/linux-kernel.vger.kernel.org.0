Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 882F5DA770
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2019 10:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408211AbfJQIao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Oct 2019 04:30:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:46030 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389542AbfJQIan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 04:30:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2A1DCB425;
        Thu, 17 Oct 2019 08:30:42 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 60A3C1E485F; Thu, 17 Oct 2019 10:30:41 +0200 (CEST)
Date:   Thu, 17 Oct 2019 10:30:41 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] quota: minor code cleanup for v1_format_ops
Message-ID: <20191017083041.GA20260@quack2.suse.cz>
References: <20191010130924.17697-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010130924.17697-1-cgxu519@mykernel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 10-10-19 21:09:24, Chengguang Xu wrote:
> It's not a functinal change, it's just for keeping
> consistent coding style.
> 
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>

Thanks. Applied.

								Honza

> ---
>  fs/quota/quota_v1.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/quota/quota_v1.c b/fs/quota/quota_v1.c
> index c740e5572eb8..cd92e5fa0062 100644
> --- a/fs/quota/quota_v1.c
> +++ b/fs/quota/quota_v1.c
> @@ -217,7 +217,6 @@ static const struct quota_format_ops v1_format_ops = {
>  	.check_quota_file	= v1_check_quota_file,
>  	.read_file_info		= v1_read_file_info,
>  	.write_file_info	= v1_write_file_info,
> -	.free_file_info		= NULL,
>  	.read_dqblk		= v1_read_dqblk,
>  	.commit_dqblk		= v1_commit_dqblk,
>  };
> -- 
> 2.21.0
> 
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
