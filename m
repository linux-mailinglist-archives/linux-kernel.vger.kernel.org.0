Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 307CD154397
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Feb 2020 12:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbgBFL4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Feb 2020 06:56:41 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46763 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbgBFL4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 06:56:41 -0500
Received: by mail-ot1-f66.google.com with SMTP id g64so5175680otb.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 03:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uMsAapITXkLzJOLckwG4XojxmW0d1pjkgV4d2lZV/fE=;
        b=je7nbPRUzIurBISR1NYTtbJqnOaJQ4blgePkVkAxhJOR6ulsvPl17K4jqdMdXsqHZD
         J+zSsq5WaLrrOawSLfzQmIhC4S8hICmpxOxLejMF+c4DojYJja4JBhGMcRsBBuqqP/g+
         Onr9hXuFP7e5B+xORxzxCo3KFoIlBRUegbaUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uMsAapITXkLzJOLckwG4XojxmW0d1pjkgV4d2lZV/fE=;
        b=ZcoL8jzjVytoYGVVpOOU+yjGfwhVD3EJNhLNWn3vegx5GG/AnCYyvBk0nLbedXf4vo
         yY7yRWEm9nUP36K9II7FqfCwebIWmlex2qIgAaGgOq+5mHOgU429SPplMopnSTiaevSd
         wHvGKN3AnNSiAXzoSUgGuljLHGnCYuRy6j4aRgN2iBL9njlfpgKjNyIuRxzGs9Xa6q5B
         Ab88FuueyHDPn2s2vogYfLR4l+0IAmiK76snCt/OIhqKIXaXx0PVjl8jzCU4RydNIhAX
         AMroOcW8ew94HbKQmSeAFe65xkFNCgXc4Lu9YHfWYG3WiZT1PJmUU9IjAo/FJyB1syH0
         2I7w==
X-Gm-Message-State: APjAAAXydFHJ7Syykfktnwc2tgM/CfKhx5nnIdsKUMGVLxUMPIZ5x0NM
        pKyylL2gKdsrcK6jutQj9P8HsA==
X-Google-Smtp-Source: APXvYqzwToTMXn+aTOh/gblkFv/dlH3X35itT+RX5M+r5t5nmrsjGr3xv3LwBksLl8Co9w1+D/M2Ww==
X-Received: by 2002:a9d:6f07:: with SMTP id n7mr29037601otq.112.1580990198850;
        Thu, 06 Feb 2020 03:56:38 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a5sm1031776otl.45.2020.02.06.03.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 03:56:38 -0800 (PST)
Date:   Thu, 6 Feb 2020 03:56:36 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: [RFC PATCH 08/11] x86: Add support for finer grained KASLR
Message-ID: <202002060353.A6A064A@keescook>
References: <20200205223950.1212394-1-kristen@linux.intel.com>
 <20200205223950.1212394-9-kristen@linux.intel.com>
 <CALCETrVnCAzj0atoE1hLjHgmWjWAKVdSLm-UMtukUwWgr7-N9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVnCAzj0atoE1hLjHgmWjWAKVdSLm-UMtukUwWgr7-N9Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 05:17:11PM -0800, Andy Lutomirski wrote:
> On Wed, Feb 5, 2020 at 2:39 PM Kristen Carlson Accardi
> <kristen@linux.intel.com> wrote:
> >
> > At boot time, find all the function sections that have separate .text
> > sections, shuffle them, and then copy them to new locations. Adjust
> > any relocations accordingly.
> >
> 
> > +       sort(base, num_syms, sizeof(int), kallsyms_cmp, kallsyms_swp);
> 
> Hah, here's a huge bottleneck.  Unless you are severely
> memory-constrained, never do a sort with an expensive swap function
> like this.  Instead allocate an array of indices that starts out as
> [0, 1, 2, ...].  Sort *that* where the swap function just swaps the
> indices.  Then use the sorted list of indices to permute the actual
> data.  The result is exactly one expensive swap per item instead of
> one expensive swap per swap.

I think there are few places where memory-vs-speed need to be examined.
I remain surprised about how much memory the entire series already uses
(58MB in my local tests), but I suspect this is likely dominated by the
two factors: a full copy of the decompressed kernel, and that the
"allocator" in the image doesn't really implement free():
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/decompress/mm.h#n55

-- 
Kees Cook
