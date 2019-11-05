Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF24EF578
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 07:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbfKEGUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 01:20:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:42092 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725806AbfKEGUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 01:20:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 39F60B023;
        Tue,  5 Nov 2019 06:20:23 +0000 (UTC)
Date:   Tue, 5 Nov 2019 07:20:22 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] kernel: sysctl: make drop_caches write-only
Message-ID: <20191105062022.GB22672@dhcp22.suse.cz>
References: <20191031221602.9375-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031221602.9375-1-hannes@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 31-10-19 18:16:02, Johannes Weiner wrote:
> Currently, the drop_caches proc file and sysctl read back the last
> value written, suggesting this is somehow a stateful setting instead
> of a one-time command. Make it write-only, like e.g. compact_memory.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Please add a note about the confusion this has caused already.
The link posted by Chris would be useful as well.

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  kernel/sysctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 31ece1120aa4..50373984a5e2 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1474,7 +1474,7 @@ static struct ctl_table vm_table[] = {
>  		.procname	= "drop_caches",
>  		.data		= &sysctl_drop_caches,
>  		.maxlen		= sizeof(int),
> -		.mode		= 0644,
> +		.mode		= 0200,
>  		.proc_handler	= drop_caches_sysctl_handler,
>  		.extra1		= SYSCTL_ONE,
>  		.extra2		= &four,
> -- 
> 2.23.0

-- 
Michal Hocko
SUSE Labs
