Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 681C7C3112
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 12:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730117AbfJAKRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 06:17:19 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34768 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfJAKRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 06:17:18 -0400
Received: by mail-lj1-f194.google.com with SMTP id j19so12755675lja.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 03:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FHRobxW8BCnp6m8ULWiX2Kwd0/E8VfgVZeuErnZpDKE=;
        b=iyTT0tp7ZwvjP8G+F4spWmeJHxWDKn8IoYov8qS3M/3JoIwHRFIOwTk2TDCnxfCmvg
         kqtoeN4WEUL8RDM+qD14oWE+GWzxf97qtHsvMwriDZbFctY9RECXJc8i95eNo7ZxlXTS
         3gQBwD9MGCVvAM7UQfZuHa8ue1DSy9IQa3CfT3qhZdmCLm9/vN+GUp6sq3LiBlGKRNOV
         Y1C3oMggQ4mwGFE+5Bb/8+R76SyLIgzuWmWUY4GothLMvZkALi/xuV1yBltikGINfvbA
         3uv4EgUcP/LZ81r8YRbR57lXhPXY75V8CaxLb5c+fm7TlnfjK8s1RAxQgV7/URKE/cx4
         fOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FHRobxW8BCnp6m8ULWiX2Kwd0/E8VfgVZeuErnZpDKE=;
        b=KGoXRsnfAevINPL7Dt+j0dBTS9/jag0vuwqJ72ZqwqmLlikkb9t0JdkPDkBBm+AL4N
         0QLg0ZFKGp4gTlprn5dWLUse/ATLZ3ZCmfYxit8r407uToQiI8zt3NNdczU+OQK3IEvg
         kDCEQk32FCUIv6IUfDevAbzJhcWAFDXptusBuHG7tTYsXIe1wvTBe34U4I7/S+rQe2er
         uieppsiz9nh0zHasqcNhtWTT/137hlvxA1QziG7knRllYRX6wvvIgadvQPEDqgdvuZx7
         oLUK1VgDVZbSbpYnCSjKYh+LUV2xb76hkehnnMiQqn1FFdt8ZonjUSsVmXn1fj4B2mlZ
         HsGg==
X-Gm-Message-State: APjAAAUDaVcRAcPyFtr8ENF8hQDDxVFqDZ0YuW3nF1+1uLIj4q8h8HRa
        Ua6XSxluICl8FBWpECTUrPw=
X-Google-Smtp-Source: APXvYqyI8sE+R3+orwhB1jbe/FdjLP4QnkV1dOHQo3qbKS7dDFRLVXcdBqSSQImlrl5Pfek3gJaYGA==
X-Received: by 2002:a2e:8084:: with SMTP id i4mr15814978ljg.119.1569925035845;
        Tue, 01 Oct 2019 03:17:15 -0700 (PDT)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id u8sm4877959lfb.36.2019.10.01.03.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 03:17:14 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 1 Oct 2019 12:17:07 +0200
To:     Daniel Axtens <dja@axtens.net>
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org, x86@kernel.org,
        aryabinin@virtuozzo.com, glider@google.com, luto@kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, christophe.leroy@c-s.fr,
        linuxppc-dev@lists.ozlabs.org, gor@linux.ibm.com
Subject: Re: [PATCH v8 1/5] kasan: support backing vmalloc space with real
 shadow memory
Message-ID: <20191001101707.GA21929@pc636>
References: <20191001065834.8880-1-dja@axtens.net>
 <20191001065834.8880-2-dja@axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001065834.8880-2-dja@axtens.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Daniel.

> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index a3c70e275f4e..9fb7a16f42ae 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -690,8 +690,19 @@ merge_or_add_vmap_area(struct vmap_area *va,
>  	struct list_head *next;
>  	struct rb_node **link;
>  	struct rb_node *parent;
> +	unsigned long orig_start, orig_end;
Shouldn't that be wrapped around #ifdef CONFIG_KASAN_VMALLOC?

>  	bool merged = false;
>  
> +	/*
> +	 * To manage KASAN vmalloc memory usage, we use this opportunity to
> +	 * clean up the shadow memory allocated to back this allocation.
> +	 * Because a vmalloc shadow page covers several pages, the start or end
> +	 * of an allocation might not align with a shadow page. Use the merging
> +	 * opportunities to try to extend the region we can release.
> +	 */
> +	orig_start = va->va_start;
> +	orig_end = va->va_end;
> +
The same.

>  	/*
>  	 * Find a place in the tree where VA potentially will be
>  	 * inserted, unless it is merged with its sibling/siblings.
> @@ -741,6 +752,10 @@ merge_or_add_vmap_area(struct vmap_area *va,
>  		if (sibling->va_end == va->va_start) {
>  			sibling->va_end = va->va_end;
>  
> +			kasan_release_vmalloc(orig_start, orig_end,
> +					      sibling->va_start,
> +					      sibling->va_end);
> +
The same.

>  			/* Check and update the tree if needed. */
>  			augment_tree_propagate_from(sibling);
>  
> @@ -754,6 +769,8 @@ merge_or_add_vmap_area(struct vmap_area *va,
>  	}
>  
>  insert:
> +	kasan_release_vmalloc(orig_start, orig_end, va->va_start, va->va_end);
> +
The same + all further changes in this file.
>  	if (!merged) {
>  		link_va(va, root, parent, link, head);
>  		augment_tree_propagate_from(va);
> @@ -2068,6 +2085,22 @@ static struct vm_struct *__get_vm_area_node(unsigned long size,
>  
>  	setup_vmalloc_vm(area, va, flags, caller);
>  
> +	/*
> +	 * For KASAN, if we are in vmalloc space, we need to cover the shadow
> +	 * area with real memory. If we come here through VM_ALLOC, this is
> +	 * done by a higher level function that has access to the true size,
> +	 * which might not be a full page.
> +	 *
> +	 * We assume module space comes via VM_ALLOC path.
> +	 */
> +	if (is_vmalloc_addr(area->addr) && !(area->flags & VM_ALLOC)) {
> +		if (kasan_populate_vmalloc(area->size, area)) {
> +			unmap_vmap_area(va);
> +			kfree(area);
> +			return NULL;
> +		}
> +	}
> +
>  	return area;
>  }
>  
> @@ -2245,6 +2278,9 @@ static void __vunmap(const void *addr, int deallocate_pages)
>  	debug_check_no_locks_freed(area->addr, get_vm_area_size(area));
>  	debug_check_no_obj_freed(area->addr, get_vm_area_size(area));
>  
> +	if (area->flags & VM_KASAN)
> +		kasan_poison_vmalloc(area->addr, area->size);
> +
>  	vm_remove_mappings(area, deallocate_pages);
>  
>  	if (deallocate_pages) {
> @@ -2497,6 +2533,9 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
>  	if (!addr)
>  		return NULL;
>  
> +	if (kasan_populate_vmalloc(real_size, area))
> +		return NULL;
> +
>  	/*
>  	 * In this function, newly allocated vm_struct has VM_UNINITIALIZED
>  	 * flag. It means that vm_struct is not fully initialized.
> @@ -3351,10 +3390,14 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
>  	spin_unlock(&vmap_area_lock);
>  
>  	/* insert all vm's */
> -	for (area = 0; area < nr_vms; area++)
> +	for (area = 0; area < nr_vms; area++) {
>  		setup_vmalloc_vm(vms[area], vas[area], VM_ALLOC,
>  				 pcpu_get_vm_areas);
>  
> +		/* assume success here */
> +		kasan_populate_vmalloc(sizes[area], vms[area]);
> +	}
> +
>  	kfree(vas);
>  	return vms;
>  


--
Vlad Rezki
