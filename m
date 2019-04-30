Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66347F24C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 10:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfD3I4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 04:56:02 -0400
Received: from relay.sw.ru ([185.231.240.75]:38312 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbfD3I4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 04:56:01 -0400
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1hLOYF-0007NC-34; Tue, 30 Apr 2019 11:55:47 +0300
Subject: Re: [PATCH 3/3] prctl_set_mm: downgrade mmap_sem to read lock
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        gorcunov@gmail.com
Cc:     akpm@linux-foundation.org, arunks@codeaurora.org, brgl@bgdev.pl,
        geert+renesas@glider.be, ldufour@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mguzik@redhat.com, mhocko@kernel.org, rppt@linux.ibm.com,
        vbabka@suse.cz
References: <20190418182321.GJ3040@uranus.lan>
 <20190430081844.22597-1-mkoutny@suse.com>
 <20190430081844.22597-4-mkoutny@suse.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <af8f7958-06aa-7134-c750-b7a994368e89@virtuozzo.com>
Date:   Tue, 30 Apr 2019 11:55:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430081844.22597-4-mkoutny@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.04.2019 11:18, Michal Koutný wrote:
> Since commit 88aa7cc688d4 ("mm: introduce arg_lock to protect
> arg_start|end and env_start|end in mm_struct") we use arg_lock for
> boundaries modifications. Synchronize prctl_set_mm with this lock and
> keep mmap_sem for reading only (analogous to what we already do in
> prctl_set_mm_map).
> 
> v2: call find_vma without arg_lock held
> 
> CC: Cyrill Gorcunov <gorcunov@gmail.com>
> CC: Laurent Dufour <ldufour@linux.ibm.com>
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> ---
>  kernel/sys.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sys.c b/kernel/sys.c
> index e1acb444d7b0..641fda756575 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2123,9 +2123,14 @@ static int prctl_set_mm(int opt, unsigned long addr,
>  
>  	error = -EINVAL;
>  
> -	down_write(&mm->mmap_sem);
> +	/*
> +	 * arg_lock protects concurent updates of arg boundaries, we need mmap_sem for
> +	 * a) concurrent sys_brk, b) finding VMA for addr validation.
> +	 */
> +	down_read(&mm->mmap_sem);
>  	vma = find_vma(mm, addr);
>  
> +	spin_lock(&mm->arg_lock);
>  	prctl_map.start_code	= mm->start_code;
>  	prctl_map.end_code	= mm->end_code;
>  	prctl_map.start_data	= mm->start_data;
> @@ -2213,7 +2218,8 @@ static int prctl_set_mm(int opt, unsigned long addr,
>  
>  	error = 0;
>  out:
> -	up_write(&mm->mmap_sem);
> +	spin_unlock(&mm->arg_lock);
> +	up_read(&mm->mmap_sem);
>  	return error;

Hm, shouldn't spin_lock()/spin_unlock() pair go as a fixup to existing code
in a separate patch? 

Without them, the existing code has a problem at least in get_mm_cmdline().
