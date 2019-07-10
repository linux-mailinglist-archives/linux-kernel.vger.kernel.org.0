Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49F7D63EC3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 03:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfGJBAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 21:00:00 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:32847 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfGJBAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 21:00:00 -0400
Received: by mail-lj1-f193.google.com with SMTP id h10so313540ljg.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 17:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OvAATq4R+gy+yYzQ8CqqnHuyozjiwmzvP0peipTOQ2I=;
        b=cLb1CB3EKHK5mPZjv/fx4S81m/axAd114z8Qzs8NAiMPanQnUJI7CNrdjFN9mo7nBT
         +/W/EVAHWvOcAYVZ9S0FA0U9u06pUsVJyK241JJOYfZUP1wbY2hAZ/HhPVoiOtfRyHl/
         aQ3yJW0k9d/yBW7bKv0sFGzrJAA648lXqH+sU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OvAATq4R+gy+yYzQ8CqqnHuyozjiwmzvP0peipTOQ2I=;
        b=MhJHZxjkuERUEOsi4kVjHyNcYtNr+7FGyTYjaqLoiVJJr/2YFNqdnEKioQ39+5hNtE
         aIv40jPHU2V2+dQdBIjqMzqBcxmXJBUisQ5yY1siXCbpGp3dxDc4JfCJD1UtPaJ2/Qne
         hAXmiOgFZWhAxiqfApTpsl2pHDF4lm6xmZmTBq0QPUK5njBX84OYAAiuOrAM1iCgW093
         Dy42jFgK2+8IC1m0Bp4NOlw3EfEr5OGm8E6/ZMcATLkOWtaO65UCXKJEbV1sMenqGZxg
         MQO+uJYvcWYTja826fCLoziY8ap/XTDesVi5HEe1aJ7y3+7vbnkfdFvg7jh8WEi69Rsk
         CNIA==
X-Gm-Message-State: APjAAAXf8qc3e4NkJUNkCo9CQ36oEj3on7wN3W0AlIkbrKzy3hAYOI4t
        Jb5GUkci0uugB6uKcqSY7ieVtNPpNqs=
X-Google-Smtp-Source: APXvYqyOcEG9NqwOqXcEqjERQQKJdT1ZRh8KLhC9m+djWDHPs1JUcJmEr9olOMjPPObPtiVO4U+/6w==
X-Received: by 2002:a2e:b0e6:: with SMTP id h6mr9507706ljl.18.1562720396522;
        Tue, 09 Jul 2019 17:59:56 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id r68sm83273lff.52.2019.07.09.17.59.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 17:59:56 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id r15so308763lfm.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 17:59:55 -0700 (PDT)
X-Received: by 2002:ac2:5601:: with SMTP id v1mr13266778lfd.106.1562720395536;
 Tue, 09 Jul 2019 17:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190708162756.GA69120@gmail.com> <CAHk-=wigbHd6wXcrpH+6jnDe=e+OHFy6-KdVSUP2yU5aip-UAg@mail.gmail.com>
 <CAHk-=wgkWTtW-JWVAO0Y6s=dRgZGAaTWAsOuYaTFNJzkF+Z_Jg@mail.gmail.com>
 <CAHk-=whJtbQFHNtNG7t7y6+oEKLpjj3eSQOrr3OPCVGbMaRz-A@mail.gmail.com>
 <CAHk-=wh7NChJP+WkaDd3qCz847Fq4NdQ6z6m-VFpbr3py_EknQ@mail.gmail.com>
 <alpine.DEB.2.21.1907100023020.1758@nanos.tec.linutronix.de> <alpine.DEB.2.21.1907100039540.1758@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1907100039540.1758@nanos.tec.linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 9 Jul 2019 17:59:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj5E=WTz3jfNFnupCPoLXDyFZdW1xgKvuuU-M1_7MEqaw@mail.gmail.com>
Message-ID: <CAHk-=wj5E=WTz3jfNFnupCPoLXDyFZdW1xgKvuuU-M1_7MEqaw@mail.gmail.com>
Subject: Re: [GIT PULL] x86/topology changes for v5.3
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@kernel.org>, Kees Cook <keescook@chromium.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>, Jiri Kosina <jkosina@suse.cz>,
        Bob Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 9, 2019 at 4:00 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> That still does not explain the cr4/0 issue you have. Can you send me your
> .config please?

Gaah. Now I'm off my desktop and won't be at it again until tomorrow.
And that's the one that bisected to the cr0/cr4 bits (and I did all my
bisection on that because it's so much faster).

Anyway, the kernel config itself is pretty simple. It's basically a
F30 kernel config that has been through "make localmodconfig" and then
pared down some more to remove stuff I don't use (paravirt etc). I
would expect that if it's a confiuration difference, it's more likely
to be about the user mode side - since the hang does seem to happen in
user mode, not in the kernel (but a very early problem at cpu bringup
time could easily have been hidden).

On my laptop (which I am at right now), the hang is different, and
maybe it's similar to your ACPI hang issue. I will try that revert,
and at least see if that solves the laptop side.

                    Linus
