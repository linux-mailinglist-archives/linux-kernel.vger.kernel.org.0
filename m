Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF60A21899
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 14:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbfEQMqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 May 2019 08:46:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:34744 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728654AbfEQMqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 08:46:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D83B1AF68;
        Fri, 17 May 2019 12:46:48 +0000 (UTC)
Date:   Fri, 17 May 2019 14:46:48 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Cyrill Gorcunov <gorcunov@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 3/5] proc: use down_read_killable for /proc/pid/pagemap
Message-ID: <20190517124648.GC1825@dhcp22.suse.cz>
References: <155790967258.1319.11531787078240675602.stgit@buzz>
 <155790967960.1319.6040190052682812218.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155790967960.1319.6040190052682812218.stgit@buzz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 15-05-19 11:41:19, Konstantin Khlebnikov wrote:
> Ditto.

ditto to the previous patch, including -EINTR.

> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> ---
>  fs/proc/task_mmu.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 781879a91e3b..78bed6adc62d 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1547,7 +1547,9 @@ static ssize_t pagemap_read(struct file *file, char __user *buf,
>  		/* overflow ? */
>  		if (end < start_vaddr || end > end_vaddr)
>  			end = end_vaddr;
> -		down_read(&mm->mmap_sem);
> +		ret = down_read_killable(&mm->mmap_sem);
> +		if (ret)
> +			goto out_free;
>  		ret = walk_page_range(start_vaddr, end, &pagemap_walk);
>  		up_read(&mm->mmap_sem);
>  		start_vaddr = end;

-- 
Michal Hocko
SUSE Labs
