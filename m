Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9218A21895
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 14:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbfEQMp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 May 2019 08:45:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:34538 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728207AbfEQMp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 08:45:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 48ECDAF59;
        Fri, 17 May 2019 12:45:56 +0000 (UTC)
Date:   Fri, 17 May 2019 14:45:55 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Cyrill Gorcunov <gorcunov@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 2/5] proc: use down_read_killable for
 /proc/pid/smaps_rollup
Message-ID: <20190517124555.GB1825@dhcp22.suse.cz>
References: <155790967258.1319.11531787078240675602.stgit@buzz>
 <155790967469.1319.14744588086607025680.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155790967469.1319.14744588086607025680.stgit@buzz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 15-05-19 11:41:14, Konstantin Khlebnikov wrote:
> Ditto.

Proper changelog or simply squash those patches into a single patch if
you do not feel like copy&paste is fun

> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> ---
>  fs/proc/task_mmu.c |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 2bf210229daf..781879a91e3b 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -832,7 +832,10 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
>  
>  	memset(&mss, 0, sizeof(mss));
>  
> -	down_read(&mm->mmap_sem);
> +	ret = down_read_killable(&mm->mmap_sem);
> +	if (ret)
> +		goto out_put_mm;

Why not ret = -EINTR. The seq_file code seems to be handling all errors
AFAICS.

> +
>  	hold_task_mempolicy(priv);
>  
>  	for (vma = priv->mm->mmap; vma; vma = vma->vm_next) {
> @@ -849,8 +852,9 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
>  
>  	release_task_mempolicy(priv);
>  	up_read(&mm->mmap_sem);
> -	mmput(mm);
>  
> +out_put_mm:
> +	mmput(mm);
>  out_put_task:
>  	put_task_struct(priv->task);
>  	priv->task = NULL;

-- 
Michal Hocko
SUSE Labs
