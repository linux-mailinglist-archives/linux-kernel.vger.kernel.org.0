Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA2BF829C7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 04:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730733AbfHFC4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 22:56:00 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36364 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728870AbfHFC4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 22:56:00 -0400
Received: by mail-ed1-f66.google.com with SMTP id k21so80932289edq.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 19:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegavinli.com; s=google;
        h=sender:mime-version:references:in-reply-to:from:date:message-id
         :subject:to:cc;
        bh=ymynYvUaAJ/fSsk8dTF47gjXr8CYua8YobOOSKegPcM=;
        b=UanfDFFyXJgYSA7QqCuSdaCf5p+I3v2GUlvbhA8+2qe6l86pJKL0lTlbCFnTx3gBOk
         jjw0CPJdEKovLTwXtm6Go48h8/Y8NunT8oKKFGaMd9OyBH8HT4SxYQbIV6jerO9zgRB+
         DhQfv6wnIBUjLqio5JTWuVL4Tjft7woEGwUdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:mime-version:references:in-reply-to:from
         :date:message-id:subject:to:cc;
        bh=ymynYvUaAJ/fSsk8dTF47gjXr8CYua8YobOOSKegPcM=;
        b=DEzqe45EbHiUEwvmKs2DJprsMa2yDxU2ApGesGKPbFHnzkAoimYDRbJBD7SZmK7Smu
         kAD3vy+UBBUmcyu9iGilgFfj98kpd+NBDsAf4HAHq3rCKT5yPMk4t6ka0yrDcIfaRyE+
         HuvqLWNGcU0XPxX+nmwfAwGmvGY8n+UvcQdg7haOIECk95iYezMVpCGePgDF4FiF5dnq
         vLKovV6PiUI73kx0Wwes03FuEccziA2V3g/j39zQ8lbsCjBk30bGUZidbTNebCan3bvs
         ks6NwgjAC0sPVcTODmVVwEto142u5wZLN4pZYygPPjD81wnjh2rcgQC4fCUnfuefIIJ6
         uKAQ==
X-Gm-Message-State: APjAAAXRu0eNuH1splcYwZ+J+LRTgphpfHgcljQYzTTiuyeafi31tw01
        VlxurTkgCMZKG0TH+sHXsU5PYw==
X-Google-Smtp-Source: APXvYqwCQ/MXwCzExS5dUl/Wau0R2IDrgb+fZVtZ3SzyY0Yt7wlLBRDhvpUMbujiF6VcO+U3M2RlWg==
X-Received: by 2002:aa7:d781:: with SMTP id s1mr1523685edq.20.1565060158213;
        Mon, 05 Aug 2019 19:55:58 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id 17sm20458990edu.21.2019.08.05.19.55.55
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 19:55:57 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id v15so80947545eds.9;
        Mon, 05 Aug 2019 19:55:55 -0700 (PDT)
X-Received: by 2002:a17:906:b315:: with SMTP id n21mr1014103ejz.312.1565060155502;
 Mon, 05 Aug 2019 19:55:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190805080145.5694-1-hch@lst.de> <20190805080145.5694-2-hch@lst.de>
 <CAP_+7SzPdNCMKuuXMjHjpCzxsey2YWR_e6mTAWtNSZ6kKBvKFw@mail.gmail.com>
In-Reply-To: <CAP_+7SzPdNCMKuuXMjHjpCzxsey2YWR_e6mTAWtNSZ6kKBvKFw@mail.gmail.com>
From:   Gavin Li <gavinli@thegavinli.com>
Date:   Mon, 5 Aug 2019 19:55:44 -0700
X-Gmail-Original-Message-ID: <CA+GxvY5C_rrukCzC5K-h72bePyW8PS_Rfj3uxh-K6UrcAextUQ@mail.gmail.com>
Message-ID: <CA+GxvY5C_rrukCzC5K-h72bePyW8PS_Rfj3uxh-K6UrcAextUQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dma-mapping: fix page attributes for dma_mmap_*
To:     Christoph Hellwig <hch@lst.de>
Cc:     Shawn Anastasio <shawn@anastas.io>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Gavin Li <git@thegavinli.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>         /* create a coherent mapping */
>         ret = dma_common_contiguous_remap(page, size, VM_USERMAP,
> -                       arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs),
> +                       dma_pgprot(dev, PAGE_KERNEL, attrs),
>                         __builtin_return_address(0));
>         if (!ret) {
>                 __dma_direct_free_pages(dev, size, page);

Is dma_common_contiguous_remap() still necessary in the
DMA_ATTR_NON_CONSISTENT case? I would presume it would be fine to just
return a linearly mapped address in that case.
