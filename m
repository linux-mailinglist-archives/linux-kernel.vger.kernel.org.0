Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39D83E5575
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 22:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfJYUvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 16:51:35 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:37019 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfJYUvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 16:51:35 -0400
Received: by mail-vs1-f65.google.com with SMTP id e12so2382169vsr.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 13:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SOwCMPM2O4ZOlwd3DBrA7iEvzDojcSJWVcNWTrD2V3A=;
        b=OMpIHy666PHw9erjn8xDTPpke8xQntbqoetTb755EO9PeDOpXuqP6XhDAI7uUr5fO2
         xmVL8gs1k0UTMM90x7YH/5ifo3akIvmtUP3P99Y8UkXss+I/VMnYl83cvTyhYTBE+xXo
         cZnJNJr5EGcHbCKDOw5qzZmWgscClEDk8K70pc2sU5/7TsNOz3qMBup0ghahhpvfFUWg
         vkZUy83KnTruoWWThCWKQaNjwulexQFfxNHsd7rgNtxCf3BUJ3Swu+Hls5xYOIdyzbqN
         pTUp3jauqQWIFYhE31Un5fjVTn41lvbrOA703W64zMOhKqcxNHtTJHVm5pwg8QOK9PnF
         Ba7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SOwCMPM2O4ZOlwd3DBrA7iEvzDojcSJWVcNWTrD2V3A=;
        b=p4APuxsOn/nVopJmYZuvy9VEM/OA2m/t3N69ZFt46ii2Oq8GdH2F4uHTT5GHZFdP8z
         TQFHm9z5YTUpVzhsa30C9hd3tWF1Nbz5WExBt0K4Wb8j2MKOHs4LU7Z++HPYM8yXG6no
         ZAkIvxOjwA1LyO3ZFB2/5H1lwZBdwaHavOpkz/UuB8Y9xj2HdK9QB4e5kzAa3GpOIR+w
         9wXgNHMeESx/TVtdmzFpN1/Yie3hWqj3eKYVsPQqG3y84Y1IHG4QTIUMQcXPPJBtHKZw
         oXF8gaK5uEpKspvKkGWsZx5TgdluVCYlewCgR9i7RjH2GxCvkuqW0/L7hkTEBqFpQkim
         Dpjw==
X-Gm-Message-State: APjAAAVx433krlqdlNJ0JTJW4UaRmdx4LGUlkpMxF+VAQCQ8wevrfQAZ
        /Ke+rDD2E0Lhhec6uoAfem43yk+B2W1XNG6lX+otNg==
X-Google-Smtp-Source: APXvYqwitHy/uW9BgFO85xlL31gu4CkfssJm5Y58pk3pu/OFECEhzo8ZcmTg1xeRhUyxbxF5+qEX2qRHXCg/5F+6CB8=
X-Received: by 2002:a67:ed8b:: with SMTP id d11mr3107850vsp.104.1572036693631;
 Fri, 25 Oct 2019 13:51:33 -0700 (PDT)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191024225132.13410-1-samitolvanen@google.com> <20191024225132.13410-6-samitolvanen@google.com>
 <CAKwvOdmfXbnWf0dPN4EGCBVvppVRhuc=eq-pbfmotCCBaRN-Cw@mail.gmail.com>
In-Reply-To: <CAKwvOdmfXbnWf0dPN4EGCBVvppVRhuc=eq-pbfmotCCBaRN-Cw@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 25 Oct 2019 13:51:22 -0700
Message-ID: <CABCJKufR04dmzj3-7Uw0QkcHXvNd6h8XMPVV-hZ-AyOX-CJcjA@mail.gmail.com>
Subject: Re: [PATCH v2 05/17] add support for Clang's Shadow Call Stack (SCS)
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 9:22 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
> > +static void scs_free(void *s)
> > +{
> > +       int i;
> > +
> > +       for (i = 0; i < SCS_CACHE_SIZE; i++) {
> > +               if (this_cpu_cmpxchg(scs_cache[i], 0, s) != 0)
> > +                       continue;
> > +
> > +               return;
> > +       }
>
> prefer:
>
> for ...:
>   if foo() == 0:
>     return
>
> to:
>
> for ...:
>   if foo() != 0:
>     continue
>   return

This was essentially copied from free_thread_stack in kernel/fork.c,
but I agree, your way is cleaner. I'll change this in the next
version. Thanks!

Sami
