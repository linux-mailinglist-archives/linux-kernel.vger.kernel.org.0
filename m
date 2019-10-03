Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7DBCAFA6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 21:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387907AbfJCT4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Oct 2019 15:56:54 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33173 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730707AbfJCT4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 15:56:54 -0400
Received: by mail-pg1-f196.google.com with SMTP id q1so2407037pgb.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 12:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=FpqHOIoVU1737EmyU07jel9c07Q0bDOX22emmTBHpLI=;
        b=a1EJxm/Q0JDE4y2LZEksHOUr95u4m/JhwoWf161iHSLEn/XdooAn8mwqlTlUV7K4H1
         ZZUT//1ZMdb3ES/TcgoKtxZFDt9IFo2MOhEXK5FnCpSRwtZ6I5oNaRmHBgO4shL/YNPr
         UX7re8kEjMF4wUBSh21qZWFHvgIq3W4GuGpWPkFF79Zs51fSXJf+I39jYdeiIE6LrrCE
         ZD3pwkOMdi6hy1ZVJcb0rEdOpZT4QLchUdC+kvMT2w2KdhJIsXxKfi7hpZFIFe+51/nr
         B9WidoqGrPGmEnOa3YWLw+5XBEuwHpx1S6MWKMbMaUqvmGcMabJwCdqhC7lWxgAA7L2G
         rtFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=FpqHOIoVU1737EmyU07jel9c07Q0bDOX22emmTBHpLI=;
        b=jXspaqDYnpn1hjvuU8KowP0ZUbsTCEq5IH3L/7xu6YTasa6b2vsWXuPvTFkeLtOELX
         Lj3Vt/3Tlnxe1W3cAvJ/iRWJOC2E8PITxUtWYeu7qU2CmR8dfOWRJ926w4cRpI3q0pzt
         iZlIFE82n/QRApxAuBUrii2qO5AyNfyrFo5XfoNCCuTV/o01s6YsTgbws6MniAaz1CZg
         /hE7y9HDOlupuD8Wbzbn6+klimntWB2503CeyKaHSldRX3HKzWLQI4w61rsFff/jMonB
         WaHX1jfQMUVxSEVrVNSokRXV1JLIIU9xyqxDOZOJ2XEv32DsH7Dt/KR6oAmcW+ro5sMQ
         h6Jw==
X-Gm-Message-State: APjAAAWCShulJ2aZXIa8xvux56eowz38O8d9uxik8jWA+Wu6bFtquaDd
        piTkqP38r6l7fSmxORQJeMLwKg==
X-Google-Smtp-Source: APXvYqxablx3usrIF1UrUs/DTDaAacGZmTd1VN3KZfp72pueBlxewGznpyo0qDgZG6mnbSI7vFbfVw==
X-Received: by 2002:a17:90a:890c:: with SMTP id u12mr12527842pjn.121.1570132612836;
        Thu, 03 Oct 2019 12:56:52 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id b18sm3350336pfi.157.2019.10.03.12.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 12:56:52 -0700 (PDT)
Date:   Thu, 3 Oct 2019 12:56:51 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Qian Cai <cai@lca.pw>
cc:     akpm@linux-foundation.org, cl@linux.com, penberg@kernel.org,
        tj@kernel.org, vdavydov.dev@gmail.com, hannes@cmpxchg.org,
        guro@fb.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: fix a deadlock in show_slab_objects()
In-Reply-To: <1570131869-2545-1-git-send-email-cai@lca.pw>
Message-ID: <alpine.DEB.2.21.1910031255100.88296@chino.kir.corp.google.com>
References: <1570131869-2545-1-git-send-email-cai@lca.pw>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Oct 2019, Qian Cai wrote:

> diff --git a/mm/slub.c b/mm/slub.c
> index 42c1b3af3c98..922cdcf5758a 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4838,7 +4838,15 @@ static ssize_t show_slab_objects(struct kmem_cache *s,
>  		}
>  	}
>  
> -	get_online_mems();
> +/*
> + * It is not possible to take "mem_hotplug_lock" here, as it has already held
> + * "kernfs_mutex" which could race with the lock order:
> + *
> + * mem_hotplug_lock->slab_mutex->kernfs_mutex
> + *
> + * In the worest case, it might be mis-calculated while doing NUMA node
> + * hotplug, but it shall be corrected by later reads of the same files.
> + */
>  #ifdef CONFIG_SLUB_DEBUG
>  	if (flags & SO_ALL) {
>  		struct kmem_cache_node *n;

No objection to removing the {get,put}_online_mems() but the comment 
doesn't match the kernel style.  I actually don't think we need the 
comment at all, actually.

> @@ -4879,7 +4887,6 @@ static ssize_t show_slab_objects(struct kmem_cache *s,
>  			x += sprintf(buf + x, " N%d=%lu",
>  					node, nodes[node]);
>  #endif
> -	put_online_mems();
>  	kfree(nodes);
>  	return x + sprintf(buf + x, "\n");
>  }
