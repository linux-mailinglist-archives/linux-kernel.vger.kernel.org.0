Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7D3D641A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 15:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731845AbfJNN3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 09:29:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:49092 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730070AbfJNN3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 09:29:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D696BBABC;
        Mon, 14 Oct 2019 13:29:04 +0000 (UTC)
Date:   Mon, 14 Oct 2019 15:29:04 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1] drivers/base/memory.c: Don't access uninitialized
 memmaps in soft_offline_page_store()
Message-ID: <20191014132904.GI317@dhcp22.suse.cz>
References: <20191010141200.8985-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010141200.8985-1-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 10-10-19 16:12:00, David Hildenbrand wrote:
> Uninitialized memmaps contain garbage and in the worst case trigger kernel
> BUGs, especially with CONFIG_PAGE_POISONING. They should not get
> touched.
> 
> Right now, when trying to soft-offline a PFN that resides on a memory
> block that was never onlined, one gets a misleading error with
> CONFIG_PAGE_POISONING:
>   :/# echo 5637144576 > /sys/devices/system/memory/soft_offline_page
>   [   23.097167] soft offline: 0x150000 page already poisoned
> 
> But the actual result depends on the garbage in the memmap.
> 
> soft_offline_page() can only work with online pages, it returns -EIO in
> case of ZONE_DEVICE. Make sure to only forward pages that are online
> (iow, managed by the buddy) and, therefore, have an initialized memmap.
> 
> Add a check against pfn_to_online_page() and similarly return -EIO.
> 
> Fixes: f1dd2cd13c4b ("mm, memory_hotplug: do not associate hotadded memory to zones until online") # visible after d0dc12e86b319
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  drivers/base/memory.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 6bea4f3f8040..55907c27075b 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -540,6 +540,9 @@ static ssize_t soft_offline_page_store(struct device *dev,
>  	pfn >>= PAGE_SHIFT;
>  	if (!pfn_valid(pfn))
>  		return -ENXIO;
> +	/* Only online pages can be soft-offlined (esp., not ZONE_DEVICE). */
> +	if (!pfn_to_online_page(pfn))
> +		return -EIO;
>  	ret = soft_offline_page(pfn_to_page(pfn), 0);
>  	return ret == 0 ? count : ret;
>  }
> -- 
> 2.21.0

-- 
Michal Hocko
SUSE Labs
