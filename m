Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05D17136147
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 20:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731572AbgAITk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 14:40:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:47894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728567AbgAITk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 14:40:57 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FAD4206ED;
        Thu,  9 Jan 2020 19:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578598857;
        bh=X0z3ZMQ6U89MxRIr+jDwpNoWO2V+ca4iynLOUUPipMQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kiA0tICFKwEjBugnYHWXoeGrESRYnKeFMSHRoMBz8Q0B/WLQJRJQy0GhG4Ni0Po0D
         vU9S0/PYcvc1Z70rAgTNoXFUeRDL7p6UQsGcVcHZ6oFCvCy5z/SAF3g5/BWR6cXClH
         qegB1av8Zh/ZCYzV8nXcdiDvlLu1xLyBaBnFk6q8=
Date:   Thu, 9 Jan 2020 11:40:55 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     <linux-mm@kvack.org>, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>
Subject: Re: [PATCH 1/7] mm: kmem: remove duplicate definitions of
 __memcg_kmem_(un)charge()
Message-Id: <20200109114055.67bda2b70d92b07ef13e3047@linux-foundation.org>
In-Reply-To: <20200109172745.285585-2-guro@fb.com>
References: <20200109172745.285585-1-guro@fb.com>
        <20200109172745.285585-2-guro@fb.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jan 2020 09:27:39 -0800 Roman Gushchin <guro@fb.com> wrote:

> For some reason these inline functions are defined twice. Remove
> the second identical copy.

Don't think so - that wouldn't have compiled.

> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1438,15 +1438,6 @@ static inline void memcg_kmem_uncharge(struct page *page, int order)
>  {
>  }
>  
> -static inline int __memcg_kmem_charge(struct page *page, gfp_t gfp, int order)
> -{
> -	return 0;
> -}
> -
> -static inline void __memcg_kmem_uncharge(struct page *page, int order)
> -{
> -}
> -
>  #define for_each_memcg_cache_index(_idx)	\
>  	for (; NULL; )
>  

Maybe you confused these with memcg_kmem_charge() and
memcg_kmem_uncharge()?
