Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E793C15A32A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 09:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbgBLIXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 03:23:51 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54696 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728469AbgBLIXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 03:23:50 -0500
Received: by mail-wm1-f65.google.com with SMTP id g1so1034354wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 00:23:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YcczKYnk8/5+6HzLwge2DmQ8UtE5/tLTf5uBW6rS0Uk=;
        b=dio5Rg+kyMREybFXzNBAGU/7Nz3w8rIeccrJuibRbT8fJG5/J8tiYwofS7Ta1eSE0q
         oDRyxKLLvBb0gWh8B58piO1doVo6DahG0X2fzdrGDCjTA9YKTLeIoopAwV+Zh3Klls4A
         a0DqoOc1w6DwYJ45mp59VD4wNqhCLYuaBdt8CTlLw0h7uYQChHelXBf6ecYX+RguQndM
         yAHAxr/kecLZa4pTlNEUJAbifbqlWU/O8AyRQJ3loBYnlNjIRarJSAA0KZ7L4mPuKQRB
         NTC2pBReJEeUk/33IzxtjeDPR+FoekutBTuJGCzTekFkkVt7GudjpS1bAwVlD9WeIFfc
         lfHA==
X-Gm-Message-State: APjAAAWbRH6KRiI0IzXMD+1MfNSZqa7SsoOSGHWOEBG6TiMLqKlGj0JM
        gNaWJ5F3CN+PTVQ177Jc152c4owh
X-Google-Smtp-Source: APXvYqy1qfDdcUtFvF0fcj80udazhBnOTDztB57fRDKuAaR71X00G5KYH2xzD6d/1Dl8WaV4JyT86Q==
X-Received: by 2002:a7b:c5cd:: with SMTP id n13mr11239178wmk.172.1581495828521;
        Wed, 12 Feb 2020 00:23:48 -0800 (PST)
Received: from localhost (ip-37-188-227-72.eurotel.cz. [37.188.227.72])
        by smtp.gmail.com with ESMTPSA id o7sm7006577wmh.11.2020.02.12.00.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 00:23:47 -0800 (PST)
Date:   Wed, 12 Feb 2020 09:23:46 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: vmpressure: use mem_cgroup_is_root API
Message-ID: <20200212082346.GB11353@dhcp22.suse.cz>
References: <1581398649-125989-1-git-send-email-yang.shi@linux.alibaba.com>
 <1581398649-125989-2-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581398649-125989-2-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 11-02-20 13:24:09, Yang Shi wrote:
> Use mem_cgroup_is_root() API to check if memcg is root memcg instead of
> open coding.

Yes, the direct use outside of memcontrol.c should be really an
exception. The only other similar case is cgwb_bdi_init and there is no
easy way to replace - except for adding a helper which is not worth it.

> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/vmpressure.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/vmpressure.c b/mm/vmpressure.c
> index 0590f00..d69019f 100644
> --- a/mm/vmpressure.c
> +++ b/mm/vmpressure.c
> @@ -280,7 +280,7 @@ void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, bool tree,
>  		enum vmpressure_levels level;
>  
>  		/* For now, no users for root-level efficiency */
> -		if (!memcg || memcg == root_mem_cgroup)
> +		if (!memcg || mem_cgroup_is_root(memcg))
>  			return;
>  
>  		spin_lock(&vmpr->sr_lock);
> -- 
> 1.8.3.1
> 

-- 
Michal Hocko
SUSE Labs
