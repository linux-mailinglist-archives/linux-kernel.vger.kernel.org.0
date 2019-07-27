Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10FB17757C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2019 02:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbfG0AuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 20:50:02 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:55968 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726115AbfG0AuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 20:50:02 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TXsT3L6_1564188597;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0TXsT3L6_1564188597)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 27 Jul 2019 08:49:58 +0800
Subject: Re: [PATCH 1/3 v2] fs: ocfs2: Fix possible null-pointer dereferences
 in ocfs2_xa_prepare_entry()
To:     Jia-Ju Bai <baijiaju1990@gmail.com>, mark@fasheh.com,
        jlbec@evilplan.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
References: <20190726101447.9153-1-baijiaju1990@gmail.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <d56d61b1-d468-f967-4aaf-bb419c139bc3@linux.alibaba.com>
Date:   Sat, 27 Jul 2019 08:49:57 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190726101447.9153-1-baijiaju1990@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/7/26 18:14, Jia-Ju Bai wrote:
> In ocfs2_xa_prepare_entry(), there is an if statement on line 2136 to
> check whether loc->xl_entry is NULL:
>     if (loc->xl_entry)
> 
> When loc->xl_entry is NULL, it is used on line 2158:
>     ocfs2_xa_add_entry(loc, name_hash);
>         loc->xl_entry->xe_name_hash = cpu_to_le32(name_hash);
>         loc->xl_entry->xe_name_offset = cpu_to_le16(loc->xl_size);
> and line 2164:
>     ocfs2_xa_add_namevalue(loc, xi);
>         loc->xl_entry->xe_value_size = cpu_to_le64(xi->xi_value_len);
>         loc->xl_entry->xe_name_len = xi->xi_name_len;
> 
> Thus, possible null-pointer dereferences may occur.
> 
> To fix these bugs, if loc-xl_entry is NULL, ocfs2_xa_prepare_entry()
> abnormally returns with -EINVAL.
> 
> These bugs are found by a static analysis tool STCheck written by us.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
> v2:
> * Directly return -EINVAL if loc-xl_entry is NULL.
>   Thank Joseph for helpful advice.
> 
> ---
>  fs/ocfs2/xattr.c | 44 +++++++++++++++++++++++---------------------
>  1 file changed, 23 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
> index 385f3aaa2448..4b876c82a35c 100644
> --- a/fs/ocfs2/xattr.c
> +++ b/fs/ocfs2/xattr.c
> @@ -2133,29 +2133,31 @@ static int ocfs2_xa_prepare_entry(struct ocfs2_xa_loc *loc,
>  	if (rc)
>  		goto out;
>  
> -	if (loc->xl_entry) {
> -		if (ocfs2_xa_can_reuse_entry(loc, xi)) {
> -			orig_value_size = loc->xl_entry->xe_value_size;
> -			rc = ocfs2_xa_reuse_entry(loc, xi, ctxt);
> -			if (rc)
> -				goto out;
> -			goto alloc_value;
> -		}
> +	if (!loc->xl_entry) {
> +		rc = -EINVAL;
> +		goto out;
> +	}
>  
> -		if (!ocfs2_xattr_is_local(loc->xl_entry)) {
> -			orig_clusters = ocfs2_xa_value_clusters(loc);
> -			rc = ocfs2_xa_value_truncate(loc, 0, ctxt);
> -			if (rc) {
> -				mlog_errno(rc);
> -				ocfs2_xa_cleanup_value_truncate(loc,
> -								"overwriting",
> -								orig_clusters);
> -				goto out;
> -			}
> +	if (ocfs2_xa_can_reuse_entry(loc, xi)) {
> +		orig_value_size = loc->xl_entry->xe_value_size;
> +		rc = ocfs2_xa_reuse_entry(loc, xi, ctxt);
> +		if (rc)
> +			goto out;
> +		goto alloc_value;
> +	}
> +
> +	if (!ocfs2_xattr_is_local(loc->xl_entry)) {
> +		orig_clusters = ocfs2_xa_value_clusters(loc);
> +		rc = ocfs2_xa_value_truncate(loc, 0, ctxt);
> +		if (rc) {
> +			mlog_errno(rc);
> +			ocfs2_xa_cleanup_value_truncate(loc,
> +							"overwriting",
> +							orig_clusters);
> +			goto out;
>  		}
> -		ocfs2_xa_wipe_namevalue(loc);
> -	} else
> -		ocfs2_xa_add_entry(loc, name_hash);
> +	}
> +	ocfs2_xa_wipe_namevalue(loc);
>  
>  	/*
>  	 * If we get here, we have a blank entry.  Fill it.  We grow our
> 
