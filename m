Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C128D92E9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 15:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405530AbfJPNtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 09:49:53 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44868 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfJPNtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 09:49:53 -0400
Received: by mail-pg1-f196.google.com with SMTP id e10so10349440pgd.11;
        Wed, 16 Oct 2019 06:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Tj/U4wMEMDKOxq40ZfhlaqeOV1Hxg6pbeW0d7LJj8I=;
        b=S52fEBY2p0KM5qmwTZ0AScYN6EaeIP5Qn5vdDy0tyiOKOqhKpAKQAZRaGWqpAWtY/R
         q3fL0C5M+VdogzM3v3JFR/UWlOiGUN2FHQGqfw9xfAZoknJKsAQW69gPXvrxKXryvpGx
         cdEkl8E7vdFS1+49f8MhQXfmjCj44nN12ZYydQLC7QWeCHfy7HxI8PGHvaKNPXnoGAZc
         +vlfkg33YYXkUs0fXQiXgncqSUyCUKb2k1uoOIgS6W1h4eRxlFaj+xhuZdVZDkpQ+15j
         wtDqjU2/AGiPb5G2vXDbzRl0optZ1ra7TXmkqHAtXA91eN2ajFQ5PwmSP7eFuFvjlRQy
         sa0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Tj/U4wMEMDKOxq40ZfhlaqeOV1Hxg6pbeW0d7LJj8I=;
        b=EEiajmq4x+dFGwVWDdsVgPNJifm8GzLaiizyERZ+HLm4yQVyaF7ukcJSB1QCeyjwvT
         bK7xdlVnw5u/khPQqQh7KmFDgW3u3CEMFoofFm342Z+aW4FeMqi7Q/wdMJ2QU4heRcwq
         KOUCQD95HMGBY+0Ql5tWqSMhxnT3jcfQCZ1OWuVlrjpetTninussgkl0HTmKA+dxBrQt
         xtAyzNxdCxvth+QuSxtGdNQfsF6GmjA+lWIY8uGT0isN5UzorFWwl4+xCCXkCUCItDmg
         rVBVwfbhxRg4d9TmWSeBfxarW/TG96ZS2HeP2sfK/Gy18eb/Pap9ZmyPcMcNeNhGyaGA
         jJpA==
X-Gm-Message-State: APjAAAUqedaTlT9wD5W096bbV03vetcMHmQcP4L34f7HotJFiXUbaPPy
        7fkN1Cvyd5xFNCxHS+xPXtEDE7orJNyJj/mclUw=
X-Google-Smtp-Source: APXvYqwgdqmN0FGQ8M6Y+oyfSjAtFEwFUtkZ4U8n3JrALrgT5Aa2VPXVpzue2V2c9yX41EEYCeF2dE15UfZTflOELMk=
X-Received: by 2002:a62:e80b:: with SMTP id c11mr43785802pfi.241.1571233792369;
 Wed, 16 Oct 2019 06:49:52 -0700 (PDT)
MIME-Version: 1.0
References: <20191011133617.9963-1-linux@rasmusvillemoes.dk> <20191015190706.15989-1-linux@rasmusvillemoes.dk>
In-Reply-To: <20191015190706.15989-1-linux@rasmusvillemoes.dk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 16 Oct 2019 16:49:41 +0300
Message-ID: <CAHp75Vcw9Wn6a2VEhQ00o1FZq=egtiQGjC1=uX1J71wQ9pf-pw@mail.gmail.com>
Subject: Re: [PATCH v5] printf: add support for printing symbolic error names
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>,
        Petr Mladek <pmladek@suse.com>,
        Linux Documentation List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 10:07 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:

> +const char *errname(int err)
> +{
> +       const char *name = __errname(err > 0 ? err : -err);

Looks like mine comment left unseen.
What about to simple use abs(err) here?

> +       if (!name)
> +               return NULL;
> +
> +       return err > 0 ? name + 1 : name;
> +}

-- 
With Best Regards,
Andy Shevchenko
