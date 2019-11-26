Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5A4109B66
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 10:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbfKZJmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 04:42:40 -0500
Received: from foss.arm.com ([217.140.110.172]:60338 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727275AbfKZJmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 04:42:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00A3C30E;
        Tue, 26 Nov 2019 01:42:38 -0800 (PST)
Received: from [10.163.1.41] (unknown [10.163.1.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CDA173F52E;
        Tue, 26 Nov 2019 01:42:35 -0800 (PST)
Subject: Re: [PATCH] mm: fix comments related to node reclaim
To:     Hao Lee <haolee.swjtu@gmail.com>, akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20191125142018.GA21373@haolee.github.io>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <cf85d546-3b6c-e172-3624-0e40e0f7699c@arm.com>
Date:   Tue, 26 Nov 2019 15:13:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191125142018.GA21373@haolee.github.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/25/2019 07:50 PM, Hao Lee wrote:
> As zone reclaim has been replaced by node reclaim, this patch fixes related
> comments.
> 
> Signed-off-by: Hao Lee <haolee.swjtu@gmail.com>
> ---
>  include/linux/mmzone.h          | 2 +-
>  include/uapi/linux/capability.h | 2 +-
>  include/uapi/linux/sysctl.h     | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 9e47289a4511..7e3208f4f5bc 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -747,7 +747,7 @@ typedef struct pglist_data {
>  
>  #ifdef CONFIG_NUMA
>  	/*
> -	 * zone reclaim becomes active if more unmapped pages exist.
> +	 * node reclaim becomes active if more unmapped pages exist.
>  	 */
>  	unsigned long		min_unmapped_pages;
>  	unsigned long		min_slab_pages;
> diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capability.h
> index 240fdb9a60f6..dd6772f16eec 100644
> --- a/include/uapi/linux/capability.h
> +++ b/include/uapi/linux/capability.h
> @@ -273,7 +273,7 @@ struct vfs_ns_cap_data {
>  /* Allow enabling/disabling tagged queuing on SCSI controllers and sending
>     arbitrary SCSI commands */
>  /* Allow setting encryption key on loopback filesystem */
> -/* Allow setting zone reclaim policy */
> +/* Allow setting node reclaim policy */

Does this point to the capability for accessing vm.zone_reclaim_mode = 0
sysctl knob ? In that case we should not be changing the name here as the
interface still retains the original name 'zone_reclaim_mode'.

>  
>  #define CAP_SYS_ADMIN        21
>  
> diff --git a/include/uapi/linux/sysctl.h b/include/uapi/linux/sysctl.h
> index 87aa2a6d9125..27c1ed2822e6 100644
> --- a/include/uapi/linux/sysctl.h
> +++ b/include/uapi/linux/sysctl.h
> @@ -195,7 +195,7 @@ enum
>  	VM_MIN_UNMAPPED=32,	/* Set min percent of unmapped pages */
>  	VM_PANIC_ON_OOM=33,	/* panic at out-of-memory */
>  	VM_VDSO_ENABLED=34,	/* map VDSO into new processes? */
> -	VM_MIN_SLAB=35,		 /* Percent pages ignored by zone reclaim */
> +	VM_MIN_SLAB=35,		 /* Percent pages ignored by node reclaim */
>  };
>  
>  
> 
