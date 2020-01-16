Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE2013FF9E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 00:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388527AbgAPXoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 18:44:20 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42704 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729354AbgAPXoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:44:17 -0500
Received: by mail-wr1-f65.google.com with SMTP id q6so20861155wro.9;
        Thu, 16 Jan 2020 15:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dHTGBkgzigId/zi0TOnYQjBsf6HAV19Aov7etVocQr4=;
        b=nkMxee7mkhPsFnsTSgqVfS0Up+8cTe72MvM/2bMae4kd1D0j7q1OUOdW0oLJxBbSIK
         9Bi90ue3VO7d+kNj/BGIwnKKDFCAeb3JxpNleXMZETVXxztv1FIZFCIO66SPBeHDnkXJ
         WDA0TAbej0BCxjfO9HgpdHtEkdbpsP2wkxY/ktTPOF9jGQpd5h0kup9rrP8UKQ+AEy9B
         xzLvt3IZ71WZZRPbY9DQFQrKlS5Qf9aZSejvh9ePXKBHpsxk695jLXQSpp9oGijyPgno
         CECYx2xCkwz1/b/1dPu/WExst1CjFWG8F8q7i4DfSFwFRLPE9uSSS7gyOHJu+f0PCG6F
         1iRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dHTGBkgzigId/zi0TOnYQjBsf6HAV19Aov7etVocQr4=;
        b=afV3VYKGK5218MYzMGyt18Ek89FQBZP7TdmhlXWt53us5TUNdgmLdLu3GjQjBRL/h9
         GzR1TUyf1ZbNNj4up3oLDSIco36BYQwvQB+YG3L5MVqRto5Q10GHlVRNE6WsC+1DSv+K
         z5GR8wGXtQYD2NXWIysRUb7mz5+1DDO4Ic+LHO5kDR0snieLtW1dfEW9BScIuqmK4q/B
         Tky3v4X+KdZ9SmHv0iTX3w+BNw13BNxg+rSfhxkzI8WvwOJDHYzKMNDMGUAtbY/onMff
         hyWfnFtlLbQ/eUotKBw5QJG8kUg3b5/xpGk6FUyCgNKqILek4btRopbPvOnHpvZmJ9pQ
         ZCuA==
X-Gm-Message-State: APjAAAVrVS33ee6z61JGJWNNp4tVDEgk2G1DCv5+PSRPngVYSn76CBsq
        imGdQZ+D1tK7T1Bdwec2MUbkkpzd9dIpKA6IqG7/bsFa
X-Google-Smtp-Source: APXvYqzqW75Nq6g1kCwaCaY8GLY0vks1V3PmDr3vfRkYbRP+psJfmZtTg8T656o2Zp8oScWytghb39gCT2F8UkX0DLo=
X-Received: by 2002:adf:f606:: with SMTP id t6mr5632437wrp.85.1579218254750;
 Thu, 16 Jan 2020 15:44:14 -0800 (PST)
MIME-Version: 1.0
References: <20200113105156.25945-1-geert@linux-m68k.org>
In-Reply-To: <20200113105156.25945-1-geert@linux-m68k.org>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Fri, 17 Jan 2020 00:44:03 +0100
Message-ID: <CAFLxGvxNUcKiaCxXy_oracH-3xg3MPETxkaDqgtkMkB1vp-02Q@mail.gmail.com>
Subject: Re: [PATCH] ubifs: Fix ino_t format warnings in orphan_delete()
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Richard Weinberger <richard@nod.at>, linux-s390@vger.kernel.org,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        linux-alpha@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 11:52 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> On alpha and s390x:
>
>     fs/ubifs/debug.h:158:11: warning: format =E2=80=98%lu=E2=80=99 expect=
s argument of type =E2=80=98long unsigned int=E2=80=99, but argument 4 has =
type =E2=80=98ino_t {aka unsigned int}=E2=80=99 [-Wformat=3D]
>     ...
>     fs/ubifs/orphan.c:132:3: note: in expansion of macro =E2=80=98dbg_gen=
=E2=80=99
>        dbg_gen("deleted twice ino %lu", orph->inum);
>     ...
>     fs/ubifs/orphan.c:140:3: note: in expansion of macro =E2=80=98dbg_gen=
=E2=80=99
>        dbg_gen("delete later ino %lu", orph->inum);
>
> __kernel_ino_t is "unsigned long" on most architectures, but not on
> alpha and s390x, where it is "unsigned int".  Hence when printing an
> ino_t, it should always be cast to "unsigned long" first.
>
> Fix this by re-adding the recently removed casts.
>
> Fixes: 8009ce956c3d2802 ("ubifs: Don't leak orphans on memory during comm=
it")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  fs/ubifs/orphan.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied! Thank you, Geert.

--=20
Thanks,
//richard
