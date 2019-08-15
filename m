Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCB418E8BB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 12:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731379AbfHOKCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 06:02:20 -0400
Received: from foss.arm.com ([217.140.110.172]:41472 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730715AbfHOKCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 06:02:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60E7028;
        Thu, 15 Aug 2019 03:02:19 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9271E3F706;
        Thu, 15 Aug 2019 03:02:18 -0700 (PDT)
Date:   Thu, 15 Aug 2019 11:02:16 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm/kmemleak: record the current memory pool size
Message-ID: <20190815100215.GB9352@arrakis.emea.arm.com>
References: <1565809631-28933-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565809631-28933-1-git-send-email-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 03:07:11PM -0400, Qian Cai wrote:
> The only way to obtain the current memory pool size for a running kernel
> is to check back the kernel config file which is inconvenient. Record it
> in the kernel messages.
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  mm/kmemleak.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index b8bbe9ac5472..1f74f8bcb4eb 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -1967,7 +1967,8 @@ static int __init kmemleak_late_init(void)
>  		mutex_unlock(&scan_mutex);
>  	}
>  
> -	pr_info("Kernel memory leak detector initialized\n");
> +	pr_info("Kernel memory leak detector initialized (mem pool size: %d)\n",
> +		mem_pool_free_count);

I wouldn't actually call it the "memory pool size" as I see the size as
a constant set at config time. What about "memory pool available"?

(even this one is not entirely accurate since we have a
mem_pool_free_list but I expect such list not to have too many elements
at the late_initcall time)

If you change the printed string:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
