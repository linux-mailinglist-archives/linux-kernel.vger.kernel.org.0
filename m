Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E65BDED54
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 15:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbfJUNTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 09:19:40 -0400
Received: from [217.140.110.172] ([217.140.110.172]:52420 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1728616AbfJUNTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:19:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93F7E493;
        Mon, 21 Oct 2019 06:19:17 -0700 (PDT)
Received: from [10.1.194.43] (e112269-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 742083F718;
        Mon, 21 Oct 2019 06:19:16 -0700 (PDT)
Subject: Re: [PATCH] drm/panfrost: fix -Wmissing-prototypes warnings
To:     Yi Wang <wang.yi59@zte.com.cn>, robh@kernel.org
Cc:     tomeu.vizoso@collabora.com, airlied@linux.ie,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        wang.liang82@zte.com.cn, xue.zhihong@zte.com.cn, up2wing@gmail.com
References: <1571470094-39589-1-git-send-email-wang.yi59@zte.com.cn>
From:   Steven Price <steven.price@arm.com>
Message-ID: <8ef85b23-f112-f969-2b3b-2e5e22e868ee@arm.com>
Date:   Mon, 21 Oct 2019 14:19:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1571470094-39589-1-git-send-email-wang.yi59@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2019 08:28, Yi Wang wrote:
> We get these warnings when build kernel W=1:
> drivers/gpu/drm/panfrost/panfrost_perfcnt.c:35:6: warning: no previous prototype for ‘panfrost_perfcnt_clean_cache_done’ [-Wmissing-prototypes]
> drivers/gpu/drm/panfrost/panfrost_perfcnt.c:40:6: warning: no previous prototype for ‘panfrost_perfcnt_sample_done’ [-Wmissing-prototypes]
> drivers/gpu/drm/panfrost/panfrost_perfcnt.c:190:5: warning: no previous prototype for ‘panfrost_ioctl_perfcnt_enable’ [-Wmissing-prototypes]
> drivers/gpu/drm/panfrost/panfrost_perfcnt.c:218:5: warning: no previous prototype for ‘panfrost_ioctl_perfcnt_dump’ [-Wmissing-prototypes]
> drivers/gpu/drm/panfrost/panfrost_perfcnt.c:250:6: warning: no previous prototype for ‘panfrost_perfcnt_close’ [-Wmissing-prototypes]
> drivers/gpu/drm/panfrost/panfrost_perfcnt.c:264:5: warning: no previous prototype for ‘panfrost_perfcnt_init’ [-Wmissing-prototypes]
> drivers/gpu/drm/panfrost/panfrost_perfcnt.c:320:6: warning: no previous prototype for ‘panfrost_perfcnt_fini’ [-Wmissing-prototypes]
> drivers/gpu/drm/panfrost/panfrost_mmu.c:227:6: warning: no previous prototype for ‘panfrost_mmu_flush_range’ [-Wmissing-prototypes]
> drivers/gpu/drm/panfrost/panfrost_mmu.c:435:5: warning: no previous prototype for ‘panfrost_mmu_map_fault_addr’ [-Wmissing-prototypes]
> 
> For file panfrost_mmu.c, make functions static to fix this.
> For file panfrost_perfcnt.c, include head file can fix this.

Nit: s/head/header/

> 
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>

Looks good, just a few minor style issues (below), with those fixed:

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_mmu.c     | 5 +++--
>  drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 1 +
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> index bdd9905..d0458a5 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> @@ -224,7 +224,7 @@ static size_t get_pgsize(u64 addr, size_t size)
>  	return SZ_2M;
>  }
>  
> -void panfrost_mmu_flush_range(struct panfrost_device *pfdev,
> +static void panfrost_mmu_flush_range(struct panfrost_device *pfdev,
>  			      struct panfrost_mmu *mmu,
>  			      u64 iova, size_t size)

Please align the arguments with the '(' as it was before.

>  {
> @@ -432,7 +432,8 @@ void panfrost_mmu_pgtable_free(struct panfrost_file_priv *priv)
>  
>  #define NUM_FAULT_PAGES (SZ_2M / PAGE_SIZE)
>  
> -int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as, u64 addr)
> +static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
> +		u64 addr)

Again, align 'addr' with the '('.

>  {
>  	int ret, i;
>  	struct panfrost_gem_object *bo;
> diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> index 83c57d3..7493dc0 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> @@ -17,6 +17,7 @@
>  #include "panfrost_job.h"
>  #include "panfrost_mmu.h"
>  #include "panfrost_regs.h"
> +#include "panfrost_perfcnt.h"

Please keep header includes sorted alphabetically.

Thanks,

Steve

>  
>  #define COUNTERS_PER_BLOCK		64
>  #define BYTES_PER_COUNTER		4
> 

