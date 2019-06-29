Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4DD5AD5B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2019 22:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfF2UbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jun 2019 16:31:14 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:40206 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbfF2UbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 16:31:13 -0400
Received: by mail-yw1-f67.google.com with SMTP id b143so6433364ywb.7
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2019 13:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i629r7gTJxO/+Kq0RwO1eyRBAsavtGyQ/SpH7ktnAwA=;
        b=d/7L4F4I32NDBnzSAt3YfLu5nXsK+8wdh6MQ8f/aPfzaBK2JvfLnI99HazHAfIuRW4
         N5vLn10JUOkBDaYrEE1lP4lbyAiQipZNJrXPxuUHcAl62AWcNKS4DAU1utt/nruLPSM9
         3OL31WVe/b0CPIfCzdBCeiSoWn/+oMT0CQbTh3d1ykVUcbtW2f1eocWCXynWRwA6YKWH
         UzLQ6W2iBVzMkbabRPv43cGbpAX3WvqWoYz+8niIS/yc7WMHwdpcbUgg6lFwMrovMc0W
         psG06018KSI6VXzejFoLk+u7SGOP9KC229AltDvGthu+NhXYC5w94qyjw4Lg0Q1UW6Yy
         3Zgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i629r7gTJxO/+Kq0RwO1eyRBAsavtGyQ/SpH7ktnAwA=;
        b=MSw4+LtDqmHvUZ7CqGfx+F+S+2f0ATRs38E4r957RJyQDTfXC7mBDvfVtkPphgq9jR
         PDiAedrWsciUgsvR3jwIlcUV83gMymaXdiQGljTBpTt0ptnmznH87uj/N6eEQ5V+X6g7
         ZzYfBNaoFeo2QooBsQbVB6w2yX8TlcCaTHGJxAzBetBPKbQHZv48GSFAVvMvbKlwcbyx
         QVB5FWPpGhLcEtW39OKDSGKs4Fv6VG0iKGCIKGEKcbojFn2/MXYrrBt/36So3JvIhqNa
         Y2CWREwvpxnPEqBN08UVhEW/vT4FXl/tl8tAU4IfeJs0IJ+Az8ayuP8c7BY7jgz7AQVE
         0PRw==
X-Gm-Message-State: APjAAAVI5LDC1LyoPaoqaQBe/4mL04/Rll1680dWKEFIRJBMDdWMSXe1
        HuklnzjuBKGpwafyXD3fT7QWsPox5uj3Gi7Q5ibeMg==
X-Google-Smtp-Source: APXvYqyksW8gyMphS0LDJ1tzPa1ec1Isygdt7VAYpacgAHQGlgvMROZIXCIqBG4HVtLL4Pf6WNiHwOZRKsuA7rz36E0=
X-Received: by 2002:a81:a55:: with SMTP id 82mr10646311ywk.205.1561840272592;
 Sat, 29 Jun 2019 13:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190629140533.GA10164@avx2>
In-Reply-To: <20190629140533.GA10164@avx2>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sat, 29 Jun 2019 13:31:01 -0700
Message-ID: <CALvZod4PTevdBfEeea6picRvCfo0m5djcigDF3kd21YULKW31g@mail.gmail.com>
Subject: Re: slub: don't panic for memcg kmem cache creation failure
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 29, 2019 at 7:05 AM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> > -       if (flags & SLAB_PANIC)
> > -               panic("Cannot create slab %s size=%u realsize=%u order=%u offset=%u flags=%lx\n",
> > -                     s->name, s->size, s->size,
> > -                     oo_order(s->oo), s->offset, (unsigned long)flags);
>
> This is wrong. Without SLAB_PANIC people will start to implement error
> checking out of habit and add all slightly different error messages.
> This simply increases text and rodata size.
>
> If memcg kmem caches creation failure is OK, then SLAB_PANIC should not
> be passed.
>
> The fact that SLAB doesn't implement SLAB_PANIC is SLAB bug.

I do not agree with you. IMHO the kmem_cache_create_usercopy() is the
right place to handle SLAB_PANIC which is handling it. If you want
extra info here, you can add pr_warn for SLAB_PANIC here and the
caller will still and rightfully do the panic().

thanks,
Shakeel
