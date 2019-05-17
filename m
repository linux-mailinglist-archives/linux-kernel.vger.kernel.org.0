Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE0482189B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 14:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbfEQMsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 May 2019 08:48:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:34926 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728287AbfEQMsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 08:48:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BBF60AF59;
        Fri, 17 May 2019 12:47:59 +0000 (UTC)
Date:   Fri, 17 May 2019 14:47:59 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Cyrill Gorcunov <gorcunov@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 4/5] proc: use down_read_killable for /proc/pid/clear_refs
Message-ID: <20190517124759.GD1825@dhcp22.suse.cz>
References: <155790967258.1319.11531787078240675602.stgit@buzz>
 <155790968147.1319.10247444846354273332.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155790968147.1319.10247444846354273332.stgit@buzz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 15-05-19 11:41:21, Konstantin Khlebnikov wrote:
> Replace the only unkillable mmap_sem lock in clear_refs_write.

Poor changelog again.

The change itself looks ok to me.

> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> ---
>  fs/proc/task_mmu.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 78bed6adc62d..7f84d1477b5b 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1140,7 +1140,10 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
>  			goto out_mm;
>  		}
>  
> -		down_read(&mm->mmap_sem);
> +		if (down_read_killable(&mm->mmap_sem)) {
> +			count = -EINTR;
> +			goto out_mm;
> +		}
>  		tlb_gather_mmu(&tlb, mm, 0, -1);
>  		if (type == CLEAR_REFS_SOFT_DIRTY) {
>  			for (vma = mm->mmap; vma; vma = vma->vm_next) {

-- 
Michal Hocko
SUSE Labs
