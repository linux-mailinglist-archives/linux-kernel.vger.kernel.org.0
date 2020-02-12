Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3FCD159DE2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 01:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgBLATl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 19:19:41 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40526 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727985AbgBLATl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 19:19:41 -0500
Received: by mail-wr1-f65.google.com with SMTP id t3so33795wru.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 16:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kG/6VjOjLVBRMvHNzqFl1V+mWBZNEq0jfxDNEBO+YCw=;
        b=GJMJjn1w3gdDQ3kk4o14S7nIKrx+4ZcEeLdHKkS1BmtFDW+zXOP3nZ7/vpXwPe+8YH
         pmIO/HGERTWJd6/u5+EEMtmwmB4AttuvRtF8tU3MM+kxPPBZfMH9umrB5AZRlTWiS/ar
         Xq0DTBJHfoFxtPO1mCqJUYY+Zr7kkzRj4FK1EpS0yyVR13Ouu2bPFEKbVKpBwfUD2CgZ
         W0v3NrqeDxc2yOlyKP1z70/ds9mPI9oWhsDryg9IQWkh4IU6ahB89JXrduD5WRKcNaOR
         BRXMpV8GR2cHVJM6D3YW6k8aDkMkj57paog5ANf5sVCjYyL54XjKG3DRRqNNDXjHD7sX
         nRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kG/6VjOjLVBRMvHNzqFl1V+mWBZNEq0jfxDNEBO+YCw=;
        b=qZHDOX8q70dkfDaI0gzDTnZlkU3FX1nmNWgQmdNsFegJQvxDM9tSYCJx8x+l9Bim//
         fNGZ9ES2cq9H5G6KjcyxWz2C6PkaUxPkkAZtjRgY8z1P6hAy/PbPbKg8JOUT/WgnPbA1
         CkCdGrwOhDO6KxqLyZc6VBWgC3kx08/5c+/rS2UT4JSiEdprwGKBnZwdJ6XuWiOcmKVJ
         AJoPYfl8IJAi9WxERXsfDPsEAPqSnUNi/MgOy/WyS7bCIIo6yHcaQFc4UkCAdZRQbAN7
         MLzplsv1wgYkC92mz+SUecV2AQ6HjjOUmdxHsdGTYWucar8HINiEz4HerU+Hbf16NtYL
         p2fQ==
X-Gm-Message-State: APjAAAWsYu30gAmFcZwfIK5Bef6T41H66cjiAjeucStFaeL3MDVYvCOX
        y/e5HdixLUUpaIu2mVdN1icyQjEj5WLLgpAIHwGe6g==
X-Google-Smtp-Source: APXvYqwebnuoDdC+VPEVnAnlZZgk0DCv5NKE0oWe8tTJeBdLnnzl64tL8UWmX+Tivb2h1zNL6d+iyatKoHq2mXM6bIk=
X-Received: by 2002:adf:81e3:: with SMTP id 90mr10885572wra.23.1581466779084;
 Tue, 11 Feb 2020 16:19:39 -0800 (PST)
MIME-Version: 1.0
References: <20200115182816.33892-1-trishalfonso@google.com> <CACT4Y+b4+5PQvUeeHi=3g0my0WbaRaNEWY3P-MOVJXYSO7U5aA@mail.gmail.com>
In-Reply-To: <CACT4Y+b4+5PQvUeeHi=3g0my0WbaRaNEWY3P-MOVJXYSO7U5aA@mail.gmail.com>
From:   Patricia Alfonso <trishalfonso@google.com>
Date:   Tue, 11 Feb 2020 16:19:27 -0800
Message-ID: <CAKFsvU+zaY6B_+g=UTpOddKXXgVaKWxH3c8nw6GSLceb1Mg2qA@mail.gmail.com>
Subject: Re: [RFC PATCH] UML: add support for KASAN under x86_64
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        anton.ivanov@cambridgegreys.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-um@lists.infradead.org,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 12:53 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> > +void kasan_init(void)
> > +{
> > +       kasan_map_memory((void *)KASAN_SHADOW_START, KASAN_SHADOW_SIZE);
> > +
> > +       // unpoison the kernel text which is form uml_physmem -> uml_reserved
> > +       kasan_unpoison_shadow((void *)uml_physmem, physmem_size);
> > +
> > +       // unpoison the vmalloc region, which is start_vm -> end_vm
> > +       kasan_unpoison_shadow((void *)start_vm, (end_vm - start_vm + 1));
> > +
> > +       init_task.kasan_depth = 0;
> > +       pr_info("KernelAddressSanitizer initialized\n");
> > +}
>
> Was this tested with stack instrumentation? Stack instrumentation
> changes what shadow is being read/written and when. We don't need to
> get it working right now, but if it does not work it would be nice to
> restrict the setting and leave some comment traces for future
> generations.
If you are referring to KASAN_STACK_ENABLE, I just tested it and it
seems to work fine.

-- 
Patricia Alfonso
