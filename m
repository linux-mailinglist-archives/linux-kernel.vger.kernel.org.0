Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 788C03BD66
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2019 22:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389496AbfFJUUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jun 2019 16:20:42 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33394 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728276AbfFJUUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 16:20:42 -0400
Received: by mail-lf1-f67.google.com with SMTP id y17so7583314lfe.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 13:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9M6F3AKPv7OG6y2K7bhRRjnT8UdjtXCgz4Y9EEYL+yE=;
        b=saZqork8B9+QM+f2nCfCrj8rlM59XPvq319ftaCyyiSzVlXueddIYsFl1oFOnoNHFM
         n0AF32FIdOPtpWRwUDR0aAqA5HtgbdAmdTn91dQADsTaS168kCRS3nSIu6NssjwXamcx
         o32tTM08DZGbBdZHIWl7VPJj+hvXJjegP1tRpW9ZjXONIohOHmzbE16SV2BqeldVXGk5
         lTV7I6BCBpdqSxixsI4A2KZZVEySXl+5ULVAnFyY2xKZhBYNYIJgoYJTh7lBxgcetWqd
         rQPDEQXjgYy/yB7xj8+VVCTVFcsDRyyhhRl/Tv61GQGEJBOlxYBPJjU3FlWP1wgTFE/T
         JQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9M6F3AKPv7OG6y2K7bhRRjnT8UdjtXCgz4Y9EEYL+yE=;
        b=ewbLUEPjaFqSOh+9nk3P6xA7NPB1BoyUSAxD7rpWx531EVpD9WLOVpa6LNq1DRwIN+
         q1HZgNIjplqG7WWd3DF51GncMbXPioPeDagTVdCe1oATy3K6sTxxA0Ygpiz2ah7aAg4I
         J49Rhtxmb9qXrxBjGs1M/Qqz6Y3tPpvgtB6DsTuIzZpyXYZaNx0saVG/DXJk9u7uuL45
         H4Sbj4BJwMyAfhqz/FTYrM3EPe3cvuNARhY2sQT/eFrPGESuXTofsNcBAUoWYfj/pYaL
         G3DPG7hCZUXN8mWTsCAjPtLPGeRsAAc8SD5L6qhAV0aOmYnNYOgbUt3fF4kSXGNHpKEP
         xPTw==
X-Gm-Message-State: APjAAAUlqlAaBsxqHccZi9KNy5wG8y21w7HidqH3jkXd4ufsNyWb4IMT
        QvJu0YH/7fRlTCZ+2oEk8xu5ZCe8wl76ZpSDcXxq
X-Google-Smtp-Source: APXvYqwwPuL2qotjbCVzlbt1SrW9wOBZt+K0jOXzvsil8EjXgCBDxYdewKxbzFBLnmMhZHg9PaXFTk/Q4SP8A69hMpA=
X-Received: by 2002:ac2:410a:: with SMTP id b10mr18751609lfi.175.1560198039673;
 Mon, 10 Jun 2019 13:20:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190606085524.GA21119@zhanggen-UX430UQ> <CAFqZXNvM94T2reUsn6Mwuz6GNGNCR=wUNBE8w4tcjNuhJ6rCeQ@mail.gmail.com>
In-Reply-To: <CAFqZXNvM94T2reUsn6Mwuz6GNGNCR=wUNBE8w4tcjNuhJ6rCeQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 10 Jun 2019 16:20:28 -0400
Message-ID: <CAHC9VhT+e2Z+4=5P0g4B4F1g0w2SkQjwUnhQkmu5V+HvuZi8Cg@mail.gmail.com>
Subject: Re: [PATCH v4] selinux: lsm: fix a missing-check bug in
 selinux_sb_eat_lsm_o pts()
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        Gen Zhang <blackgod016574@gmail.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 7, 2019 at 4:41 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Thu, Jun 6, 2019 at 10:55 AM Gen Zhang <blackgod016574@gmail.com> wrote:
> > In selinux_sb_eat_lsm_opts(), 'arg' is allocated by kmemdup_nul(). It
> > returns NULL when fails. So 'arg' should be checked. And 'mnt_opts'
> > should be freed when error.
> >
> > Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> > Fixes: 99dbbb593fe6 ("selinux: rewrite selinux_sb_eat_lsm_opts()")
>
> My comments about the subject and an empty line before label apply
> here as well, but Paul can fix both easily when applying ...

Since we've been discussing general best practices for submitting
patches in this thread (and the other related thread), I wanted to
(re)clarify my thoughts around maintainers fixing patches when merging
them upstream.

When in doubt, do not ever rely on the upstream maintainer fixing your
patch while merging it, and if problems do arise during review, it is
best to not ask the maintainer to fix them for you, but for you to fix
them instead (you are the patch author after all!).  Similarly, making
comments along the lines of "X can fix both easily when applying", is
also a bad thing to say when reviewing patches.  It's the patch
author's responsibility to fix the patch by address review comments,
not the maintainer.  I'll typically let you know if you don't need to
rework a patch(set).

That said, there are times when the maintainer will change the patch
during merging, most of which are due to resolving merge
conflicts/fuzz with changes already in the tree (that *is* the
maintainer's responsibility).  Speaking for myself, sometimes I will
also make some minor changes if the patch author is away, or
unreliable, or if there is a hard deadline near and I'm worried that
the updated patch might not be ready in time.  I'll also sometimes
make the changes directly if the patch is holding up a larger, more
important patch(set), but that is really rare.  I'm sure I've made
changes for other reasons in the past, and I'm sure I'll make changes
for other reasons in the future, but hopefully this will give you a
better idea of how the process works :)

-- 
paul moore
www.paul-moore.com
