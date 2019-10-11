Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB8FD46DF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 19:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbfJKRqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 13:46:50 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35881 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728470AbfJKRqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 13:46:50 -0400
Received: by mail-lj1-f194.google.com with SMTP id v24so10662203ljj.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 10:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LgOWyC4KuQvhExdqsSsy/AfsFX2Dxg7AbZdsgfAmHWQ=;
        b=Q2UkfBZSP0S9e/7OB3SF+XNURSwl+NMXpb0vpdXJQjsdW/6qutIw5uECnuvQSRhIfS
         ceZtY1Swy2zbGPAzUqBps7PsUDeS/0EuPPnU0Fy92rdos/7lz0dqKIiPx08pFFvzsTUD
         k3cf62WY2m182EbDTriMmjsXhjGoXoDCawAIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LgOWyC4KuQvhExdqsSsy/AfsFX2Dxg7AbZdsgfAmHWQ=;
        b=lKPlj9u3OWWXDIhK6QGcDrs3UL0fHs3FRPvNgRm7r00yz8gONRULe74XEbLIVN0bOl
         rO2hjnWTxpiQ+9UIgfR4vMH6kztzYnbv1fL416Cl0TwQz8KYNpDPu9oL3oXrQLY93NXI
         ly7E5mswSLe7Kv22qg2dwXptdsyu7Rs4Eqkh/fi+guAnFLxNF9mv4j5pqMrDiTVDpWeZ
         5+TmhDvYz/bXbIBpTYPdqzFuY4z/r0x4logjqHF2zU8x1un3tQDzTzTo0zBjttg/dyAs
         4q0otByQiYRAsazrWI+AIH0h/ZCI2g6/NbYy6iIdvRV/Ba7JYcPTFvhxC7as5RyUO+iJ
         cmDA==
X-Gm-Message-State: APjAAAV8Fdg4kTzogTGuaXEuTX9VEqS3YpGULYfVXp9SwjJzix22lTk4
        +3YsjDu9mlqoLL1laF0r5Miagb71t1k=
X-Google-Smtp-Source: APXvYqwy0gTR/1PXW5KtF1L2E4XyvyOw+u0VD5KM39zaDuAfL1Cg2JagfnQXiuAyZeOzJOJCDFtsDQ==
X-Received: by 2002:a2e:8602:: with SMTP id a2mr10358382lji.20.1570816007711;
        Fri, 11 Oct 2019 10:46:47 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id 3sm2166897ljs.20.2019.10.11.10.46.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2019 10:46:47 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id f5so10648823ljg.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 10:46:47 -0700 (PDT)
X-Received: by 2002:a2e:6a04:: with SMTP id f4mr9892356ljc.97.1570816006661;
 Fri, 11 Oct 2019 10:46:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1570292505.git.joe@perches.com> <CAHk-=whOF8heTGz5tfzYUBp_UQQzSWNJ_50M7-ECXkfFRDQWFA@mail.gmail.com>
 <9fe980f7e28242c2835ffae34914c5f68e8268a7.camel@perches.com>
In-Reply-To: <9fe980f7e28242c2835ffae34914c5f68e8268a7.camel@perches.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Oct 2019 10:46:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi1T1m-su8zK5LeESoz_Pgf1-4hnjr516NiDLNyb4USug@mail.gmail.com>
Message-ID: <CAHk-=wi1T1m-su8zK5LeESoz_Pgf1-4hnjr516NiDLNyb4USug@mail.gmail.com>
Subject: Re: [PATCH 0/4] treewide: Add 'fallthrough' pseudo-keyword
To:     Joe Perches <joe@perches.com>
Cc:     linux-sctp@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pavel Machek <pavel@ucw.cz>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Shawn Landden <shawn@git.icu>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 10:43 AM Joe Perches <joe@perches.com> wrote:
>
> Shouldn't a conversion script be public somewhere?

I feel the ones that might want to do the conversion on their own are
the ones that don't necessarily trust the script.

But I don't even know if anybody does want to, I just feel it's an option.

              Linus
