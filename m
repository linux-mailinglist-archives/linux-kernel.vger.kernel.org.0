Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 109C7153C1D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Feb 2020 00:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbgBEXxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 18:53:09 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:36250 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbgBEXxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 18:53:09 -0500
Received: by mail-qv1-f65.google.com with SMTP id db9so2030013qvb.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 15:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/m+6/gHtitRcFwDRfgIzzOezx3KJKRXU/a2k3eD85GU=;
        b=FLa7puDpv4wlbq05A10ZykfGH59L4UeD7CB9/Lf0OsX0XtUrdga2W2J0Q+VZk30wad
         oiE997YzvsAZQ2T79shfFhO2SvlFt/d+QfpgrTkPRValXuFvVw2LepfnACEwPO5Gyiph
         nos0QgbV/Y5frbDSa+0I1SXBgT4/2IWYpNCWdK8KdLShiuvNp75XJ6p3dm8xuH3/Fzrq
         8iX7HE8qv1+8grJip7uVWB1mMVU6vTmswrGHASeYxQanYvqlSsO3qK5rUyF9L1iNO+FT
         19RjBaO6LHwteGx1OxLouGE98zrOZhI9QrZ1lN4WtgcQUH94krDgJj7Udw/IN/Ji+d/W
         LyDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/m+6/gHtitRcFwDRfgIzzOezx3KJKRXU/a2k3eD85GU=;
        b=FJwbvMYETP4YhMsG2lHzE0sCXNJmYMZWut29avVBlPrPkK7ts++1saE05uSVdjJjQ2
         UMaIlTfpSOXALvOrsOjZhQKklhVkouIzFPtKD7b1YynEVuFHlXWS9ZZaxhHfCTVlxomp
         tbLOjf5s5cmPc0IOWs+jSwFnjqs+UlmK8bCGExaMxRfSR7Af5hQfyFIW9Q3cxP1uFO+Q
         AOHG6NjdN/PcMrFylzjNVC79hlSVhEC+XkLSE++7F9XdGXIeIe/RgyBtDEoA8O+7SO/k
         qgdooBUV/OKw9AZPYQ1JAiN8Tz/2dakST+eYdTPi80rwc8m8Y+DL8ww7MWZoXOoujCwp
         UaKQ==
X-Gm-Message-State: APjAAAX/6ARsdI39acDhdl17caEcRzVJk6+qXDr8H8GcF2xAJ8LaKwUv
        U5LqErNuocqlaLc8M1PDsnjHy1iwjm57rnBltoGJkQ==
X-Google-Smtp-Source: APXvYqyzKRTHTvT+l4TdaQr2pk5kOvN2mGmw40JYEsRH+53Jof9zm1ZEoS9/lbvB60SM2gWBa8IruOgj0c8Qd9efzVY=
X-Received: by 2002:a0c:cdcb:: with SMTP id a11mr165374qvn.244.1580946787002;
 Wed, 05 Feb 2020 15:53:07 -0800 (PST)
MIME-Version: 1.0
References: <20200202014624.75356-1-hridya@google.com> <CAHC9VhR-aUtrU4PTibDLLG2S5GB9bx9MtwKuyH-x9eqSCmyP9w@mail.gmail.com>
In-Reply-To: <CAHC9VhR-aUtrU4PTibDLLG2S5GB9bx9MtwKuyH-x9eqSCmyP9w@mail.gmail.com>
From:   Hridya Valsaraju <hridya@google.com>
Date:   Wed, 5 Feb 2020 15:52:30 -0800
Message-ID: <CA+wgaPPEpmD50rBffh3NDhAfxLRJh13QT0NX80xOaEfotfXyqg@mail.gmail.com>
Subject: Re: [PATCH] selinux: Fix typo in filesystem name
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        Mark Salyzyn <salyzyn@android.com>, selinux@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 5, 2020 at 3:28 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Sat, Feb 1, 2020 at 8:46 PM Hridya Valsaraju <hridya@google.com> wrote:
> >
> > Correct the filesystem name to "binder" to enable
> > genfscon per-file labelling for binderfs.
> >
> > Fixes: 7a4b5194747 ("selinux: allow per-file labelling for binderfs")
> > Signed-off-by: Hridya Valsaraju <hridya@google.com>
> > ---
> >
> > Hello,
> >
> > I seem to have made the typo/mistake during a rebase. Sorry about that
> > :(
> >
> > Thanks,
> > Hridya
> >
> >  security/selinux/hooks.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Ooops :/
>
> Thanks for the fix.  I've merged this into selinux/stable-5.6, but due
> to some personal scheduling issues on my end I'm going to refrain from
> sending this to Linus until next week.

Thank you Paul and Stephen!

Regards,
Hridya

>
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 89fe3a805129..d67a80b0d8a8 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -699,7 +699,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
> >
> >         if (!strcmp(sb->s_type->name, "debugfs") ||
> >             !strcmp(sb->s_type->name, "tracefs") ||
> > -           !strcmp(sb->s_type->name, "binderfs") ||
> > +           !strcmp(sb->s_type->name, "binder") ||
> >             !strcmp(sb->s_type->name, "pstore"))
> >                 sbsec->flags |= SE_SBGENFS;
> >
> > --
> > 2.25.0.341.g760bfbb309-goog
>
> --
> paul moore
> www.paul-moore.com
