Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA3E721883
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 14:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbfEQMlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 May 2019 08:41:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:33548 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728474AbfEQMlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 08:41:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 410FBAF3A;
        Fri, 17 May 2019 12:41:20 +0000 (UTC)
Date:   Fri, 17 May 2019 14:41:19 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Cyrill Gorcunov <gorcunov@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 1/5] proc: use down_read_killable for /proc/pid/maps
Message-ID: <20190517124119.GA1825@dhcp22.suse.cz>
References: <155790967258.1319.11531787078240675602.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155790967258.1319.11531787078240675602.stgit@buzz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 15-05-19 11:41:12, Konstantin Khlebnikov wrote:
> Do not stuck forever if something wrong.
> This function also used for /proc/pid/smaps.

I do agree that the killable variant is better but I do not understand
the changelog. What would keep the lock blocked for ever? I do not think
we have writer lock held for unbound amount of time anywhere, do we?

> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

Other than that
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  fs/proc/task_mmu.c   |    6 +++++-
>  fs/proc/task_nommu.c |    6 +++++-
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 01d4eb0e6bd1..2bf210229daf 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -166,7 +166,11 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
>  	if (!mm || !mmget_not_zero(mm))
>  		return NULL;
>  
> -	down_read(&mm->mmap_sem);
> +	if (down_read_killable(&mm->mmap_sem)) {
> +		mmput(mm);
> +		return ERR_PTR(-EINTR);
> +	}
> +
>  	hold_task_mempolicy(priv);
>  	priv->tail_vma = get_gate_vma(mm);
>  
> diff --git a/fs/proc/task_nommu.c b/fs/proc/task_nommu.c
> index 36bf0f2e102e..7907e6419e57 100644
> --- a/fs/proc/task_nommu.c
> +++ b/fs/proc/task_nommu.c
> @@ -211,7 +211,11 @@ static void *m_start(struct seq_file *m, loff_t *pos)
>  	if (!mm || !mmget_not_zero(mm))
>  		return NULL;
>  
> -	down_read(&mm->mmap_sem);
> +	if (down_read_killable(&mm->mmap_sem)) {
> +		mmput(mm);
> +		return ERR_PTR(-EINTR);
> +	}
> +
>  	/* start from the Nth VMA */
>  	for (p = rb_first(&mm->mm_rb); p; p = rb_next(p))
>  		if (n-- == 0)

-- 
Michal Hocko
SUSE Labs
