Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 942681EA0B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 10:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfEOIXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 04:23:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:33190 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726586AbfEOIXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 04:23:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1ACCFAF74;
        Wed, 15 May 2019 08:23:33 +0000 (UTC)
Date:   Wed, 15 May 2019 10:22:59 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Yang Shi <yang.shi@linux.alibaba.com>, mkoutny@suse.com
Subject: Re: [PATCH] mm: fix protection of mm_struct fields in get_cmdline()
Message-ID: <20190515082222.GA21259@linux>
References: <155790813764.2995.13706842444028749629.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155790813764.2995.13706842444028749629.stgit@buzz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 11:15:37AM +0300, Konstantin Khlebnikov wrote:
> Since commit 88aa7cc688d4 ("mm: introduce arg_lock to protect arg_start|
> end and env_start|end in mm_struct") related mm fields are protected with
> separate spinlock and mmap_sem held for read is not enough for protection.
> 
> Fixes: 88aa7cc688d4 ("mm: introduce arg_lock to protect arg_start|end and env_start|end in mm_struct")
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

This was already addressed by [1]?

[1] https://patchwork.kernel.org/patch/10923003/

> ---
>  mm/util.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/util.c b/mm/util.c
> index e2e4f8c3fa12..540e7c157cf2 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -717,12 +717,12 @@ int get_cmdline(struct task_struct *task, char *buffer, int buflen)
>  	if (!mm->arg_end)
>  		goto out_mm;	/* Shh! No looking before we're done */
>  
> -	down_read(&mm->mmap_sem);
> +	spin_lock(&mm->arg_lock);
>  	arg_start = mm->arg_start;
>  	arg_end = mm->arg_end;
>  	env_start = mm->env_start;
>  	env_end = mm->env_end;
> -	up_read(&mm->mmap_sem);
> +	spin_unlock(&mm->arg_lock);
>  
>  	len = arg_end - arg_start;
>  
> 

-- 
Oscar Salvador
SUSE L3
