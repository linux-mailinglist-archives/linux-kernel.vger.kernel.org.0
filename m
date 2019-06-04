Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C96234462
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 12:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfFDK3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 06:29:48 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42339 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfFDK3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 06:29:48 -0400
Received: by mail-lj1-f193.google.com with SMTP id t28so8022649lje.9;
        Tue, 04 Jun 2019 03:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KC6WYxlpcqhIp28quPcFujzF/rmNHk3TKH17hzBiGvA=;
        b=hw+gveNYVD5uQUBCaKjvBBPmQLhpFopKknIODrN1W8tWgLQmFahFeQEwE13iTjXM1H
         FQ7f01eJgDJU7Ywbnvig+7TTwZCQ0O20GUNLzCI8pTWimbG/0COOEoJeYVgV3Z739Irm
         tDKDxGZRP5BpbFXgutvTShDrZxCLXCgt9YaMt7PO4I9EkxRKDZ6+lQgrpOOgRxLwAh6k
         P9GBowdwAfx8K5ueFSG8+y89MHM9gazZ5euBaCzdY5JgqvrErLFEAuMm32zPaqwi0eIm
         MQ97Iqio8Kbu7Q2gmjeINMPX3i5s581/3y4n9W19MsVJn9XhmvwYqBnQU8RI7TP0qVvv
         hSSg==
X-Gm-Message-State: APjAAAUkTkf1bBPeQtdJTPaFHmbkAmX64ePu/AOJXPa6eYzFkpj8SZJm
        hnIlxQzwIRMQuves8K5dM4E+R8yMKS3rx10ZHdB/ZTA+6qY=
X-Google-Smtp-Source: APXvYqzaAYC+UV3seO+WXdy5Gi7SOfofMsS+MSg3WFzpTkSP9cCsxuFgFUOf/eucH09eOywO+ZqM377EHrigh3XpR38=
X-Received: by 2002:a2e:960e:: with SMTP id v14mr16623216ljh.31.1559644185874;
 Tue, 04 Jun 2019 03:29:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190530135317.3c8d0d7b@lwn.net>
In-Reply-To: <20190530135317.3c8d0d7b@lwn.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 4 Jun 2019 12:29:33 +0200
Message-ID: <CAMuHMdWFdkzcFEsxVAzo17o1hVp6Z-3GftFcN6hDhg-ewX4M6g@mail.gmail.com>
Subject: Re: [PATCH RFC] Rough draft document on merging and rebasing
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

On Thu, May 30, 2019 at 9:54 PM Jonathan Corbet <corbet@lwn.net> wrote:
> This is a first attempt at following through on last month's discussion
> about common merging and rebasing errors.  The hope here is to document
> existing best practices rather than trying to define new ones.  I've
> certainly failed somewhere along the way; please set me straight and I'll
> try to do better next time.
>
> Thanks,
>
> jon
>
> -------------
> docs: Add a document on repository management
>
> Every merge window seems to involve at least one episode where subsystem
> maintainers don't manage their trees as Linus would like.  Document the
> expectations so that at least he has something to point people to.
>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Thanks!

> --- /dev/null
> +++ b/Documentation/maintainer/repo-hygiene.rst

> +One thing to be aware of in general is that, unlike many other projects,
> +the kernel community is not scared by seeing merge commits in its
> +development history.  Indeed, given the scale of the project, avoiding
> +merges would be nearly impossible.  Some problems encountered by
> +maintainers results from a desire to avoid merges, while others come from

result

> +merging a little too often.

[...]

> + - Realize the rebasing a patch series changes the environment in which it

Realize that

> +   was developed and, likely, invalidates much of the testing that was
> +   done.  A rebased patch series should, as a general rule, be treated like
> +   new code and retested from the beginning.

> +Finally
> +=======
> +
> +It is relatively common to merge with the mainline toward the beginning of
> +the development cycle in order to pick up changes and fixes done elsewhere
> +in the tree.  As always, such a merge should pick a well-known release
> +point rather than some random spot.  If your upstream-bound branch has
> +emptied entirely into the mainline during the merge window, you can pull it
> +forward with a command like::
> +
> +  git merge v5.2-rc1^0
> +
> +The "^0" will cause Git to do a fast-forward merge (which should be
> +possible in this situation), thus avoiding the addition of a spurious merge
> +commit.

I usually use

     git rebase v5.2-rc1 <mybranch>

_after_ verifying everything has been merged, i.e.

    git cherry -v v5.2-rc1 <mybranch>

did not give any output.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
