Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B31A7169BFA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 02:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbgBXBwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Feb 2020 20:52:43 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:46942 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727151AbgBXBwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 20:52:43 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04428;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TqhdyQQ_1582509160;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0TqhdyQQ_1582509160)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 24 Feb 2020 09:52:40 +0800
Subject: Re: [PATCH 30/30] sgi-xp: Add missing annotation for
 ocfs2_inode_cache_lock() and ocfs2_inode_cache_unlock()
To:     Jules Irenge <jbi.octave@gmail.com>, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        "moderated list:ORACLE CLUSTER FILESYSTEM 2 (OCFS2)" 
        <ocfs2-devel@oss.oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <0/30> <20200223231711.157699-1-jbi.octave@gmail.com>
 <20200223231711.157699-31-jbi.octave@gmail.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <fd7abad1-1bbe-8dc7-3aef-2ab5b4c359bf@linux.alibaba.com>
Date:   Mon, 24 Feb 2020 09:52:39 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200223231711.157699-31-jbi.octave@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/2/24 07:17, Jules Irenge wrote:
> Sparse reports a warning at ocfs2_inode_cache_lock()
> and ocfs2_inode_cache_unlock()
> warning: context imbalance in ocfs2_inode_cache_lock()
> 	- wrong count at exit
> 
> warning: context imbalance in ocfs2_inode_cache_unlock()
> 	- unexpected unlock
> The root cause is a missing annotation at ocfs2_inode_cache_lock()
> and at ocfs2_inode_cache_unlock()
> 
> Add the missing __acquires(&oi->ip_lock) annotation
> Add the missing __releases(&oi->ip_lock) annotation
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>

Looks good.
BTW, there are another co_cache_[lock|unlock] implementations also
miss the annotations:
ocfs2_refcount_cache_lock
ocfs2_refcount_cache_unlock
So could we add the missing annotations as well?

Thanks,
Joseph

> ---
>  fs/ocfs2/inode.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
> index 7c9dfd50c1c1..0b87e0a63ab9 100644
> --- a/fs/ocfs2/inode.c
> +++ b/fs/ocfs2/inode.c
> @@ -1623,6 +1623,7 @@ static struct super_block *ocfs2_inode_cache_get_super(struct ocfs2_caching_info
>  }
>  
>  static void ocfs2_inode_cache_lock(struct ocfs2_caching_info *ci)
> +	__acquires(&oi->ip_lock)
>  {
>  	struct ocfs2_inode_info *oi = cache_info_to_inode(ci);
>  
> @@ -1630,6 +1631,7 @@ static void ocfs2_inode_cache_lock(struct ocfs2_caching_info *ci)
>  }
>  
>  static void ocfs2_inode_cache_unlock(struct ocfs2_caching_info *ci)
> +	__releases(&oi->ip_lock)
>  {
>  	struct ocfs2_inode_info *oi = cache_info_to_inode(ci);
>  
> 
