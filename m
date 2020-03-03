Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45955177308
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 10:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbgCCJuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 04:50:09 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33500 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728257AbgCCJuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 04:50:09 -0500
Received: by mail-wr1-f65.google.com with SMTP id x7so3526953wrr.0;
        Tue, 03 Mar 2020 01:50:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y99FbCmw9OnfxHbqxZIXhqJVIqMSByuY8qfyzjJA6uY=;
        b=Wva2l0lshsUmNZAHvot2+xBGKy8fq1fI/WESP5+j/0zs5PaXRZ8zZY1WS6Pje67dCY
         vC4zgUpCU4klkhX0Et3BgKjtcW1nw+J/tNntOxtp0P0RNxZzXYCUfWe28jxuSz2iSD4w
         U+Ex/IE+stnDx/INKhKXwm440nXDEElvkwaqjIESVDjhvVCX5DdQa4UzARmLmD/sl43n
         4tggBCBASYL0OxKRtj0mtu7+qwn5Ix3ZtvwntI6+HXNHd0zXqA7Xq1IvEfmcjkZdxAxs
         /p7aD/WlUT7Objm+pfMMrw2gqZ9aTFPg7bRApQhk3aswn5lpWnS+fuRN7Pq/dAhWIsln
         gPCA==
X-Gm-Message-State: ANhLgQ2UPTryJ6eB7ydECFfnaHkowgGWCc+J95sXCxupOfs8FT/OeChX
        BmbNLODPGjs4wo5MLbjmEzQ=
X-Google-Smtp-Source: ADFU+vuwthCqGkSbyuUa0Z+cIz/BhBDMexJ+IcEdZ4dQctXNHctdxSNdlijFijlYre1w0hRSFX3F9Q==
X-Received: by 2002:a5d:4a10:: with SMTP id m16mr4435706wrq.333.1583229006583;
        Tue, 03 Mar 2020 01:50:06 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id u8sm3096766wmm.15.2020.03.03.01.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 01:50:05 -0800 (PST)
Date:   Tue, 3 Mar 2020 10:50:05 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Badger <ebadger@gigaio.com>
Subject: Re: [PATCH v3 1/7] mm/memory_hotplug: Drop the flags field from
 struct mhp_restrictions
Message-ID: <20200303095005.GE4380@dhcp22.suse.cz>
References: <20200221182503.28317-1-logang@deltatee.com>
 <20200221182503.28317-2-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221182503.28317-2-logang@deltatee.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 21-02-20 11:24:57, Logan Gunthorpe wrote:
> This variable is not used anywhere and should therefore be removed
> from the structure.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/memory_hotplug.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index f4d59155f3d4..69ff3037528d 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -55,11 +55,9 @@ enum {
>  
>  /*
>   * Restrictions for the memory hotplug:
> - * flags:  MHP_ flags
>   * altmap: alternative allocator for memmap array
>   */
>  struct mhp_restrictions {
> -	unsigned long flags;
>  	struct vmem_altmap *altmap;
>  };
>  
> -- 
> 2.20.1

-- 
Michal Hocko
SUSE Labs
