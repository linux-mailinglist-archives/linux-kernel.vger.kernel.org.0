Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4108614F00B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 16:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbgAaPrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jan 2020 10:47:41 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56111 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728974AbgAaPrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 10:47:41 -0500
Received: by mail-wm1-f67.google.com with SMTP id q9so8385884wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 07:47:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3u8hTQfD4sS33VMkuC1P4mm6uuQ9b/xEC2uCOAZWPSQ=;
        b=a15VcwDGCgU/RNZ4fP1luiK04KLQOU7nTw19Vcek/Z1nsal6sXxjGH+oIS0+EQsnh7
         kjufFcN5/V6a1MhYOdp+/ikwnEkj7e5CFo8579PXOvIoG90MDQpK8lZQWldgNYW4vjIs
         b7k+iZMMpcfJYQ+6y1sDrRLaYCVbJDmB+ANESwdBf/UsN5f7zVZywh8rmeI8QLFy80LP
         ePydfrboX8c5g0NDj6w8vTUSCbr0xhqHYxuIntwDZ+OV2PluLOlMvqB1rl3TQvd/nfb1
         24RY64mKIpDkHS9rtEgleYZ1TYF5eP5Yn3faim7F8Co0kOvHe/iqckaodMyDVwT+TwcL
         jqug==
X-Gm-Message-State: APjAAAUth07JW8GhdHCL7vdH0iV6Dc7CL0qq1wrDqGT/YZvTL5FFhN3x
        c7mvg9QYyd9WxTi2O7UeYaY=
X-Google-Smtp-Source: APXvYqxVZ4kbX3o5D6rzM1kzGVJZowhvqQimb9/F99TAiPHnp7TxxGEFyIi2Gtb0ybhZKWX9li5vKg==
X-Received: by 2002:a1c:df41:: with SMTP id w62mr2733578wmg.1.1580485657763;
        Fri, 31 Jan 2020 07:47:37 -0800 (PST)
Received: from localhost (ip-37-188-238-177.eurotel.cz. [37.188.238.177])
        by smtp.gmail.com with ESMTPSA id n12sm11447201wmi.18.2020.01.31.07.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 07:47:36 -0800 (PST)
Date:   Fri, 31 Jan 2020 16:47:35 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, shakeelb@google.com, vdavydov.dev@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: Allocate shrinker_map on appropriate NUMA node
Message-ID: <20200131154735.GA4520@dhcp22.suse.cz>
References: <158047248934.390127.5043060848569612747.stgit@localhost.localdomain>
 <ebe1c944-2e0f-136d-dd09-0bb37d500fe2@redhat.com>
 <5f3fc9a9-9a22-ccc3-5971-9783b60807bc@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f3fc9a9-9a22-ccc3-5971-9783b60807bc@virtuozzo.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 31-01-20 18:00:51, Kirill Tkhai wrote:
[...]
> @@ -333,8 +333,9 @@ static int memcg_expand_one_shrinker_map(struct mem_cgroup *memcg,
>  		/* Not yet online memcg */
>  		if (!old)
>  			return 0;
> -
> -		new = kvmalloc(sizeof(*new) + size, GFP_KERNEL);
> +		/* See comment in alloc_mem_cgroup_per_node_info()*/
> +		tmp = node_state(nid, N_NORMAL_MEMORY) ? nid : NUMA_NO_NODE;
> +		new = kvmalloc_node(sizeof(*new) + size, GFP_KERNEL, tmp);
>  		if (!new)
>  			return -ENOMEM;

I do not think this is a good pattern to copy. Why cannot you simply use
kvmalloc_node with the given node? The allocator should fallback to the
closest node if the given one doesn't have any memory.
-- 
Michal Hocko
SUSE Labs
