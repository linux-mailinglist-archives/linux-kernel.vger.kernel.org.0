Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD5E88CFA5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 11:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfHNJcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 05:32:14 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:50425 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725265AbfHNJcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 05:32:14 -0400
X-Originating-IP: 92.137.69.152
Received: from localhost (alyon-656-1-672-152.w92-137.abo.wanadoo.fr [92.137.69.152])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id A792AC0006;
        Wed, 14 Aug 2019 09:32:09 +0000 (UTC)
Date:   Wed, 14 Aug 2019 11:32:08 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Lennart Poettering <mzxreary@0pointer.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        Karel Zak <kzak@redhat.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: New kernel interface for sys_tz and timewarp?
Message-ID: <20190814093208.GG3600@piout.net>
References: <CAK8P3a0VxM1BkjY1D2FfHi6L-ho_NH3v3+gBu45EfpjLF5NU5w@mail.gmail.com>
 <CAHk-=wiO2CWONDBud4nxoPgUJN1JEewFWhHa5wAqY8G5rrTXRQ@mail.gmail.com>
 <20190814000622.GB20365@mit.edu>
 <CAK8P3a1CXRETxn6Gh_cOxM3rZ-wUwVDu-7=yEwjqOY=uEdC6OQ@mail.gmail.com>
 <20190814090936.GB10516@gardel-login>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814090936.GB10516@gardel-login>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/08/2019 11:09:36+0200, Lennart Poettering wrote:
> On Mi, 14.08.19 10:31, Arnd Bergmann (arnd@arndb.de) wrote:
> 
> > - glibc stops passing the caller timezone argument to the kernel
> > - the distro kernel disables CONFIG_RTC_HCTOSYS,
> >   CONFIG_RTC_SYSTOHC  and CONFIG_GENERIC_CMOS_UPDATE
> 
> What's the benefit of letting userspace do this? It sounds a lot more
> fragile to leave this syncing to userspace if the kernel can do this
> trivially on its own.
> 

It does it trivially and badly:

 -  hctosys will always think the RTC is in UTC so if the RTC is in
    local time, you will anyway have up to 12 hours difference until
userspace fixes that.

 - the way systohc and hctosys are working will lead up to a 2 second
   drift until ntp runs which is an issue for NTP stratum servers. My
tests show that there is a way for userspace to reduce that to tens of
nanoseconds but this means having a one or two seconds delay when setting
and reading the time. I want that to be opt-in.

 - the RTC to be used for hctosys and systohc is hardcoded in Kconfig
   and distro usually let the default rtc0 but many platforms have a non
functional RTC that ends up being rtc0. I would prefer that to be a
userspace configuration change instead of a kernel configuration change

> IIRC there are uses in kernel that use CLOCK_REALTIME already before
> userspace starts. e.g. iirc networking generally prefers
> CLOCK_REALTIME timestamps over CLOCK_MONOTONIC timestamps
> (i.e. SO_TIMESTAMP and friends are still CLOCK_REALTIME only so far,
> unless I am missing something). If the kernel comes up with a
> CLOCK_REALTIME that starts at 0 this is pretty annoying I
> figure... Hence, so far I suggested to distros to continue turning on
> the options above, and let the kernel do this on its own without
> involving userspace in that.
> 
> Lennart
> 
> --
> Lennart Poettering, Berlin

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
