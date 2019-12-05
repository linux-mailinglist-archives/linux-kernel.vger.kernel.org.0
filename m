Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 724641146EC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2019 19:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729877AbfLESbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Dec 2019 13:31:13 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43019 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729290AbfLESbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 13:31:13 -0500
Received: by mail-pg1-f196.google.com with SMTP id b1so1971878pgq.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 10:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HI4uYxR0J9DMTnkRmLhO8esoltr/E7e+IU0bpfvbumQ=;
        b=nyVc4+A6dtfKp5EmT95300EFmgP7gQevt7DIkRtreep8yQoK/jQBq0+L1A8HZcKZ78
         QRG4IEHOi5aWaS9lsMHV3GbAXZvJY9MLXnMEU2+6QavOQp2OWJtwa0Pptfl/0G0nbPkw
         A5dUqhKJX//j7CfYxhguSqmpkWUuFJAlgYvl2k1OPeRVuccYRDkHm0XCLbug23jNOZYQ
         kpWBQ8JOOQJhPXc1gquKDxEtatESK9i0Vp0slDyquhiYpOXg3sgBWReeMYPFhzJliLh4
         H8zfIHq/o+wPO7DaGs5h/6XozND/CQUe62mautLmZCoa0sUQddpX0fFXfl5n+jLXrjsl
         UIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HI4uYxR0J9DMTnkRmLhO8esoltr/E7e+IU0bpfvbumQ=;
        b=cqvzSTgbHtdYmMwdPBCqRDGdXuW4Ci0wyj87d7MTz3DaySt3D+9Wm2dsRM2GenM1Bc
         wNQEBnVmMj7K21fbvgk4Hug2RaKGL7tmJ7r0vvcHgMMDbv979kcLY5DV6T2sAfQQhlng
         vKmwJyWXBXRDVTK9DFNlZjHaoqk2JpJ6P7e/fWrvs+l9z1vw6rLg+jDFFL+hnRmm1drg
         F7iM+vqYQ3yHOjkGidDeCBxS+4yuWt7NmJ3mVIsPdEQbvw0yF3wl5TRA19TIJTu2gZyi
         jvUdZafbEFlQLSYwHaDS+kt0WT8ljAyO/9Qp36w3KyCL1lV2uSepBbaXEBc/S1of43IY
         KvtA==
X-Gm-Message-State: APjAAAW/ecDKnJGaWAbaWaSPDL0JXisHLIpGEdiFgbkrXe4dmIxed/Mj
        1dSuGYC/6LAoonrKruYvITZjWtYT7oOgrOqOFsiXHQ==
X-Google-Smtp-Source: APXvYqwT7ShzxGreCEuYPGEZxiVNpcROPBYQcRibsPumhz7L933fr9ODqh2A0iIKt0qHZJKolpaaSUV3b12srJ+FST0=
X-Received: by 2002:aa7:961b:: with SMTP id q27mr10426991pfg.23.1575570671690;
 Thu, 05 Dec 2019 10:31:11 -0800 (PST)
MIME-Version: 1.0
References: <20191204234522.42855-1-brendanhiggins@google.com> <CABVgOSn7tTYuMZ8ArA3fRWp4aeKAcKJ3qNL+SgtFt5fkBLnc-A@mail.gmail.com>
In-Reply-To: <CABVgOSn7tTYuMZ8ArA3fRWp4aeKAcKJ3qNL+SgtFt5fkBLnc-A@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 5 Dec 2019 10:31:00 -0800
Message-ID: <CAFd5g446ippuyNN5ej0hEiz1Rv9hqpke55pE0en15U=gG3zX0A@mail.gmail.com>
Subject: Re: [PATCH v1] staging: exfat: fix multiple definition error of `rename_file'
To:     David Gow <davidgow@google.com>
Cc:     valdis.kletnieks@vt.edu,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 5, 2019 at 9:51 AM David Gow <davidgow@google.com> wrote:
>
> On Wed, Dec 4, 2019 at 3:46 PM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > `rename_file' was exported but not properly namespaced causing a
> > multiple definition error because `rename_file' is already defined in
> > fs/hostfs/hostfs_user.c:
> >
> > ld: drivers/staging/exfat/exfat_core.o: in function `rename_file':
> > drivers/staging/exfat/exfat_core.c:2327: multiple definition of
> > `rename_file'; fs/hostfs/hostfs_user.o:fs/hostfs/hostfs_user.c:350:
> > first defined here
> > make: *** [Makefile:1077: vmlinux] Error 1
> >
> > This error can be reproduced on ARCH=um by selecting:
> >
> > CONFIG_EXFAT_FS=y
> > CONFIG_HOSTFS=y
> >
> > Add a namespace prefix exfat_* to fix this error.
> >
> > Reported-by: Brendan Higgins <brendanhiggins@google.com>
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > Cc: Valdis Kletnieks <valdis.kletnieks@vt.edu>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> Tested-by: David Gow <davidgow@google.com>
> Reviewed-by: David Gow <davidgow@google.com>
>
> This works for me: I was able to reproduce the compile error without
> this patch, and successfully compile a UML kernel and mount an exfat
> fs after applying it.
>
> > ---
> >  drivers/staging/exfat/exfat.h       | 4 ++--
> >  drivers/staging/exfat/exfat_core.c  | 4 ++--
> >  drivers/staging/exfat/exfat_super.c | 4 ++--
> >  3 files changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
> > index 2aac1e000977e..51c665a924b76 100644
> > --- a/drivers/staging/exfat/exfat.h
> > +++ b/drivers/staging/exfat/exfat.h
> > @@ -805,8 +805,8 @@ s32 create_dir(struct inode *inode, struct chain_t *p_dir,
> >  s32 create_file(struct inode *inode, struct chain_t *p_dir,
> >                 struct uni_name_t *p_uniname, u8 mode, struct file_id_t *fid);
> >  void remove_file(struct inode *inode, struct chain_t *p_dir, s32 entry);
> > -s32 rename_file(struct inode *inode, struct chain_t *p_dir, s32 old_entry,
> > -               struct uni_name_t *p_uniname, struct file_id_t *fid);
> > +s32 exfat_rename_file(struct inode *inode, struct chain_t *p_dir, s32 old_entry,
> > +                     struct uni_name_t *p_uniname, struct file_id_t *fid);
> >  s32 move_file(struct inode *inode, struct chain_t *p_olddir, s32 oldentry,
> >               struct chain_t *p_newdir, struct uni_name_t *p_uniname,
> >               struct file_id_t *fid);
>
> It seems a bit ugly to add the exfat_ prefix to just rename_file,
> rather than all of the above functions (e.g., create_dir, remove_file,
> etc). It doesn't look like any of the others are causing any issues
> though (while, for example, there is another remove_file in
> drivers/infiniband/hw/qib/qib_fs.c, it's static, so shouldn't be a
> problem).

Agreed; however, given that this is a fix, I didn't want to overreach
in the scope of this change since I want to make sure it gets accepted
in 5.5 and it probably won't make it in the merge window. I also
figured that, since this is in staging, this might be one of the
things that needs to happen before being promoted out of staging.

Nevertheless, I don't mind going through and adding the namespace
prefix to the other non-static functions if that's what Valdis and
Greg want.

Thanks!
