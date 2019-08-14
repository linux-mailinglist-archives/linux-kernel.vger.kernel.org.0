Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46DF18CF25
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 11:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfHNJRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 05:17:48 -0400
Received: from gardel.0pointer.net ([85.214.157.71]:34924 "EHLO
        gardel.0pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfHNJRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 05:17:47 -0400
X-Greylist: delayed 489 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Aug 2019 05:17:47 EDT
Received: from gardel-login.0pointer.net (gardel.0pointer.net [85.214.157.71])
        by gardel.0pointer.net (Postfix) with ESMTP id EF34CE80937;
        Wed, 14 Aug 2019 11:09:36 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id 950C2160102; Wed, 14 Aug 2019 11:09:36 +0200 (CEST)
Date:   Wed, 14 Aug 2019 11:09:36 +0200
From:   Lennart Poettering <mzxreary@0pointer.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        Karel Zak <kzak@redhat.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: New kernel interface for sys_tz and timewarp?
Message-ID: <20190814090936.GB10516@gardel-login>
References: <CAK8P3a0VxM1BkjY1D2FfHi6L-ho_NH3v3+gBu45EfpjLF5NU5w@mail.gmail.com>
 <CAHk-=wiO2CWONDBud4nxoPgUJN1JEewFWhHa5wAqY8G5rrTXRQ@mail.gmail.com>
 <20190814000622.GB20365@mit.edu>
 <CAK8P3a1CXRETxn6Gh_cOxM3rZ-wUwVDu-7=yEwjqOY=uEdC6OQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1CXRETxn6Gh_cOxM3rZ-wUwVDu-7=yEwjqOY=uEdC6OQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mi, 14.08.19 10:31, Arnd Bergmann (arnd@arndb.de) wrote:

> - glibc stops passing the caller timezone argument to the kernel
> - the distro kernel disables CONFIG_RTC_HCTOSYS,
>   CONFIG_RTC_SYSTOHC  and CONFIG_GENERIC_CMOS_UPDATE

What's the benefit of letting userspace do this? It sounds a lot more
fragile to leave this syncing to userspace if the kernel can do this
trivially on its own.

IIRC there are uses in kernel that use CLOCK_REALTIME already before
userspace starts. e.g. iirc networking generally prefers
CLOCK_REALTIME timestamps over CLOCK_MONOTONIC timestamps
(i.e. SO_TIMESTAMP and friends are still CLOCK_REALTIME only so far,
unless I am missing something). If the kernel comes up with a
CLOCK_REALTIME that starts at 0 this is pretty annoying I
figure... Hence, so far I suggested to distros to continue turning on
the options above, and let the kernel do this on its own without
involving userspace in that.

Lennart

--
Lennart Poettering, Berlin
