Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D88C25EF15
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2019 00:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbfGCWSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 18:18:21 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36862 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbfGCWSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 18:18:20 -0400
Received: by mail-lj1-f193.google.com with SMTP id i21so4121394ljj.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 15:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XmNRMZPexYeFI2JOkBwrntyrv2GLwXAQxAQNTx885uI=;
        b=GF7p0TUHyVuJCGDIY9EyZ2Z1cC3qsnfvz5onDlEY4h8gR13S9VkdQy/4cxfwyHR0B3
         8gCQhZMZCNKxYTWwZuuAeea6LVdTZ706VwzVpFA90Vd6i3TXF69pPv+Xel1T/SMft1Av
         XL/LAUrQRe+NItpFOvgLI6PMsX5fM2ETsJfWacfajPjbecLqTrgawQmT6TwqazuP6B8G
         eEyEpTDgpkCbv1gaI4XmdX9q3QysJnjuZD0Y/5ByTWfdQjyFTYF3qqbwm+Yz+OqTeZAp
         FTjl3tHGfVqOtS5+1Az32rkH86Z3686vmLjDRsMGBgJvKY7MEO7Wux+rlEnIgGZ3AzTn
         kQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XmNRMZPexYeFI2JOkBwrntyrv2GLwXAQxAQNTx885uI=;
        b=W8/ASjjNZ7UENqV95uOcAy1GgZTPqnt0TdpI20I9X0HVb1Ru7Cp11/1012oTHhFl5l
         Bm/0GYuAGGLpti53uS6/ymDT2EWlA5F0y7RqIrhYaJlxgtwSzFPapxic+56bS1WXALR1
         O6ziZjcgKHUEQZ+ePAUmHlMqnzjwc1z393KeKVJUat6TFW0KgfxI2rkHda04ei2761Rv
         SzwT8mBs71pTDDj4C2PnFbEU4G5jhjiALKupVZWl79lfW2sKU7aTFzL68mDvgHWMpyUE
         8dNYekkHi9VSwzuj9YqEOC+BKmcl7XZLNgIc1w3lYMqKuyuxuufB/0cJXorxNP57i/pd
         4THg==
X-Gm-Message-State: APjAAAX6fNYeVovP8jJk5P76ryoMgIdFeL2Wuy5YzvWYYh3O9GoH+Mie
        O4hYDN2wI5eZahMDIy4XGfgUUC6OjpZ8GXpd50w=
X-Google-Smtp-Source: APXvYqwQzzyUDQm5HZ71B2lpzcEJsd0ykOrbzIe/LJ1Hd2/jKnuX7noF9BxVzZHWDD2ph/4Wf14spMMUmUjtE6Vd+CU=
X-Received: by 2002:a2e:9758:: with SMTP id f24mr6429781ljj.58.1562192298725;
 Wed, 03 Jul 2019 15:18:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190703001842.12238-1-alistair.francis@wdc.com>
 <20190703001842.12238-3-alistair.francis@wdc.com> <CAK8P3a37GLzp+w6m0SEV+9j_6sH91SuStyAEW-VzuJ5_dUCnZw@mail.gmail.com>
 <CAKmqyKP07futGV1WsZwvqGzeR646eo-ysVy9RCqaSOG-2qhH_g@mail.gmail.com> <CAK8P3a1zJPiR06uxZ5QVoEyDU64v=oUu_p9X-mULLeXN-som8A@mail.gmail.com>
In-Reply-To: <CAK8P3a1zJPiR06uxZ5QVoEyDU64v=oUu_p9X-mULLeXN-som8A@mail.gmail.com>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Wed, 3 Jul 2019 15:15:13 -0700
Message-ID: <CAKmqyKMtsQaq9DpfPY=T0pixrH2sntewDz42dTvD5rDcK+ZV0w@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv/include/uapi: Define a custom __SIGINFO struct
 for RV32
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Alistair Francis <alistair.francis@wdc.com>,
        linux-riscv-bounces@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 3, 2019 at 12:47 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Jul 3, 2019 at 8:45 PM Alistair Francis <alistair23@gmail.com> wrote:
> >
> > On Wed, Jul 3, 2019 at 1:41 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > On Wed, Jul 3, 2019 at 2:21 AM Alistair Francis
> > > <alistair.francis@wdc.com> wrote:
> > > >
> > > > The glibc implementation of siginfo_t results in an allignment of 8 bytes
> > > > for the union _sifields on RV32. The kernel has an allignment of 4 bytes
> > > > for the _sifields union. This results in information being lost when
> > > > glibc parses the siginfo_t struct.
> > >
> > > I think the problem is that you incorrectly defined clock_t to 64-bit,
> > > while it is 32 bit in the kernel. You should fix the clock_t definition
> > > instead, it would otherwise cause additional problems.
> >
> > That is the problem. I assume we want to change the kernel to use a
> > 64-bit clock_t.
>
> Certainly not!
>
> Doing so would likely involve deprecating all system calls that
> take a clock_t (anything passing a struct siginfo or struct tms) and
> replacements based on clock64_t.

Ah, that's really easy to fix then.

>
> > What I don't understand though is how that impacted this struct, it
> > doesn't use clock_t at all, everything in the struct is an int or
> > void*.
>
> si_utime/si_stime in siginfo are clock_t.

But they are further down the struct. I just assumed that GCC would
align those as required, I guess it aligns the start of the struct to
match some 64-bit members which seems strange.

Alistair

>
>       Arnd
