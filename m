Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA6E146DBC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jan 2020 17:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbgAWQDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jan 2020 11:03:05 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41718 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbgAWQDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 11:03:04 -0500
Received: by mail-qk1-f194.google.com with SMTP id s187so1828481qke.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 08:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Zrh7fW80iw6PG+VKgzM4cKv470tUdMXSG6k6nsxdjg=;
        b=VMc+2vTzYUPzJTSit+Uy7zWxTON47r30EWeXHtQkYnjfqTAUCuPIkz/RJcrMaTaNo/
         cezL0bjPwPb9Eb+ho9lUeQXOCAykEZD0bdaqanDZX3iNnow1gAyGTqEDVG5HQO6H5QUv
         WiUC/jg4c04rjDiQucDTEQo9GarRy9clMqM5Gu1VU4FiO1D56vOZ/BOlcoE34HlVEu9W
         N+XyBblBjVTRoZ2i0pXYvYpciyiCkC10Kd9WV1FaQCjKqUgw8PW5X0aBNm8NgPxyS5xQ
         2v5jFQuTWLAP/IY3oRwpFej4XC4lNZzGpH1ALqFmvkk674mPMlzw+vOPLFY5z5AzCl48
         +Q1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Zrh7fW80iw6PG+VKgzM4cKv470tUdMXSG6k6nsxdjg=;
        b=BHCTVfzKvLMozerXNzjafHulJFtqMCBCrC/aYgpB9CvIxNZSpuW5OR4o6GgfJfMB8h
         2DQmYuuDRwAAznrIYbSKC8KtJORowuuzLfaXQxMGscM5hvw0yUnWQx6uHjo+ey/Bv+fJ
         Epz4QtLHG9BwlPfVQPOFKbdwp7SzQpthjruTbiw0/hRVpW5KqHW3GzCIIM4Yzip3ZpiK
         yvD//AuVLfVETszYf12Pns7Wr0tnNHq7Ia3BoISHMxcMFgo564cc7FpM9w/ivtogUwyP
         Zy2bjtuemUKYlMNBAXvIRmagDNYsRQjF7AO6Ga48XUcL6729ZNOBXJIyk2LKezCe73gQ
         QfJw==
X-Gm-Message-State: APjAAAU2rtID2JmZdzOB1xx5emmh9Fx0hvd7GM8U1DvEX83imcofUo+H
        imrYH/rPLOhOTZh7FfOUjVUxECFudtQs/dLSrGPWTA==
X-Google-Smtp-Source: APXvYqwYqKelgW/DCAi+m0okiHtpUyEtiOw/0Z7pRVYCk/auFDOUzCIDIj9a6QxUoQGB4s0kFJuq2/zMZnMzR9iPrlM=
X-Received: by 2002:a37:5841:: with SMTP id m62mr16346928qkb.256.1579795383649;
 Thu, 23 Jan 2020 08:03:03 -0800 (PST)
MIME-Version: 1.0
References: <20200123160115.GA4202@embeddedor>
In-Reply-To: <20200123160115.GA4202@embeddedor>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 23 Jan 2020 17:02:52 +0100
Message-ID: <CACT4Y+bOxBb_fy3jak=prrznOPEbm+nfeq_yUC8yrU+-3RP2UA@mail.gmail.com>
Subject: Re: [PATCH] lib/test_kasan.c: Fix memory leak in kmalloc_oob_krealloc_more()
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <adech.fo@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 4:59 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> In case memory resources for _ptr2_ were allocated, release them
> before return.
>
> Notice that in case _ptr1_ happens to be NULL, krealloc() behaves
> exactly like kmalloc().

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

The scenario where ptr1 is NULL, but ptr2 is not NULL is not impossible indeed.

> Addresses-Coverity-ID: 1490594 ("Resource leak")
> Fixes: 3f15801cdc23 ("lib: add kasan test module")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  lib/test_kasan.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index 328d33beae36..3872d250ed2c 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -158,6 +158,7 @@ static noinline void __init kmalloc_oob_krealloc_more(void)
>         if (!ptr1 || !ptr2) {
>                 pr_err("Allocation failed\n");
>                 kfree(ptr1);
> +               kfree(ptr2);
>                 return;
>         }
>
> --
> 2.25.0
>
