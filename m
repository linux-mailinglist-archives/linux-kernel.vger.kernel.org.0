Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 955A416F00D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 21:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731797AbgBYU1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 15:27:40 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:34529 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731565AbgBYU1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 15:27:39 -0500
Received: by mail-pj1-f65.google.com with SMTP id f2so1358698pjq.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 12:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tC1nYodbnDy4sNWTsQPnUP+L2m/IgHaO+SrkamcIlsk=;
        b=oQT+43q3D+8T41Mpemu9+X53sapJF0IHwLEc9L+FuS5/HlEBDG7zUG2peHu7RCbCFX
         3pJ3BjSWCv7it39emB95HfdmNyR7IGcpn0AC1H1S290CgXqUTInO0RCeGZu36ul0e3VL
         M7Ly5QgUxI+sOeP3Nf8hzYQsZ7nGoftgc7yU9qf5DratzhkyvLaNTwwlZB57u1a0CDEN
         Y71BUDUuEqQ9SGBNbtBo78gppwNr0snZJDHVHdUddePa+3m7/AjcuSQ1SdxMjT6zgjNu
         leZGSn4T1Yq6ZDNT5uYua+rarYsCu+9WtySmu6MLGNaw7pNTSZ2NOPAk/1Kw91beV9pD
         hOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tC1nYodbnDy4sNWTsQPnUP+L2m/IgHaO+SrkamcIlsk=;
        b=TBCD0mZldczBzPajV0smEoKnFKur0rgTDDV/KStTJOimXQUjHl5KpA6gRxQN3Q5LpY
         0Ov4mIBRkc/vqthgy2zod6e46RsTOORymzKet/znEmoKPfY3Nq5m1P87enNWJZbRBjfM
         fE0T0f5rBZF59ZMjq1mh+GYbJFCvqAmWuvH0dXI/ZU6s2/9mosdMeYBh3xNAixdRlOzD
         sz+vxgpIHTap35tqpnOmYn8wbnwqWs7QjFJEa/YREJJKHzbfKKpVAa137JSq3z1EMbgB
         rJUiLt4u9Ok7HB0KFUbGbf4HNm54/S1WyIKp+AIytw0rXPqIVO0kvdLqfJTm51MZoB2v
         yf/Q==
X-Gm-Message-State: APjAAAXesdvckcmzV2DEN3wK4lVrsZrS7CP5FZsn69wg9x1ZHzMfn7Or
        D3CwxyfFO7mHg1pvM2OLVpC1ILmX6EPELXWfhd0hVg==
X-Google-Smtp-Source: APXvYqwrT1jWL23GcqOoBUpV9rRsfvah/lMSQBrLZVT+2C5s6EqpIgbcdTCSSFlue2SZ4I4hbt/KInrtlkGuBJongyY=
X-Received: by 2002:a17:902:8a88:: with SMTP id p8mr269035plo.179.1582662457264;
 Tue, 25 Feb 2020 12:27:37 -0800 (PST)
MIME-Version: 1.0
References: <8bb16ac4b15a7e28a8e819ef9aae20bfc3f75fbc.1582266841.git.stefan@agner.ch>
 <CAKwvOdmV80xgvBnhB6ZpqYaqkxKi-_p+StnMojwNnf3kdxTT1A@mail.gmail.com> <CAKv+Gu881ZSwvuACmsbBnpfdeJpNYsEQxLSoepJBbZ=O6D6Rcg@mail.gmail.com>
In-Reply-To: <CAKv+Gu881ZSwvuACmsbBnpfdeJpNYsEQxLSoepJBbZ=O6D6Rcg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 25 Feb 2020 12:27:26 -0800
Message-ID: <CAKwvOd=9WaeVjvgkkLf5scFaNTpx28d4FAse62vv4X_mEwqRJA@mail.gmail.com>
Subject: Re: [PATCH] ARM: use assembly mnemonics for VFP register access
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Stefan Agner <stefan@agner.ch>, Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Jian Cai <jiancai@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Manoj Gupta <manojgupta@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 11:33 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Tue, 25 Feb 2020 at 20:10, Nick Desaulniers <ndesaulniers@google.com> =
wrote:
> > Ah, this is only when streaming to assembly. Looks like they have the
> > same encoding, and produce the same disassembly. (Godbolt emits
> > assembly by default, and has the option to compile, then disassemble).
> > If I take my case from godbolt above:
> >
> > =E2=9E=9C  /tmp arm-linux-gnueabihf-gcc -O2 -c x.c
> > =E2=9E=9C  /tmp llvm-objdump -dr x.o
> >
> > x.o: file format elf32-arm-little
> >
> >
> > Disassembly of section .text:
> >
> > 00000000 bar:
> >        0: f1 ee 10 0a                  vmrs r0, fpscr
> >        4: 70 47                        bx lr
> >        6: 00 bf                        nop
> >
> > 00000008 baz:
> >        8: f1 ee 10 0a                  vmrs r0, fpscr
> >        c: 70 47                        bx lr
> >        e: 00 bf                        nop
> >
> > So indeed a similar encoding exists for the two different assembler
> > instructions.
>
> Does that hold for ARM (A32) instructions as well?

TIL -mthumb is the default for arm-linux-gnueabihf-gcc -O2.

=E2=9E=9C  /tmp arm-linux-gnueabihf-gcc -O2 -c x.c -marm
=E2=9E=9C  /tmp llvm-objdump -dr x.o

x.o: file format elf32-arm-little


Disassembly of section .text:

00000000 bar:
       0: 10 0a f1 ee                  vmrs r0, fpscr
       4: 1e ff 2f e1                  bx lr

00000008 baz:
       8: 10 0a f1 ee                  vmrs r0, fpscr
       c: 1e ff 2f e1                  bx lr

^ Just to show the matching encoding.
--=20
Thanks,
~Nick Desaulniers
