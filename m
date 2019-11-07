Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 147FEF2DCF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 12:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388297AbfKGL6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 06:58:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:57288 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727178AbfKGL6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 06:58:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0039BADBF;
        Thu,  7 Nov 2019 11:58:07 +0000 (UTC)
Date:   Thu, 7 Nov 2019 12:58:06 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Knut Omang <knut.omang@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: provide interface for retrieving kmem_cache name
Message-ID: <20191107115806.GP8314@dhcp22.suse.cz>
References: <20191107115404.3030723-1-knut.omang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107115404.3030723-1-knut.omang@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 07-11-19 12:54:04, Knut Omang wrote:
> With the restructuring done in commit 9adeaa226988
> ("mm, slab: move memcg_cache_params structure to mm/slab.h")
> 
> it is no longer possible for code external to mm to access
> the name of a kmem_cache as struct kmem_cache has effectively become
> opaque. Having access to the cache name is helpful to kernel testing
> infrastructure.
> 
> Expose a new function kmem_cache_name to mitigate that.

Who is going to use that symbol? It is preferred that a user is added in
the same patch as the newly added symbol.

> Signed-off-by: Knut Omang <knut.omang@oracle.com>
> ---
>  include/linux/slab.h | 1 +
>  mm/slab_common.c     | 9 +++++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 4d2a2fa55ed5..3298c9db6e46 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -702,6 +702,7 @@ static inline void *kzalloc_node(size_t size, gfp_t flags, int node)
>  }
>  
>  unsigned int kmem_cache_size(struct kmem_cache *s);
> +const char *kmem_cache_name(struct kmem_cache *s);
>  void __init kmem_cache_init_late(void);
>  
>  #if defined(CONFIG_SMP) && defined(CONFIG_SLAB)
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index f9fb27b4c843..269a99dc8214 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -82,6 +82,15 @@ unsigned int kmem_cache_size(struct kmem_cache *s)
>  }
>  EXPORT_SYMBOL(kmem_cache_size);
>  
> +/*
> + * Get the name of a slab object
> + */
> +const char *kmem_cache_name(struct kmem_cache *s)
> +{
> +	return s->name;
> +}
> +EXPORT_SYMBOL(kmem_cache_name);
> +
>  #ifdef CONFIG_DEBUG_VM
>  static int kmem_cache_sanity_check(const char *name, unsigned int size)
>  {
> -- 
> 2.20.1

-- 
Michal Hocko
SUSE Labs
