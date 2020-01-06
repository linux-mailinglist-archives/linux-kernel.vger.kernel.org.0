Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB79413184C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 20:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgAFTHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 14:07:22 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37955 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgAFTHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 14:07:21 -0500
Received: by mail-ot1-f68.google.com with SMTP id d7so68492397otf.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 11:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6QFRvuleA9WtpvsAtXWm6tkQLzlSUPGr6FWwLguS1UA=;
        b=lEzKvhIXr91MXTb56cIlkCFdxIGfn1wb+leI7kAlqh505eQx4XIbbW3iXFDoCWKoxX
         mOs1RmmfTFgYe4yHHfYD5LFqNTnqFql2Z9xfShofUFB100OyFvlTyOnBVi0isgY42np+
         I3KRUr9CUlqMKEZfB4ML2hRvz09e1OWKb1IzXOYymrl1YuuK/orPoMuD8SspO5epfeNV
         jZiQOnOgEnzTDomie/0DSDsRM0aJGsNUjl+VGRcXFqGdOStmsEpbRjhkBlTbui3BZaX2
         OECTnWMxW+b6CIJIjP4wlg1tmyxD8AEwVuUKTOl6RPucnbR2nAVWVQpY6PMrHcwpMUw0
         Bpcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6QFRvuleA9WtpvsAtXWm6tkQLzlSUPGr6FWwLguS1UA=;
        b=RDcB1Wb8sYFPh+9pFgXCm1lOaJZfqfQcR3Q2+P+JleuPp3Jst57H5ycbQGFYp8v3jF
         Eg1wDWbrXoSheVCqUYyceR7cWrWcBzdT95TAQk91NIok935R2fZWB0WsR60oRlpxldjs
         8i8sZrgIV/h1wV9xwsVqPmA8ErOsR87JiwTpen3GB/tQbncfFfyAwEBiAR0kqIQtbSuj
         taVFE/Nj/C/fELIXNlJO1KZyogLbGJxtKpzzIzntTjmvrxrWqW9cImnjSpwUxlc0JD3R
         gBSUBW4zhIgKlXkhlqP1qQ5Rh+Pw4kMFo1qiL8eiOU2L3GNwCUqCPEZjfRwuv5TmhJLU
         oOWQ==
X-Gm-Message-State: APjAAAVvpL/g4mGxwRPNw+doshWuZ5OsOhDeF0JeW4rxYooJX/F9FEmF
        rWe6Uo+161IVnGvP/7RSVOHaiMd8mo0WCwz7ozddj87j
X-Google-Smtp-Source: APXvYqw+VRmSCUpEIds5QED+DtM1KS2+eRws83HzlBVSSAISOci0Vwz/L50SKSyiLGt26WLuz7avtPw7YloHNkrxRHM=
X-Received: by 2002:a9d:3676:: with SMTP id w109mr100975180otb.35.1578337640469;
 Mon, 06 Jan 2020 11:07:20 -0800 (PST)
MIME-Version: 1.0
References: <20200106181329.167322-1-hridya@google.com> <d78e4db4-5847-082c-189a-f13d7d6a6c7a@tycho.nsa.gov>
In-Reply-To: <d78e4db4-5847-082c-189a-f13d7d6a6c7a@tycho.nsa.gov>
From:   Hridya Valsaraju <hridya@google.com>
Date:   Mon, 6 Jan 2020 11:06:44 -0800
Message-ID: <CA+wgaPMHWOVYo_pVeYuvj6CrQOgy9=vQco+tnGHjPX3=CLh5wA@mail.gmail.com>
Subject: Re: [PATCH] security: selinux: allow per-file labelling for binderfs
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Jeff Vander Stoep <jeffv@google.com>,
        Mark Salyzyn <salyzyn@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 6, 2020 at 10:33 AM 'Stephen Smalley' via kernel-team
<kernel-team@android.com> wrote:
>
> On 1/6/20 1:13 PM, Hridya Valsaraju wrote:
> > This patch allows genfscon per-file labeling for binderfs.
> > This is required to have separate permissions to allow
> > access to binder, hwbinder and vndbinder devices which are
> > relocating to binderfs.
> >
> > Acked-by: Jeff Vander Stoep <jeffv@google.com>
> > Acked-by: Mark Salyzyn <salyzyn@android.com>
> > Signed-off-by: Hridya Valsaraju <hridya@google.com>
>
> Do you want binderfs to also support userspace labeling of files via
> setxattr()?  If so, you'll want to also add it to
> selinux_is_genfs_special_handling() as well.

Thank you for the quick response Stephen :) I cannot think of a
use-case for the userspace labelling of files in binderfs via
setxattr() as of now. I
will make the change if one comes up!

Thanks,
Hridya


>
> > ---
> >   security/selinux/hooks.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 116b4d644f68..3f0669a708e9 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -752,6 +752,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
> >
> >       if (!strcmp(sb->s_type->name, "debugfs") ||
> >           !strcmp(sb->s_type->name, "tracefs") ||
> > +         !strcmp(sb->s_type->name, "binderfs") ||
> >           !strcmp(sb->s_type->name, "pstore"))
> >               sbsec->flags |= SE_SBGENFS;
> >
> >
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
