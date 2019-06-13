Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 732F843A34
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 17:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388689AbfFMPTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 11:19:33 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42289 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732137AbfFMNAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 09:00:21 -0400
Received: by mail-oi1-f195.google.com with SMTP id s184so14328543oie.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 06:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c4JaIYgXBMbRJcuOmI53AtHtAH/wFo1Lowg4JHM/fXs=;
        b=b72rTZ+ByJZfRwZjRQ5UaaywEAtE+APZpo6ZQg4rsdQSOBLoV3A3yIkOU2jB2Szjia
         tjqp1ER7aHfo3hLOqXgxS8Vu2Vx7YyTfA8ZdUVrsIsFwvJ1cI0qflb/aR5tidqMCsGDx
         tC9r8SZ5PNmrzI9x4K2H+lP3aoptnx4ZLx88AnvZwW9kDyFLcqrIeB06ed6/zaWneNJR
         1tGUmluE2353UZVoeMJqcvg+DlaTQhw+G5AAfuyXg+3Hb6e3uL0BtGjuKVpzrYea8LrG
         eeTa/kxTlbZ9rxW0UOmvuVfo9DM74MV01U7Qh5CGbTLLSJDjyz6QQX2CyFhEjoc8/9eK
         sJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c4JaIYgXBMbRJcuOmI53AtHtAH/wFo1Lowg4JHM/fXs=;
        b=NPsSBUiWtqM1kTOc4n9YQU1HRuQviPatmbFLiyOw09JL8hrfecXGq5GAEz888HevoC
         J4jkZjQmq/8hpi3JYG8FYsuAoXA5v66EBwVhudE9kyrjn9/jHmURk8KAu2drIpkPLv2o
         PUliRJnA2ijPn1pERBx66QjBzFOLTCLZdUEEN/RPT86aHTXfZvs5QERi1KRWbZQmHaIO
         MdRZqcecc4NszNGwp/2EzbtwS7lyXIGcMoafK2FRifH5xDbrRR1AQge0F6DyGiD5rdiu
         CqphvMlJcftWn/93HWPwGFaL5wL0Qnw9m2Zkx8yuY0BvxH/ut5zP+fp9iQ1u0TmwrJRL
         lnIg==
X-Gm-Message-State: APjAAAWcs9AnNyRZkXeTeieqgvU0WHeMOuyH2JRbXGXVgDEKsHNakUD1
        Ca7KNWTdYjO1H1KJ6NwxAYQsx+JUABDd4NxXleZiRw==
X-Google-Smtp-Source: APXvYqwZhR8/zzGl1uZ5/FahKw5EU/Ap2jbcJSkz70UsLe54o/wsW4Si1MtrTTeMtcEzAiC8fsz1xNpuPjBTRVJ9WYA=
X-Received: by 2002:aca:e044:: with SMTP id x65mr2874683oig.70.1560430820644;
 Thu, 13 Jun 2019 06:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190613123028.179447-1-elver@google.com> <20190613123028.179447-2-elver@google.com>
 <6cc5e12d-1492-d9b7-3ea7-6381407439d7@virtuozzo.com>
In-Reply-To: <6cc5e12d-1492-d9b7-3ea7-6381407439d7@virtuozzo.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 13 Jun 2019 15:00:09 +0200
Message-ID: <CANpmjNNMmSHvP+tzod=WeoDp6jsxGsDKV5cXiTr3F9fxEMasaw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] lib/test_kasan: Add bitops tests
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jun 2019 at 14:49, Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
>
>
>
> On 6/13/19 3:30 PM, Marco Elver wrote:
> > This adds bitops tests to the test_kasan module. In a follow-up patch,
> > support for bitops instrumentation will be added.
> >
> > Signed-off-by: Marco Elver <elver@google.com>
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > ---
>
> Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
>
>
>
>
> > +static noinline void __init kasan_bitops(void)
> > +{
> > +     /*
> > +      * Allocate 1 more byte, which causes kzalloc to round up to 16-bytes;
> > +      * this way we do not actually corrupt other memory, in case
> > +      * instrumentation is not working as intended.
>
> This sound like working instrumentation somehow save us from corrupting memory. In fact it doesn't,
> it only reports corruption.

Thanks, I removed the confusing wording. Sent v5.

> > +      */
> > +     long *bits = kzalloc(sizeof(*bits) + 1, GFP_KERNEL);
> > +     if (!bits)
> > +             return;
> > +
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To post to this group, send email to kasan-dev@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/6cc5e12d-1492-d9b7-3ea7-6381407439d7%40virtuozzo.com.
> For more options, visit https://groups.google.com/d/optout.
