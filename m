Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 038F319AEC4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 17:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732877AbgDAPd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 11:33:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37739 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732799AbgDAPd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 11:33:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id w10so584738wrm.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 08:33:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gdjnfPiyLXeZ7G/kh5DpSiOaupsG2u3z0EOcxv3QzYE=;
        b=lnkLtTizHLbCxhz7F/+E9NClYuXQkvozHNM9l4Hoe8XGir6oBzq5NCSD5WeHjg+xEy
         dkkXE6F8eapQlYQiho0mLCJjSJKuHn0Q3jWo7iHd+92pXzxHwcfG7f9NRjf+KBvpJwdf
         80wak5Mbg/kUpfUAESKhiHvv6fo2GiqBU9jlZeZlkVw5BHKBRzpWqV1nQTDRgr2+cZly
         cCI0gr0YDHbnW8i35fpn/XqDJZG4RrB6UXYYymYN9rEexCuwk592VaODtsQfNcluucxr
         BtKpvCZp9stJz6YGtiBxVFH14ArucvT2b4Fj+JFNloHXakS4kTfDkfMgqsd8vfqZXZPq
         7TJg==
X-Gm-Message-State: ANhLgQ3trDUn3A7lqtS/WZ1InCJTslrMJtrXXai6SAr+3NcAFaThrnKS
        F0ybcKu7sWDCF7afSQjq8jU=
X-Google-Smtp-Source: ADFU+vv3tlENYaDpSey9RMPagQoSMJk9l6BD8L/TOufz2eXVKj2AOH0uJ5D1ncq9P1Z7f0u28UA1PA==
X-Received: by 2002:adf:8187:: with SMTP id 7mr27717656wra.358.1585755206200;
        Wed, 01 Apr 2020 08:33:26 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id w9sm3465169wrk.18.2020.04.01.08.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 08:33:25 -0700 (PDT)
Date:   Wed, 1 Apr 2020 17:33:24 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan.c: use update_lru_size() in update_lru_sizes()
Message-ID: <20200401153324.GP22681@dhcp22.suse.cz>
References: <20200331221550.1011-1-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331221550.1011-1-richard.weiyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 31-03-20 22:15:50, Wei Yang wrote:
> We already defined the helper update_lru_size().
> 
> Let's use this to reduce code duplication.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/vmscan.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index f92858e5c2e3..a4fdf3dc8887 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1603,10 +1603,7 @@ static __always_inline void update_lru_sizes(struct lruvec *lruvec,
>  		if (!nr_zone_taken[zid])
>  			continue;
>  
> -		__update_lru_size(lruvec, lru, zid, -nr_zone_taken[zid]);
> -#ifdef CONFIG_MEMCG
> -		mem_cgroup_update_lru_size(lruvec, lru, zid, -nr_zone_taken[zid]);
> -#endif
> +		update_lru_size(lruvec, lru, zid, -nr_zone_taken[zid]);
>  	}
>  
>  }
> -- 
> 2.23.0
> 

-- 
Michal Hocko
SUSE Labs
