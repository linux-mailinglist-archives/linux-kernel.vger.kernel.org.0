Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F86418D6B0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 19:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbgCTSTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 14:19:32 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41866 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgCTSTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 14:19:32 -0400
Received: by mail-io1-f65.google.com with SMTP id y24so6920171ioa.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 11:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jIQSdWr0oHV4OIyHiNzKHtfCGVAX3O/l7l9f4QUta70=;
        b=K3XmZrJ23rrzvUUxHJfd3l8QhcbYeONYjlIY/8W6YpX3mVqV/LOBzBzb2n3wB0Fh5w
         487QD7EFS7XeSfBcaKa0jtUOrFBNf4Uu4JxmzBKY1rBLAdUk+g0sTb+b9c/+Q2t/nw0m
         FplDZ783dyvo7ya3WEcaWOBlLtF9Z4MSX/UuB6929Sqculj916YO1iOdK1gadNKT70fE
         O4Y4uuBIOeU21M59OhcQFgE38+GSan1e+mts0oxLrqNjhQzG7RjJv2wmpVrm/fcCsBXF
         eOWJreSraDC/p9upSDlLLJPX8xtCA2Dv6995X+9E7UQwSeZxNLuMLakgL05NO6Rxocws
         HSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jIQSdWr0oHV4OIyHiNzKHtfCGVAX3O/l7l9f4QUta70=;
        b=o99RRHCOeR8OgCop5EZmpzK4t77wQPYBs86pEpWdcU/gE+gNiPPz54E6TkjfpUciBt
         5uPnFTSDL8Lxxuwnnh4haC+WANoEEKynKKFnpzDkF1ozA8OZabydtGYG9SdWwkKHrY+M
         3aJicWlqh3pjVpKU1Iz9Wr9Jj/JDpJ026XS4cpEyVobP1esMqhvZ7n0xVT2w+IomxF+9
         iF9auRon76WVRGCHJeEmtoBSRW7qJmbRmjakY6ZbN05zI5F/hQPkzR6zXk6daRoNDVnH
         F81JQhD0OE90TWJKSf7dB71ANrL1EF7Ej0Ee3egbxQ9wEbfg2UY9f1AvkBenpTkz3AWu
         C2wQ==
X-Gm-Message-State: ANhLgQ26X0Lvv4+vUCmJDrokqkgXwKbSVDoNyZEsPqTHFBxeAhzVCBtH
        z9pnTXBZB2ssb8QEnbH3VY1uduPThlN2LWV+7oxS7w==
X-Google-Smtp-Source: ADFU+vt+2ciHEPtiNNdll+Gg793qeHEtLTVBQGChIQgNb4nzKr0A70xZ/0OqCYHbrVcFtK9CuIVwJTjzmfe4iMvbEZs=
X-Received: by 2002:a02:740d:: with SMTP id o13mr9079623jac.113.1584728371234;
 Fri, 20 Mar 2020 11:19:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAP6exY+LnUXaOVRZUXmi2wajCPZoJVMFFAwbCzN3YywWyhi8ZA@mail.gmail.com>
 <D31718CF-1755-4846-8043-6E62D57E4937@zytor.com> <CAP6exYJHgqsNq84DCjgNP=nOjp1Aud9J5JAiEZMXe=+dtm-QGA@mail.gmail.com>
 <8E80838A-7A3F-4600-AF58-923EDA3DE91D@zytor.com>
In-Reply-To: <8E80838A-7A3F-4600-AF58-923EDA3DE91D@zytor.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Fri, 20 Mar 2020 11:19:19 -0700
Message-ID: <CACdnJusmAHJYauKvHEXNZKaUWPqZoabB_pSn5WokSy_gOnRtTw@mail.gmail.com>
Subject: Re: [PATCH 1/1] x86 support for the initrd= command line option
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     ron minnich <rminnich@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE..." <x86@kernel.org>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 5:59 PM <hpa@zytor.com> wrote:

> It has been designated consumed by the bootloader on x86 since at least 1995. So ARM broke it.

Eh. This feels like a matter of semantics - booting the kernel via EFI
results in it being parsed by the boot stub, so in that case we're
left arguing that the boot stub isn't the kernel. I can just about buy
that, but it's a stretch. For this change to actually break something,
we'd need the bootloader to be passing something that the kernel
parses, but not actually populating the initrd fields in bootparams.
That seems unlikely?
