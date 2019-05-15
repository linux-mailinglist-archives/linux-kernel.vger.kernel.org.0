Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C48451EC41
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 12:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfEOKqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 06:46:10 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:49611 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfEOKqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 06:46:10 -0400
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x4FAjlT0028085
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 19:45:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x4FAjlT0028085
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1557917148;
        bh=Q7wclT0g9FT3toQkG7eWSJ6okxkqIUrkR+mIo/eNOQc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EVYU1NBJvSvo3cHNboRZMWz6awDo2izBd/KulfDDMk2PMeJ+c9hThFxnS6VrhkANH
         bfC4NOdJJuztGcKoQpnulmLhT+KTAWx7n8BMXZSctJIURepH0k6gfM9+a8HfLEn2Yb
         qGrlPXJCvlVRa9SZjGbo9aKv2R8FsckfdlVu2jdo53jTK3m5j9K2rddmBiOiXpPnPC
         8ZUgH9wAnx249Wx4w3wnPRoTKj6GgZfMyBTCn6qRzkdzTpNHFkEYkGUJ2PpeOQ4E3x
         nyWkrU3p6rF6g3dt4ZqMXybw+NvEPrEJmUvwBk7S5u8+fUkQ1xmQ2+646ugSki4vhd
         G2bAY/NQq6U4g==
X-Nifty-SrcIP: [209.85.222.47]
Received: by mail-ua1-f47.google.com with SMTP id t15so842150uao.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 03:45:48 -0700 (PDT)
X-Gm-Message-State: APjAAAV8Co4rq6vadvjwQ/C4tWi2er9+XPy/UErCsK5dqZUfQlo8Wd5q
        p3LTYNnQCrg4hIRYGWpa4XrNd+T/Fl1IFfewLCQ=
X-Google-Smtp-Source: APXvYqwDVNyPwwpdaw6f2M7fafwG0m4Jii5pcqUyaOLnmQN7wgqEr8RPbyQkDpU8doGbsuNvlvLrp0iHMMgCf0GuYrY=
X-Received: by 2002:a9f:2d99:: with SMTP id v25mr15675392uaj.25.1557917147127;
 Wed, 15 May 2019 03:45:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190515043753.9853-1-yamada.masahiro@socionext.com> <155790139253.21839.18331243986827594086@skylake-alporthouse-com>
In-Reply-To: <155790139253.21839.18331243986827594086@skylake-alporthouse-com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 15 May 2019 19:45:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNARu1vGhfzSU9k878H7=1cbD+mD99YOHOL4jBvrmoBTBmg@mail.gmail.com>
Message-ID: <CAK7LNARu1vGhfzSU9k878H7=1cbD+mD99YOHOL4jBvrmoBTBmg@mail.gmail.com>
Subject: Re: [PATCH] drm/i915: drop unneeded -Wall addition
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 3:25 PM Chris Wilson <chris@chris-wilson.co.uk> wrote:
>
> Quoting Masahiro Yamada (2019-05-15 05:37:53)
> > The top level Makefile adds -Wall globally:
> >
> >   KBUILD_CFLAGS   := -Wall -Wundef -Werror=strict-prototypes -Wno-trigraphs \
> >
> > I see two "-Wall" added for compiling under drivers/gpu/drm/i915/.
>
> Does it matter? Is the statement in i915/Makefile not more complete for
> saying "-Wall -Wextra -Werror"?


Not fatal, but better to fix.

Why not fix the comment if you mind
"-Wall" in the comment?

It will be easy to rephrase the comments
without explicitly mentioning -Wall or -Wextra.


I reworded it more concisely:

# We aggressively eliminate warnings,
# so here are more warning options than default.

That's it.


The CI is your local matter.
Distracting comments should not be added in the upstream code
in the first place.


> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> > BTW, I have a question in the comment:
> >
> >  "Note the danger in using -Wall -Wextra is that when CI updates gcc we
> >   will most likely get a sudden build breakage... Hopefully we will fix
> >   new warnings before CI updates!"
> >
> > Enabling whatever warning options does not cause build breakage.
> > -Werror does.
> >
> > So, I think the correct statement is:
> >
> >  "Note the danger in using -Werror is that when CI updates gcc we ...
>
> No.


Heh, I thought the answer was Yes,
since I saw the following in this Makefile.

# Add a set of useful warning flags and enable -Werror for CI to prevent




> CI enforces -Werror and that is constant, so the uncontrolled
> variable, the danger, lies in using the unreliable heuristics gcc may
> arbitrary enable between versions. That the set of warnings causing an
> error may be different between CI and the developer.
> -Chris



-- 
Best Regards
Masahiro Yamada
