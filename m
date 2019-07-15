Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 643FD69A85
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2019 20:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732175AbfGOSHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 14:07:04 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42907 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732159AbfGOSHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 14:07:01 -0400
Received: by mail-oi1-f194.google.com with SMTP id s184so13367282oie.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 11:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=79WYKtJ+U35PauFrpeLqVRnz0ZJBCqDpFetboHZqtQw=;
        b=I5zGheaVWY4Ec6Nj5/hrdukIf4e19bZQ0No77m6mTAowcvkmcvdj0kdrkqOp2YTtGZ
         m+tREyMLN0g9vH+Xx/PiicPd46J4BI5Rj5zBSYok/dkQzK+0j5Pq49Q3eAMXaOzKnC3M
         cvCh4tm7UzHjXbL6Gk0kHG0T6yR+Ao6qG+3Gw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=79WYKtJ+U35PauFrpeLqVRnz0ZJBCqDpFetboHZqtQw=;
        b=l24bWCn2XC6ggsQH58uDVxexb7ewjNACAb9mGYlWyVwCHWqXVDvw4Liz5X3DUYonoj
         i5j7QrnLcnX55ppckUMWIg4LRC6Yi6XZxS97FoBNIuu7V029JIcyZqU3k4Eop3vTkS+8
         YuW+ByjTDvT+aeVEFbZ6c8/U6kezjo1LdbuEH7kIbst+qxfSrzB7uslzHeC02D2jFaQe
         NZFV+ET4eQa7nWP6M3u2uEIy+HSf2lflFSWmfzd3DcKbwk2L2IFHn1GNfICKg5KnEwLW
         TqYCi4pRqGi9VYERb+rwPT0In2E3y8IGDFgEEAhqP01+h24LZoGm+9vd8QC+OBR10jYh
         a+uA==
X-Gm-Message-State: APjAAAXMTcMfD+lqXQ5VmmCQtU1PszXoiUG76DfhlI2T79hQHwRSqnyY
        QqhwN/RG8EHIiUxyVVIK0oPrI3t8HzUByX5gQ84=
X-Google-Smtp-Source: APXvYqxzSU5VMQ6W7ahIw1tUeCUhSmeOrOvmNhiu3ovS8GKEsu6H2nLQglHA3soLdt+CtkULzqcxQ6i2v25QfXXtMUs=
X-Received: by 2002:aca:b104:: with SMTP id a4mr13598437oif.14.1563214020306;
 Mon, 15 Jul 2019 11:07:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tzJQ+26n_Df1eBPG1A=tXf4xNuVEjbG3aZj-aqYQ9nnAg@mail.gmail.com>
 <CAPM=9tx+CEkzmLZ-93GZmde9xzJ_rw3PJZxFu_pjZJc7KM5f-w@mail.gmail.com>
 <20190715122924.GA15202@mellanox.com> <CAKMK7uHvjuQ5Dqm0LPrtQxdHh5Z6Pt2mg4AnpRRR0gWb1Wp05g@mail.gmail.com>
 <20190715150402.GD15202@mellanox.com> <CAKMK7uGbNuA_pN=r9XKGz2MTVVJWm6q8tKBT3WJPa93nKEe4iA@mail.gmail.com>
 <20190715175726.GC5043@mellanox.com>
In-Reply-To: <20190715175726.GC5043@mellanox.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Mon, 15 Jul 2019 20:06:49 +0200
Message-ID: <CAKMK7uGYm3Kb+vUMmpWxYAjTxneUSddBAwHKg+yn0dPsaorETw@mail.gmail.com>
Subject: Re: DRM pull for v5.3-rc1
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Dave Airlie <airlied@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 7:57 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Mon, Jul 15, 2019 at 07:53:06PM +0200, Daniel Vetter wrote:
>
> > > So, I'll put it on a topic and send you two a note next week to decide
> > > if you want to merge it or not. I'm really unclear how nouveau's and
> > > AMD's patchflow works..
> >
> > DRM is 2-level for pretty much everything. First it lands in a driver
> > tree (or a collectiv of drivers, like in drm-misc). Then those send
> > pull requests to drm.git for integration. Busy trees do that every 1-2
> > weeks (e.g. amdgpu), slower trees once per merge window (e.g. nouveau)
> > for drm-next, similar for drm-fixes.
>
> The DRM part seems logical - it is how the AMD GPU and nouveau git
> trees trees work that I don't know. I heard that neither could take in
> a stable topic branch?

Hm yeah they're a bit special. Nouveau is mostly developed in
userspace, at least by it's main developer Ben Skeggs. But generally
he's taking care of shuffling patches back&forth using scripts.
Usually easier to do any merges and stuff in drm.git though.

AMD is a different case, they've disappeared quite a lot behind the
amd firewalls with the new codebase. So there the rebasing-before-pull
is for corporate politics reasons it seems, and really not needed for
any technical reasons (unlike nouveau, where reverse-engineering hw in
userspace is a lot nicer than crashing kernels). Dave&me have been
nagging them for a few years now to fix this.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
