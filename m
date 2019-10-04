Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23C1DCBA03
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 14:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730856AbfJDMK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 08:10:26 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42070 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729927AbfJDMK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 08:10:26 -0400
Received: by mail-pf1-f194.google.com with SMTP id q12so3774724pff.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 05:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MONUV9NdASv4E/jp3PLYS1e/RNBJIzL7dOLdp6xf/uE=;
        b=iTtWj+7gGfp6+mPyUyPcmc1lJtdr2PP7Q3oDWr3dme3JCqXTvoY85yKuWWZDqr+5m/
         +JsDgV07ki6BMM0hU84es+Tsw9fZruvIti3HHf1SF5iMPnonCoT+VpH54rRIFPHHNVmP
         7DslUK3E2axvE6afKEKJW1kJNT76E15ro9GIccWL4y+3c9/AAyvVo/KJypKH8SRfU1WS
         n5QWt42Atech8fFN7rbGUdWkMprEE3+0ugj2RMeBAK9W1tUJt2muS7tnFG2UFyeVsfyf
         Qoi6nT5m3WKRNmvn2e0mSyjBD/qHKKVmQMalcby/BF/ww13W9PJX10Y3d9xIyoMIa2cD
         AEwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MONUV9NdASv4E/jp3PLYS1e/RNBJIzL7dOLdp6xf/uE=;
        b=tHz+Jd1GJJOqjXqnz0B5p6cp0rVOu3OYdl4lJJzUBifWX5ZgzhVBazvpf0NptQBOaY
         c/VChrku1MYpOz8j9il5bR0kp1ycD6Po56rvwjAsCP5BN+UpG5gb87luRzoOuJiJ3cmI
         A75SL3uIYUXjIiEyOTDLZXb52KCCt/XOMUgNT4IzWax9HxDJb6R4D62zftgExaf47Xg1
         9tWy7qYPgPvhd/1skyFAPirJFCZml1oc3snHOLLUtGkeGNC3JO8TaHIRVNhQKQeGd8pM
         yvydAZSs0L41OhZfeK4YhSIH3BPJaAt4AZZyN/wWLCSH4ilrD+QD9h9h2u7gL/2Cp0x8
         G4bQ==
X-Gm-Message-State: APjAAAUQEBEU2G3zRi14VGF1j/VLFd95n4j5xxpgE8CiMDRLEFR9pVKT
        sxElMg9Awdrk/qdKULvPUtfcIQ==
X-Google-Smtp-Source: APXvYqzNdLXB1er8H0c7Slwc2yYDYsLUGzWgSjwx36DZdnfkq/ZCVMhUzLC1HtyaiP0lxIoZTRVcSQ==
X-Received: by 2002:a63:2154:: with SMTP id s20mr14813025pgm.379.1570191024502;
        Fri, 04 Oct 2019 05:10:24 -0700 (PDT)
Received: from google.com ([2620:15c:2cd:202:668d:6035:b425:3a3a])
        by smtp.gmail.com with ESMTPSA id x72sm6836120pfc.89.2019.10.04.05.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 05:10:23 -0700 (PDT)
Date:   Fri, 4 Oct 2019 05:10:21 -0700
From:   Michel Lespinasse <walken@google.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     akpm@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        Michael@google.com, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 07/11] vhost: convert vhost_umem_interval_tree to half
 closed intervals
Message-ID: <20191004121021.GA4541@google.com>
References: <20191003201858.11666-1-dave@stgolabs.net>
 <20191003201858.11666-8-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003201858.11666-8-dave@stgolabs.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 01:18:54PM -0700, Davidlohr Bueso wrote:
> @@ -1320,15 +1320,14 @@ static bool iotlb_access_ok(struct vhost_virtqueue *vq,
>  {
>  	const struct vhost_umem_node *node;
>  	struct vhost_umem *umem = vq->iotlb;
> -	u64 s = 0, size, orig_addr = addr, last = addr + len - 1;
> +	u64 s = 0, size, orig_addr = addr, last = addr + len;

maybe "end" or "end_addr" instead of "last".

> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index e9ed2722b633..bb36cb9ed5ec 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -53,13 +53,13 @@ struct vhost_log {
>  };
>  
>  #define START(node) ((node)->start)
> -#define LAST(node) ((node)->last)
> +#define END(node) ((node)->end)
>  
>  struct vhost_umem_node {
>  	struct rb_node rb;
>  	struct list_head link;
>  	__u64 start;
> -	__u64 last;
> +	__u64 end;
>  	__u64 size;
>  	__u64 userspace_addr;
>  	__u32 perm;

Preferably also rename __subtree_last to __subtree_end

Looks good to me otherwise.

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
