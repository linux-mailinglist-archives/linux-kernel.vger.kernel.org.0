Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDF913C45
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2019 01:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfEDXdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 May 2019 19:33:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:53068 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726596AbfEDXdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 19:33:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A0BA5AEE3;
        Sat,  4 May 2019 23:33:06 +0000 (UTC)
Date:   Sat, 4 May 2019 19:33:02 -0400
From:   Michal Hocko <mhocko@kernel.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] signal: reorder struct sighand_struct
Message-ID: <20190504233302.GT29835@dhcp22.suse.cz>
References: <20190503192800.GA18004@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503192800.GA18004@avx2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CCing Oleg.

On Fri 03-05-19 22:28:00, Alexey Dobriyan wrote:
[...]
> add/remove: 0/0 grow/shrink: 8/68 up/down: 49/-1147 (-1098)
[...]
> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -15,10 +15,10 @@
>   */
>  
>  struct sighand_struct {
> -	refcount_t		count;
> -	struct k_sigaction	action[_NSIG];
>  	spinlock_t		siglock;
> +	refcount_t		count;
>  	wait_queue_head_t	signalfd_wqh;
> +	struct k_sigaction	action[_NSIG];
>  };

Is it possible that this would cause false sharing of the cache line
that would have performance implications now?

-- 
Michal Hocko
SUSE Labs
