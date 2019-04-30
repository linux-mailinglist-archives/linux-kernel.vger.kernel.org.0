Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7483AF27C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 11:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfD3JKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 05:10:07 -0400
Received: from relay.sw.ru ([185.231.240.75]:38976 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbfD3JKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 05:10:07 -0400
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1hLOlz-0007UE-CV; Tue, 30 Apr 2019 12:09:59 +0300
Subject: Re: [PATCH 1/3] mm: get_cmdline use arg_lock instead of mmap_sem
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        gorcunov@gmail.com
Cc:     akpm@linux-foundation.org, arunks@codeaurora.org, brgl@bgdev.pl,
        geert+renesas@glider.be, ldufour@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mguzik@redhat.com, mhocko@kernel.org, rppt@linux.ibm.com,
        vbabka@suse.cz
References: <20190418182321.GJ3040@uranus.lan>
 <20190430081844.22597-1-mkoutny@suse.com>
 <20190430081844.22597-2-mkoutny@suse.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <4c79fb09-c310-4426-68f7-8b268100359a@virtuozzo.com>
Date:   Tue, 30 Apr 2019 12:09:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430081844.22597-2-mkoutny@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.04.2019 11:18, Michal Koutný wrote:
> The commit a3b609ef9f8b ("proc read mm's {arg,env}_{start,end} with mmap
> semaphore taken.") added synchronization of reading argument/environment
> boundaries under mmap_sem. Later commit 88aa7cc688d4 ("mm: introduce
> arg_lock to protect arg_start|end and env_start|end in mm_struct")
> avoided the coarse use of mmap_sem in similar situations.
> 
> get_cmdline can also use arg_lock instead of mmap_sem when it reads the
> boundaries.
> 
> Fixes: 88aa7cc688d4 ("mm: introduce arg_lock to protect arg_start|end and env_start|end in mm_struct")
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: Mateusz Guzik <mguzik@redhat.com>
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
> ---
>  mm/util.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/util.c b/mm/util.c
> index 43a2984bccaa..5cf0e84a0823 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -758,12 +758,12 @@ int get_cmdline(struct task_struct *task, char *buffer, int buflen)
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

This looks OK for me.

But speaking about existing code it's a secret for me, why we ignore arg_lock
in binfmt code, e.g. in load_elf_binary().
