Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61FA4968BD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 20:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730503AbfHTSsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 14:48:01 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:44597 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729351AbfHTSsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 14:48:01 -0400
X-Originating-IP: 90.65.161.137
Received: from localhost (lfbn-1-1545-137.w90-65.abo.wanadoo.fr [90.65.161.137])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id E0D24FF802;
        Tue, 20 Aug 2019 18:47:55 +0000 (UTC)
Date:   Tue, 20 Aug 2019 20:47:55 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Karel Zak <kzak@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Arnd Bergmann <arnd@arndb.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: New kernel interface for sys_tz and timewarp?
Message-ID: <20190820184755.GP3545@piout.net>
References: <CAK8P3a0VxM1BkjY1D2FfHi6L-ho_NH3v3+gBu45EfpjLF5NU5w@mail.gmail.com>
 <CAHk-=wiO2CWONDBud4nxoPgUJN1JEewFWhHa5wAqY8G5rrTXRQ@mail.gmail.com>
 <20190814000622.GB20365@mit.edu>
 <CAK8P3a1CXRETxn6Gh_cOxM3rZ-wUwVDu-7=yEwjqOY=uEdC6OQ@mail.gmail.com>
 <20190814090936.GB10516@gardel-login>
 <20190814093208.GG3600@piout.net>
 <20190819110903.if3dzhvfnlqutn6s@ws.net.home>
 <alpine.DEB.2.21.1908191541340.2147@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1908191541340.2147@nanos.tec.linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/08/2019 15:43:03+0200, Thomas Gleixner wrote:
> On Mon, 19 Aug 2019, Karel Zak wrote:
> > On Wed, Aug 14, 2019 at 11:32:08AM +0200, Alexandre Belloni wrote:
> > > On 14/08/2019 11:09:36+0200, Lennart Poettering wrote:
> > > > On Mi, 14.08.19 10:31, Arnd Bergmann (arnd@arndb.de) wrote:
> > > > 
> > > > > - glibc stops passing the caller timezone argument to the kernel
> > > > > - the distro kernel disables CONFIG_RTC_HCTOSYS,
> > > > >   CONFIG_RTC_SYSTOHC  and CONFIG_GENERIC_CMOS_UPDATE
> > > > 
> > > > What's the benefit of letting userspace do this? It sounds a lot more
> > > > fragile to leave this syncing to userspace if the kernel can do this
> > > > trivially on its own.
> > 
> > Good point, why CONFIG_RTC_SYSTOHC has been added to the kernel? 
> 
> 023f333a99ce ("NTP: Add a CONFIG_RTC_SYSTOHC configuration")

This answers only half the question. The follow up is then why do we
need update_persistent_clock?

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
