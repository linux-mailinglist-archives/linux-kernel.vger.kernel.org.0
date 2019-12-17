Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 147F912346C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 19:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbfLQSIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 13:08:46 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:41018 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727805AbfLQSIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 13:08:46 -0500
Received: by mail-io1-f65.google.com with SMTP id c16so12084881ioo.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 10:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZIJyvkgniYTRbfVXcX1GxMAL0QR6Z8+gBwpFH9B/c4o=;
        b=XlMSk7A88wGRbKPmBiK+0N9lxDaruaINHiTIT+XEKts5pKGzy9dnHPdZZo2HouzJj2
         UezX+XPJHeZ+F5CfDjtpJ5XdSDJtZ+koIOi7Sd+bzyL9Qgqr54KjVIz1Gz+5DB8dDNcj
         qxT42ZDVS8ut17EXMMS23SKbC0c62AVtHHDsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZIJyvkgniYTRbfVXcX1GxMAL0QR6Z8+gBwpFH9B/c4o=;
        b=A1a3UCTU8IHvSn1Wr5NWo8rFljHySVHFp/hWTsYFSfPDIJzwJne0zNWFMrfA61DC4P
         7VBPqZl8Ui4wPMoYrfxfWHJwctgnnMHtQMsu84WXQBBle1FnF+IL3R2RdCqfYTma2flo
         cvOYPMmheq9lCqO7EClKiBeHFn/DXmgnp1MhuXtiavYhPvUThpL75mndjxV/KqnOlwvY
         +tXv86f33fZSADxPZAcvienZxmX2jav/JaBYm0LRKzsL9zxJTQJLfR8wlJYm8ZQWmgnj
         SiPsiVgAiHX3oR8nCC1ZUPokfJzq7gKS+/F5SS3uex6017AHDAGy3x+Rq1HPEHhRaBfM
         WGGA==
X-Gm-Message-State: APjAAAUYPihz7V7KgFx7SegeWt3Q+ufmLiwBD8TQwewOVhun6Z0jLWF8
        zT5jTbfFeCHkvDnz8UftwhqBLnVF2hjJourY4Gl5Ag==
X-Google-Smtp-Source: APXvYqxRQov73i2S2wI8koP3gXNvUCrtrWmcjpiZqNtU+6+fSqNO+yoiT72worXPzEwwctA/CUwaC06tsekviuWP3Kc=
X-Received: by 2002:a6b:6f07:: with SMTP id k7mr4799644ioc.174.1576606125798;
 Tue, 17 Dec 2019 10:08:45 -0800 (PST)
MIME-Version: 1.0
References: <20191212145042.12694-1-labbott@redhat.com> <CAOi1vP9E2yLeFptg7o99usEi=x3kf=NnHYdURXPhX4vTXKCTCQ@mail.gmail.com>
 <fbe90a0b-cf24-8c0c-48eb-6183852dfbf1@redhat.com> <CAHk-=wh7Wuk9QCP6oH5Qc1a89_X6H1CHRK_OyB4NLmX7nRYJeA@mail.gmail.com>
 <cf4c9634-1503-d182-cb12-810fb969bc96@redhat.com> <20191212213609.GK4203@ZenIV.linux.org.uk>
 <CAJfpegv_zY6w6=pOL0x=sjuQmGae0ymOafZXjyAdNEHj+EKyNA@mail.gmail.com> <32253.1576604947@warthog.procyon.org.uk>
In-Reply-To: <32253.1576604947@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 17 Dec 2019 19:08:34 +0100
Message-ID: <CAJfpeguwy+dyPmad8RE5JmUce8ecze8Kccj--YgXaEHThxeT4g@mail.gmail.com>
Subject: Re: [PATCH] vfs: Don't reject unknown parameters
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Laura Abbott <labbott@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeremi Piotrowski <jeremi.piotrowski@gmail.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 6:49 PM David Howells <dhowells@redhat.com> wrote:
>
> Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> > > So you could bloody well just leave recognition (and handling) of "source"
> > > to the caller, leaving you with just this:
> > >
> > >         if (strcmp(param->key, "source") == 0)
> > >                 return -ENOPARAM;
> > >         /* Just log an error for backwards compatibility */
> > >         errorf(fc, "%s: Unknown parameter '%s'", fc->fs_type->name, param->key);
> > >         return 0;
> >
> > Which is fine for the old mount(2) interface.
> >
> > But we have a brand new API as well; do we really need to carry these
> > backward compatibility issues forward?  I mean checking if a
> > param/flag is supported or not *is* useful and lacking that check is
> > the source of numerous headaches in legacy interfaces (just take the
> > open(2) example and the introduction of O_TMPFILE).
>
> The problem with what you're suggesting is that you can't then make
> /sbin/mount to use the new syscalls because that would change userspace
> behaviour - unless you either teach /sbin/mount which filesystems discard
> which errors from unrecognised options or pass a flag to the kernel to shift
> into or out of 'strict' mode.

The latter has minor cost, so we can add it easily.  Long term I think
it makes sense to move this mess up to userspace, and hence let
util-linux deal with it.

Thanks,
Miklos
