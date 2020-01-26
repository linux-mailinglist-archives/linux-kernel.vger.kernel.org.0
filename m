Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A82F2149D6A
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jan 2020 23:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbgAZWoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jan 2020 17:44:34 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44500 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgAZWod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 17:44:33 -0500
Received: by mail-pl1-f193.google.com with SMTP id d9so3043192plo.11
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jan 2020 14:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=TjEZMOqVvMiaHfNHrbmYpQxyaSRI+vukKCsubEmmQJg=;
        b=LiZhUOIecHLFKlKOf5LwM4AY0QJraXq2Eq6Cz5mZp25Tz4Ct5naIHG+lpYNxphSzKQ
         75RjI+ggnHay5WPKmLtXxy05GkRnAgPzrxeM2eTYq6HFEjrjOWJu/m9x6pbkqD7fQOMW
         cQ4RExcCIJA8/9chPkONZEGXG6KNC/8JxBPjt2Nyik+qLMoIZ4x6iaIjrjQ/0RxhUmnF
         PTHQ8GqWkAQFZXiv8jLRjP7JQrjC6qXzIpz/Xon+MgyOPWF77OpSYfWjtd7tziFvfUjT
         3mrkaCVOJTlsSI5o3TZucd+TGTlTesn54wOY08+xPnAD5ROcAHy39E7pNY63xQDZ490F
         n8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=TjEZMOqVvMiaHfNHrbmYpQxyaSRI+vukKCsubEmmQJg=;
        b=iN3E+IsUwo+J+lBuZveP2siu/U/YP+dv2djJi75k1R3PTDqJAzQuF79CuIyzir20VZ
         eFIMp2FPLYwCAQlMF446R/X6F+tKrsV2bMvVWj5WoCf2PXDvtRqOkNtZtZnnOgIe2SGo
         YdBmoO35uF7F37kDueG06QRsA8UWxzKm6mQsr+C7zM0fHfH6dQBk/9dG3mB2ATEhUT5Y
         iZ4SQYGDjig+7VGwmCo9YrsjHngURoRwT3qzewwdOelwTc/weBqU8FseWeLcJoLmg0gp
         ygkhZBXeuMoZHu96uXYJdRYcLuRgxmTMRT+6jwSXHA7/z0o3/TG1iUncNGiiHFkUKDaK
         jtkw==
X-Gm-Message-State: APjAAAUYaMSt7bEk5uvMzW6G7zAUPDFl2nca6Z1cL5JcJJVoszYwLL6N
        To/69HxpF9GygO4lGiXsa7XqSw==
X-Google-Smtp-Source: APXvYqymcVkWc2j+nwHmc4kt3i9+hl/OwHr2T5KYyyAMvu+vzhgyFwQPyThZ4nxIELGcRxsX0v/QMg==
X-Received: by 2002:a17:90a:e2d4:: with SMTP id fr20mr11737424pjb.85.1580078672716;
        Sun, 26 Jan 2020 14:44:32 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id q6sm13303717pgt.47.2020.01.26.14.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2020 14:44:31 -0800 (PST)
Date:   Sun, 26 Jan 2020 14:44:31 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Wei Yang <richardw.yang@linux.intel.com>
cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan.c: only adjust related kswapd cpu affinity
 when online cpu
In-Reply-To: <20200126132052.11921-1-richardw.yang@linux.intel.com>
Message-ID: <alpine.DEB.2.21.2001261443020.164983@chino.kir.corp.google.com>
References: <20200126132052.11921-1-richardw.yang@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Jan 2020, Wei Yang wrote:

> When onlining a cpu, kswapd_cpu_online() is called to adjust kswapd cpu
> affinity.
> 
> Current routine does like this:
> 
>   * Iterate all the numa node
>   * Adjust cpu affinity when node has an online cpu
> 
> Actually we could improve this by:
> 
>   * Just adjust the numa node to which current online cpu belongs
> 
> Because we know which numa node the cpu belongs to and this cpu would
> not affect other node.
> 

Is there ever a situation where the cpu to be onlined would have appeared 
in the cpumask of another node and so a different kswapd's cpumask would 
now include an off-node cpu?

> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  mm/vmscan.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 572fb17c6273..19c92d35045c 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4049,18 +4049,19 @@ unsigned long shrink_all_memory(unsigned long nr_to_reclaim)
>     restore their cpu bindings. */
>  static int kswapd_cpu_online(unsigned int cpu)
>  {
> -	int nid;
> +	int nid = cpu_to_node(cpu);
> +	pg_data_t *pgdat;
> +	const struct cpumask *mask;
>  
> -	for_each_node_state(nid, N_MEMORY) {
> -		pg_data_t *pgdat = NODE_DATA(nid);
> -		const struct cpumask *mask;
> +	if (!node_state(nid, N_MEMORY))
> +		return 0;
>  
> -		mask = cpumask_of_node(pgdat->node_id);
> +	pgdat = NODE_DATA(nid);
> +	mask = cpumask_of_node(nid);
> +
> +	/* One of our CPUs online: restore mask */
> +	set_cpus_allowed_ptr(pgdat->kswapd, mask);
>  
> -		if (cpumask_any_and(cpu_online_mask, mask) < nr_cpu_ids)
> -			/* One of our CPUs online: restore mask */
> -			set_cpus_allowed_ptr(pgdat->kswapd, mask);
> -	}
>  	return 0;
>  }
>  
> -- 
> 2.17.1
> 
> 
> 
