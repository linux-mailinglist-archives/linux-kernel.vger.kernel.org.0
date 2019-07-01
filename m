Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42DC230F4D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 15:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfEaNvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 09:51:35 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44855 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfEaNve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 09:51:34 -0400
Received: by mail-lf1-f65.google.com with SMTP id r15so7947923lfm.11;
        Fri, 31 May 2019 06:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0L8KmLgJiSpT3aD4m8sLrFeMla61B+JDJj6vkONUe8A=;
        b=R3m6B6V9mU8OmLilY5NoPijnSisRDIZwm9BomSlpbjGpNnAcKRvlEJgyalDDjCakjy
         JTSiBWzZk6YXU7TzCu+TSQfxxYlteU2aCl4Lg/c5786hCW2dOYQ9raEYYdvtjq8GFcdA
         wMYbsCpcJyz9ksco6/durKAHWAO4wQG2JOjoISP+3paw8o9hUoYaYcH2LRZgMFceW48J
         s0AWgB27ghxUvtxozDksvThgjbW+HdEGuC31vm4rWAlKOKu5bX99IwuWsuVihOi/6w2c
         UZHdwgUfeDFnBdsVj1A3FWXyb7yoXlB00S/C9n8meohH8XRFJ0MqlmjJ5QibdkwYTEs0
         D4bw==
X-Gm-Message-State: APjAAAUur/FAZDbdSQXPpeckEYNMPTh5MFFYIqZqxYHIvh118PA4VfGZ
        h0z6McRDGWh+ZRd9jHqo/n+x/teDTVjfxZwZLc1VSv60
X-Google-Smtp-Source: APXvYqwp3rEAeo+I40mze9M/2USK8Lp6ZU6EDq72UeQ86eyUJznslCOjN2hUZnvE25ICHWwy7I5qef6ONjGL2w1LrFs=
X-Received: by 2002:ac2:5467:: with SMTP id e7mr5606332lfn.23.1559310692420;
 Fri, 31 May 2019 06:51:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190531014808.GA30932@kroah.com> <CAMuHMdV=95sKB+h_pf45DiYeiJzrk1L=014Tj8Y04_hPyRMBNQ@mail.gmail.com>
 <20190531132400.GA5518@kroah.com>
In-Reply-To: <20190531132400.GA5518@kroah.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 31 May 2019 15:51:18 +0200
Message-ID: <CAMuHMdX3vQN5tF4-_vGjRQGdbxpPC+u4g-QU45=qykNZgwSj_w@mail.gmail.com>
Subject: Re: [GIT PULL] SPDX update for 5.2-rc3 - round 1
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spdx@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Fri, May 31, 2019 at 3:24 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> On Fri, May 31, 2019 at 09:17:06AM +0200, Geert Uytterhoeven wrote:
> > On Fri, May 31, 2019 at 3:49 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > The following changes since commit cd6c84d8f0cdc911df435bb075ba22ce3c605b07:
> > >
> > >   Linux 5.2-rc2 (2019-05-26 16:49:19 -0700)
> > >
> > > are available in the Git repository at:
> > >
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/spdx-5.2-rc3-1
> > >
> > > for you to fetch changes up to 96ac6d435100450f0565708d9b885ea2a7400e0a:
> > >
> > >   treewide: Add SPDX license identifier - Kbuild (2019-05-30 11:32:33 -0700)
> > >
> > > ----------------------------------------------------------------
> > > SPDX update for 5.2-rc3, round 1
> > >
> > > Here is another set of reviewed patches that adds SPDX tags to different
> > > kernel files, based on a set of rules that are being used to parse the
> > > comments to try to determine that the license of the file is
> > > "GPL-2.0-or-later" or "GPL-2.0-only".  Only the "obvious" versions of
> > > these matches are included here, a number of "non-obvious" variants of
> > > text have been found but those have been postponed for later review and
> > > analysis.
> > >
> > > There is also a patch in here to add the proper SPDX header to a bunch
> > > of Kbuild files that we have missed in the past due to new files being
> > > added and forgetting that Kbuild uses two different file names for
> > > Makefiles.  This issue was reported by the Kbuild maintainer.
> > >
> > > These patches have been out for review on the linux-spdx@vger mailing
> > > list, and while they were created by automatic tools, they were
> > > hand-verified by a bunch of different people, all whom names are on the
> > > patches are reviewers.
> > >
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >
> > I'm sorry, but as long[*] as this does not conform to
> > Documentation/process/license-rules.rst, I have to provide my:
> > NAked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> >
> > [*] The obvious solution is to update Documentation/process/license-rules.rst,
> >     as people have asked before.
>
> I don't understand, what does not conform?  We are trying _to_ conform
> to that file, what did we do wrong?

The new "-or-later" and "-only" variants are not (yet) documented in that file.

   File format examples::

      Valid-License-Identifier: GPL-2.0
      Valid-License-Identifier: GPL-2.0+
      SPDX-URL: https://spdx.org/licenses/GPL-2.0.html
      Usage-Guide:
        To use this license in source code, put one of the following SPDX
        tag/value pairs into a comment according to the placement
        guidelines in the licensing rules documentation.
        For 'GNU General Public License (GPL) version 2 only' use:
          SPDX-License-Identifier: GPL-2.0
        For 'GNU General Public License (GPL) version 2 or any later
version' use:
          SPDX-License-Identifier: GPL-2.0+

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
