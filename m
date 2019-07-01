Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 337EA258C9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 22:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfEUUXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 16:23:15 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40623 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfEUUXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 16:23:15 -0400
Received: by mail-lf1-f66.google.com with SMTP id h13so14089536lfc.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 13:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zGsw9meU7G7A0v7S1hg5gO3PLF4ljBd/H9BbyFd15lI=;
        b=HqKCwuT9NgzPlNJEQQgvXHwD7HXgSK6qbTCAn2LBRBYBkytl76mpo8cUd5UKFp9EOf
         /Szn6BnjZHiQ3dDQWF4XPDA+atwwQNAenY4XxM2olDm+MUCpItHqQ3y+jfptPguxsf17
         IN4NTAuxZm7P501M66GJGS53cf2g13hUCPmpWHcFA5njypWWbIp+yKLenGQBl3Qvv5b2
         GGJ/fEHOzgn0Kgy+6e2t4e6Jrfs/U3f0kFvoq0PrK5z/gUpFgCvdbNJIwBkQEHfnKFWi
         4/KxP1EC89eK0+ZZYqE0BPZOc0xl6P/aaIGKmnY3Htfcup78Xeu9l2VQiuMYNhJ0HcTT
         fPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zGsw9meU7G7A0v7S1hg5gO3PLF4ljBd/H9BbyFd15lI=;
        b=UX20W09KcKxczdzZsULOZ0WlLonZ+zRrD/kSHBh7vVon6eCAtaxT9QzPz6cXG1myhY
         P7AWuKKFN7InsyzXPNDXoFwBOyzoceMd4REXhOrm3xPEEOqWATQSTS1yYnS/LJkIt+OC
         /unpiE5qOYwtk7EMVLtNHSDtUF4x6nBfKwnjWPr7h7WUcVP3uBbihR+LAYk+4thl4hW2
         EyyrqSz/nJeYMrI9NyamCf2lg/6XqXQxNePmtyffMxtVlZ7Jl2uj4b32t0kWGvLBojeq
         901I0ny95rZe5wTi/tpGQdZp63H/tF2r6+jq5seZ9AyExDwO8UQ1xWawIIRO6dwAMMWi
         cy2g==
X-Gm-Message-State: APjAAAXqxJ79dPrYGYWOiuGQ2SG04V8gAvlRUs0Zrby1ZwFOb4IZbKWD
        a5zCJsCCALAn2eF6KuDJrTwiGf5XHzFGX7f3KOst
X-Google-Smtp-Source: APXvYqzHlwpTLSoRvolURDbkMpTjw0qqLpb4HAJpk1RmFIiCs77jeOpTtGriolNM07oCrkf7jyZcPKBmjfsbMiF7Eag=
X-Received: by 2002:a19:a8b:: with SMTP id 133mr1605852lfk.35.1558470192678;
 Tue, 21 May 2019 13:23:12 -0700 (PDT)
MIME-Version: 1.0
References: <1557296477-4694-1-git-send-email-hofrat@osadl.org>
 <CAHC9VhSU7pzWby78gHkYKm3t1LopSCoHBfmp=uBc+mF234K8mg@mail.gmail.com>
 <20190509001345.GA23407@osadl.at> <CAHC9VhQ2qnZEzJAh027TgT8LMrtpzLyj79p=BCVGJKSFMQjjEw@mail.gmail.com>
In-Reply-To: <CAHC9VhQ2qnZEzJAh027TgT8LMrtpzLyj79p=BCVGJKSFMQjjEw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 21 May 2019 16:23:01 -0400
Message-ID: <CAHC9VhRPZKHt7EoK=O2keuyMm=fYyEAbWjJTG0uFA_Z6o_0-3A@mail.gmail.com>
Subject: Re: [PATCH RFC] selinux: provide __le variables explicitly
To:     Nicholas Mc Guire <der.herr@hofr.at>
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        peter enderborg <peter.enderborg@sony.com>,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 9, 2019 at 3:40 PM Paul Moore <paul@paul-moore.com> wrote:
> On Wed, May 8, 2019 at 8:14 PM Nicholas Mc Guire <der.herr@hofr.at> wrote:
> > On Wed, May 08, 2019 at 05:47:32PM -0400, Paul Moore wrote:
> > > On Wed, May 8, 2019 at 2:27 AM Nicholas Mc Guire <hofrat@osadl.org> wrote:
> > > > While the endiannes is being handled properly sparse was unable to verify
> > > > this due to type inconsistency. So introduce an additional __le32
> > > > respectively _le64 variable to be passed to le32/64_to_cpu() to allow
> > > > sparse to verify proper typing. Note that this patch does not change
> > > > the generated binary on little-endian systems - on 32bit powerpc it
> > > > does change the binary.
> > > >
> > > > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > > > ---
> > > >
> > > > Problem located by an experimental coccinelle script to locate
> > > > patters that make sparse unhappy (false positives):
> > > >
> > > > sparse complaints on different architectures fixed by this patch are:
> > > >
> > > > ppc6xx_defconfig
> > > >   CHECK   security/selinux/ss/ebitmap.c
> > > > security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> > > > security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> > > > security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> > > > security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> > > > security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> > > > security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> > > > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > > > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > > > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > > > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > > > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > > > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > > > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > > > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > > > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > > > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > > >
> > > > Little-endian systems:
> > > >
> > > > loongson3_defconfig
> > > > security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> > > > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > > >
> > > > x86_64_defconfig
> > > > security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> > > > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > > >
> > > > Patch was compile-tested with: x86_64_defconfig,loongson3_defconfig (both
> > > > little-endian) and ppc603_defconfig (big-endian).
> > > >
> > > > On little-endian systems the patch has no impact on the generated binary
> > > > (which is expected) but on the 32bit powerpc it does change the binary
> > > > which is not expected but since I'm not able to generate the .lst files
> > > > in security/selinux/ss/ due to the lack of a Makefile it is not clear
> > > > if this is an unexpected side-effect or due only to the introduction of
> > > > the additional variables. From my understanding the patch does not change
> > > > the program logic so if the code was correct on big-endian systems before
> > > > it should still be correct now.
> > >
> > > This is a bit worrisome, but I tend to agree that this patch *should*
> > > be correct.  I'm thinking you're probably right in that the resulting
> > > binary difference could be due to the extra variable.  Have you tried
> > > any other big-endian arches?
> > >
> >
> > just tried ppc64_defconfig + AUDIT=y, SECURITY=y, SECURITY_NETWORK=y, SECURITY_SELINUX=y
> >
> > sparse will complain in the original version about:
> >   CHECK   security/selinux/ss/ebitmap.c
> > security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> > security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> > security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> > security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> > security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> > security/selinux/ss/ebitmap.c:389:28: warning: cast to restricted __le32
> > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> > security/selinux/ss/ebitmap.c:431:23: warning: cast to restricted __le64
> >
> > which is the same as 32bit ppc - after the patch is applied that is resolved
> > and and the generated ebitmap.o files are binary identical.
> >
> > I just had chosen ppc6xx_defconfig as my big-endian test-target as SELINUX
> > was on there by default so I assumed it would be the most reasonable
> > compile-test target.
>
> Thanks.
>
> I think this is probably safe to merge once the merge window closes.

... and that time is now; merged into selinux/next.  Thanks.

/me crosses his fingers on this one

-- 
paul moore
www.paul-moore.com
