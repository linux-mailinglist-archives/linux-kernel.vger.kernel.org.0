Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 688D6170CED
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 01:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgB0AFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 19:05:01 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:36820 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgB0AFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 19:05:01 -0500
Received: by mail-il1-f196.google.com with SMTP id b15so797779iln.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 16:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h/9GGAuYdG+lV6Mcnmy3R/59iu7Yn//RJyM4cVFMhfE=;
        b=WXLjFVGn6mEbArPzDEPAutgUThJrPgjQPhpOjNZ+1lQfgjFPgbfhqjRs7G4SlHcoC4
         NwH0qbK+yfwfBAMFmNxfadEQh16USbJm7ash5LXFZVpBiiGiRI8tI+nUFEMcWwTLXnkW
         qv0DWkhxG0n+Fpypp1A+6eVuNQw+DU4N6O31MWRh/5L7MX6J2ucDC9a56GhHMZcqbIxl
         f6CV9nk5Op2aEizd3WOOGvpCdMPoUm5zmzvgobwtiJk/2PsEcgqX8cMDJ4kCLq1TZ6mF
         XhiHPBc4Zpsz0myaqwZlD2vZ3+MxI687GE5osc5PjAEA+ZZ4ox0RE2BuiYkRpPRWBqIk
         zW2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h/9GGAuYdG+lV6Mcnmy3R/59iu7Yn//RJyM4cVFMhfE=;
        b=rYEA4khmx1uOWpGW8zumF73HWGec+EeeCmlVWTvbtZazzUS3Qujow7iOVdOyY5wTFh
         Bx5gCEh6rTO+i0MdtvjLG4TdO9PDOrCBHuhw1kR4HIfZgRUmoXcLG0FEMLGVsGQm+Ixm
         ANZ4PVY+5jgjDYV8si7xJQJZlmj17uAd4876/PRscFQh8jlKtfhB4tTQjieg2WXYyROT
         FNwAK97JSKBW9/W90V1ZvGWIS/WLpvEM+AuZB5FmmkrcmVbLFA+XNFWsJkvBvs5tkyD/
         hxLavr9ETlSVnvAtdXvAEnghiztUpzyPTPKqjuEoti/fzuya3dFRnyccLTWsQAPJfnED
         hbGg==
X-Gm-Message-State: APjAAAVsmVn39qkJ2p5ZoO6tluVp7B+jnXkU6H2K7m7WcAO+UYxHPaJJ
        29G5J5ippwnyC8ETdWtzwcv1b9/kEdAIjptvD49V
X-Google-Smtp-Source: APXvYqwaqyhYf77l+HaJlYF5jLuD5Q0z0rbDGVFDtf2eY+cWu+kCSrCQ83S210VUEWMIa0qo0R5nTmF9FR0ZjglTsqo=
X-Received: by 2002:a92:1d5a:: with SMTP id d87mr1499236ild.27.1582761899306;
 Wed, 26 Feb 2020 16:04:59 -0800 (PST)
MIME-Version: 1.0
References: <20200225224719.950376311@linutronix.de> <20200225231609.000955823@linutronix.de>
 <CAMzpN2ij8ReOXZH00puhzraCGRdKY8qt+TMipd_14_XWTu8xtg@mail.gmail.com>
 <87k149p0na.fsf@nanos.tec.linutronix.de> <CAMzpN2j7EHZ2bKg9SZ2Ri-qsmEoknAAJO6O5yoLn-fY8_h1B2A@mail.gmail.com>
 <87eeugoqx2.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87eeugoqx2.fsf@nanos.tec.linutronix.de>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Wed, 26 Feb 2020 19:04:47 -0500
Message-ID: <CAMzpN2i2DUD5i0ui7HE_F7+U80hXs2Fa+RgZa_DOCsJ+Eae52Q@mail.gmail.com>
Subject: Re: [patch 01/15] x86/irq: Convey vector as argument and not in ptregs
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 6:43 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Brian Gerst <brgerst@gmail.com> writes:
> > On Wed, Feb 26, 2020 at 3:13 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >> Brian Gerst <brgerst@gmail.com> writes:
> >> Now the question is whether we care about the packed stubs or just make
> >> them larger by using alignment to get rid of this silly +0x80 and
> >> ~vector fixup later on. The straight forward thing clearly has its charm
> >> and I doubt it matters in measurable ways.
> >
> > I think we can get rid of the inversion.  That was done so orig_ax had
> > a negative number (signifying it's not a syscall), but if you replace
> > it with -1 that isn't necessary.  A simple -0x80 offset should be
> > sufficient.
> >
> > I think it's a worthy optimization to keep.  There are 240 of these
> > stubs, so increasing the allocation to 16 bytes would add 1920 bytes
> > to the kernel text.
>
> I rather pay the 2k text size for readable and straight forward
> code. Can you remind me why we are actually worrying at that level about
> 32bit x86 instead of making it depend on CONFIG_OBSCURE?

Because this also applies to the 64-bit kernel?

--
Brian Gerst
