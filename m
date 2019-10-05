Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4E9CC77C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2019 05:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfJEDLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 23:11:16 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34982 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfJEDLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 23:11:15 -0400
Received: by mail-pl1-f195.google.com with SMTP id c3so2540269plo.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 20:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KQX6ssbEw4rLSjyECAACt4sR5uTLgduLyfYglqejROU=;
        b=LzM2hIElEkxOtPpwDVT2DteJzLhGZoIhmOvED6f7FUBdryP3QNKo0E9Qzy8gZ24lcC
         4bd59qB/fZTwkTPY5vCbbpbIue/edf3QueWF3TRgs71fHmBjGjRLh6U43pYB6JtFNn5Q
         0UECH8KYCi+pPRqt2dWEwBPgnEBecxvDaOkUc5wuMGi6PCq/fILm9Aw1v/HVAYBtFddB
         py2krAOTPI6TeWuiut3lXiV1rn2D6JqB6wRIpkMUMkhnCw1u+IziW99/fTd0WqaOZGHp
         SM9lsBnys+GZrqcApXk+WwfTIhiDJiNeaMscF1kDidvxmohDbovOZfEVJphgSAn64XJm
         4Paw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=KQX6ssbEw4rLSjyECAACt4sR5uTLgduLyfYglqejROU=;
        b=DVVNcqHVQ8BckZ6MdOUgTga9toWnGwLm6oZvG0+9Xdejrlo156V6UU3frZgTlvxH3D
         7YCm4VNUbEk9o6SGjjhXAu7QplawIapApNaKmcehAKz/oyQV1sT5xiIHG6awmxa3/fTl
         txFHx42q6jNz7TwmdyseSIYs+I74uaJOQnSn8Ia1r+Ga8pDLp+7Hy5WOEXlr7V3xWLfk
         isrM8LJ8+cH/BIz8TCo1j+/OPZT+1ANk5SpaPZbALLC9lQ+jmRcZIt7AkL97IX7Y8IP4
         E7AlAKAUmZlNYktSbQYJut45GGBYSFhnu8XPvMVboJOhv5nlQXBQo0uZLBOFDKVEF+y1
         2/sQ==
X-Gm-Message-State: APjAAAVhQrVh6grk18RMej++VBLkSKsJU6hnx1h7Hf/Hi5tWLramZ40z
        FZh+S7VI2sLpSEqzorzdtNqpvw==
X-Google-Smtp-Source: APXvYqxZhEyYo/OVzVGatSgOuaNVBfycbwx7FTGZFhnh83W0B8BMLVovqtDd37hf8gub90p1o2wIXw==
X-Received: by 2002:a17:902:b589:: with SMTP id a9mr18228253pls.117.1570245074894;
        Fri, 04 Oct 2019 20:11:14 -0700 (PDT)
Received: from [192.168.10.86] (203-206-37-215.dyn.iinet.net.au. [203.206.37.215])
        by smtp.gmail.com with ESMTPSA id 196sm12926660pfz.99.2019.10.04.20.11.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2019 20:11:14 -0700 (PDT)
Subject: Re: [PATCH] kmemleak: Do not corrupt the object_list during clean-up
To:     Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Marc Dionne <marc.c.dionne@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20191004134624.46216-1-catalin.marinas@arm.com>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <5a75249e-47ee-bb7c-d281-31b385d8bb86@ozlabs.ru>
Date:   Sat, 5 Oct 2019 13:11:10 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191004134624.46216-1-catalin.marinas@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/10/2019 23:46, Catalin Marinas wrote:
> In case of an error (e.g. memory pool too small), kmemleak disables
> itself and cleans up the already allocated metadata objects. However, if
> this happens early before the RCU callback mechanism is available,
> put_object() skips call_rcu() and frees the object directly. This is not
> safe with the RCU list traversal in __kmemleak_do_cleanup().
> 
> Change the list traversal in __kmemleak_do_cleanup() to
> list_for_each_entry_safe() and remove the rcu_read_{lock,unlock} since
> the kmemleak is already disabled at this point. In addition, avoid an
> unnecessary metadata object rb-tree look-up since it already has the
> struct kmemleak_object pointer.
> 
> Fixes: c5665868183f ("mm: kmemleak: use the memory pool for early allocations")
> Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Reported-by: Marc Dionne <marc.c.dionne@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>


Tested-by: Alexey Kardashevskiy <aik@ozlabs.ru>

It not just fixed lockups but brought network speed back to normal but I guess it is because kmemleak disables itself
when CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=400.

dmesg:
[    0.000000] kmemleak: Memory pool empty, consider increasing CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE
[    0.000000] kmemleak: Cannot allocate a kmemleak_object structure
[    0.000000] kmemleak: Kernel memory leak detector disabled



> ---
>  mm/kmemleak.c | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index 03a8d84badad..244607663363 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -526,6 +526,16 @@ static struct kmemleak_object *find_and_get_object(unsigned long ptr, int alias)
>  	return object;
>  }
>  
> +/*
> + * Remove an object from the object_tree_root and object_list. Must be called
> + * with the kmemleak_lock held _if_ kmemleak is still enabled.
> + */
> +static void __remove_object(struct kmemleak_object *object)
> +{
> +	rb_erase(&object->rb_node, &object_tree_root);
> +	list_del_rcu(&object->object_list);
> +}
> +
>  /*
>   * Look up an object in the object search tree and remove it from both
>   * object_tree_root and object_list. The returned object's use_count should be
> @@ -538,10 +548,8 @@ static struct kmemleak_object *find_and_remove_object(unsigned long ptr, int ali
>  
>  	write_lock_irqsave(&kmemleak_lock, flags);
>  	object = lookup_object(ptr, alias);
> -	if (object) {
> -		rb_erase(&object->rb_node, &object_tree_root);
> -		list_del_rcu(&object->object_list);
> -	}
> +	if (object)
> +		__remove_object(object);
>  	write_unlock_irqrestore(&kmemleak_lock, flags);
>  
>  	return object;
> @@ -1834,12 +1842,16 @@ static const struct file_operations kmemleak_fops = {
>  
>  static void __kmemleak_do_cleanup(void)
>  {
> -	struct kmemleak_object *object;
> +	struct kmemleak_object *object, *tmp;
>  
> -	rcu_read_lock();
> -	list_for_each_entry_rcu(object, &object_list, object_list)
> -		delete_object_full(object->pointer);
> -	rcu_read_unlock();
> +	/*
> +	 * Kmemleak has already been disabled, no need for RCU list traversal
> +	 * or kmemleak_lock held.
> +	 */
> +	list_for_each_entry_safe(object, tmp, &object_list, object_list) {
> +		__remove_object(object);
> +		__delete_object(object);
> +	}
>  }
>  
>  /*
> 

-- 
Alexey
