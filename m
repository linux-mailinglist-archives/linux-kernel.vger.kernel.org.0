Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC9A67082
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2019 15:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfGLNuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jul 2019 09:50:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51218 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfGLNuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 09:50:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fnnfXjFvjoDoIQnQuaRvGkZvYrw5HXbBFVcsaXovgKE=; b=cxBzmFcOfyCVzsiypcmiuOaB4
        1fMOmo+ZpbRPzJh+dTAYCbGidK6YiB8fbVv+neUEMBO1XgD5lFgobanIPl08Mxk/kB4jbRHgSXVIu
        aCrx/4k1V+9nWoRLBofxtdG0zd64VyyVgfuiwVS4CYteqh5B/2nbBOW5hf5MTuWwDcRHDCn+/Nc3s
        kYe9yq9chH57EPO3w0dPdAmX2U5O3eJJvSfg/Gh1ezFs3FNLWsIKC+otRLOEJ92WvN6OkgNGvm8zt
        FQ0G1NL4KUEWiWWE3e355AGY9P4U+l/lSbUFWthv4KVBi3Bml3xpaj7zCqeXdvrhPgklF9DUhNVjI
        jOn4gFOmA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hlvvv-0007EF-C1; Fri, 12 Jul 2019 13:49:55 +0000
Date:   Fri, 12 Jul 2019 06:49:55 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Pengfei Li <lpf.vector@gmail.com>
Cc:     akpm@linux-foundation.org, urezki@gmail.com, rpenyaev@suse.de,
        peterz@infradead.org, guro@fb.com, rick.p.edgecombe@intel.com,
        rppt@linux.ibm.com, aryabinin@virtuozzo.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] mm/vmalloc.c: Modify struct vmap_area to reduce
 its size
Message-ID: <20190712134955.GV32320@bombadil.infradead.org>
References: <20190712120213.2825-1-lpf.vector@gmail.com>
 <20190712120213.2825-3-lpf.vector@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712120213.2825-3-lpf.vector@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 08:02:13PM +0800, Pengfei Li wrote:
> +++ b/include/linux/vmalloc.h
> @@ -51,15 +51,37 @@ struct vmap_area {
>  	unsigned long va_start;
>  	unsigned long va_end;
>  
> -	/*
> -	 * Largest available free size in subtree.
> -	 */
> -	unsigned long subtree_max_size;
> -	unsigned long flags;
> -	struct rb_node rb_node;         /* address sorted rbtree */
> -	struct list_head list;          /* address sorted list */
> -	struct llist_node purge_list;    /* "lazy purge" list */
> -	struct vm_struct *vm;
> +	union {
> +		/* In rbtree and list sorted by address */
> +		struct {
> +			union {
> +				/*
> +				 * In "busy" rbtree and list.
> +				 * rbtree root:	vmap_area_root
> +				 * list head:	vmap_area_list
> +				 */
> +				struct vm_struct *vm;
> +
> +				/*
> +				 * In "free" rbtree and list.
> +				 * rbtree root:	free_vmap_area_root
> +				 * list head:	free_vmap_area_list
> +				 */
> +				unsigned long subtree_max_size;
> +			};
> +
> +			struct rb_node rb_node;
> +			struct list_head list;
> +		};
> +
> +		/*
> +		 * In "lazy purge" list.
> +		 * llist head: vmap_purge_list
> +		 */
> +		struct {
> +			struct llist_node purge_list;
> +		};

I don't think you need struct union struct union.  Because llist_node
is just a pointer, you can get the same savings with just:

	union {
		struct llist_node purge_list;
		struct vm_struct *vm;
		unsigned long subtree_max_size;
	};

