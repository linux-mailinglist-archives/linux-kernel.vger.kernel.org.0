Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A62A13FA72
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 21:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733233AbgAPUUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 15:20:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:38550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbgAPUUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 15:20:05 -0500
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AB0C2081E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 20:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579206004;
        bh=oko1vr6NZIkbqblBi6ADclwFu8hYoUF6zOgs+mmCjwY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=L+rMfwJVUI9W+d2CoFvavrawmV6XxbnS/C5pFOW3GNaz/dDJWJPZM8duGoLOAL4lG
         Z02NHO/8MGKmfFb7GIu6L6UBs5VQJuL2gCzfJtQIf5HIZsqZ0+yd6MnHhIphnFuyoZ
         f3RLMs/ybk1B0MMAwdTLCraQ7qACz4TRbZO2ykR0=
Received: by mail-wm1-f42.google.com with SMTP id q9so5124735wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 12:20:03 -0800 (PST)
X-Gm-Message-State: APjAAAXIOeAdWHYffJJKftFocKyW3tv5jiwtrT9dxnVnxyQyfIPFKGj6
        NQ3NF6GUufaPVfm8qb1H/soLO2pPPelGu7YaPzUaGA==
X-Google-Smtp-Source: APXvYqy/LKhOLCc4c+qZpvX/KQlnVohcy3HlKPdTJR43s7e+TgAW2p8Y+rne7KnqV+o60SXTwTHEOrPWPUde8RosJLE=
X-Received: by 2002:a05:600c:20c7:: with SMTP id y7mr794016wmm.21.1579206002474;
 Thu, 16 Jan 2020 12:20:02 -0800 (PST)
MIME-Version: 1.0
References: <cover.1579196675.git.christophe.leroy@c-s.fr> <1b278bc1f6859d4df734fb2cde61cf298e6e07fd.1579196675.git.christophe.leroy@c-s.fr>
 <874kwvf9by.fsf@nanos.tec.linutronix.de>
In-Reply-To: <874kwvf9by.fsf@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 16 Jan 2020 12:19:50 -0800
X-Gmail-Original-Message-ID: <CALCETrX9+PZ1h6xex2WZcSqNT7W-6R-E95jv9hLhSdAzhMCrTA@mail.gmail.com>
Message-ID: <CALCETrX9+PZ1h6xex2WZcSqNT7W-6R-E95jv9hLhSdAzhMCrTA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 08/11] lib: vdso: allow fixed clock mode
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, nathanl@linux.ibm.com,
        Arnd Bergmann <arnd@arndb.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 12:14 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>
> Can you please adjust the prefix for future patches to lib/vdso: and
> start the sentence after the colon with an uppercase letter?
>
> > On arches like POWERPC, the clock is always the timebase, it
>
> Please spell out architectures. Changelogs are not space constraint.
>
> > cannot be changed on the fly and it is always VDSO capable.
>
> Also this sentence does not make sense as it might suggests that
> architectures with a fixed compile time known clocksource have something
> named timebase. Something like this is more clear:
>
> Some architectures have a fixed clocksource which is known at compile
> time and cannot be replaced or disabled at runtime, e.g. timebase on
> PowerPC. For such cases the clock mode check in the VDSO code is
> pointless.
>

I wonder if we should use this on x86 bare-metal if we have
sufficiently invariant TSC.  (Via static_cpu_has(), not compiled in.)
Maybe there is no such x86 machine.

I really really want Intel or AMD to introduce machines where the TSC
pinky-swears to count in actual nanoseconds.

--Andy
