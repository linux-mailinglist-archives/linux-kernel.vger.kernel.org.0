Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 433578D86A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 18:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbfHNQsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 12:48:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52443 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbfHNQsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 12:48:41 -0400
Received: from [IPv6:2601:646:8600:3281:2c7e:a77e:9d52:7c32] ([IPv6:2601:646:8600:3281:2c7e:a77e:9d52:7c32])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x7EGllrZ1907212
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Wed, 14 Aug 2019 09:48:01 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com x7EGllrZ1907212
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565801283;
        bh=etksQiyq83kHLcBsVn7h/6r7t63sqJ6ZCqfbAq4s+jQ=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=afIXOvzQgx2qnlUply+r6xDQ/x1UoaNoAc80t7FMe+ADbLOY7B8I85FxiGS41ewHv
         XmobnrMVZGAAOAA3+CPcfoYqjFCiyF12rgTiNgGTPXUzSphHqYR6CTpRqGWOIU3cd8
         UURdgkI8mNPSrEfi+nZX3zyWtIQN54jdfFuhB815yqvTII0/8x1LHJr3II4E66gd2H
         roKmSp76TUtmYxRgrGhE00kpjNpi7nkr2LDk9hUoMrlZ1mu3JjPn8mh+vMdqRrUrMp
         MPIxtDTWgs8tbCZhQqpmOrRUxobIU3xJCQ51x3zAJFnEPq5/L/cvQ/aWq8h6BBoMtJ
         /DxyLVXZZju5g==
Date:   Wed, 14 Aug 2019 09:47:39 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <342565604d704b6ebaf2e9ec28d3e109@AcuMS.aculab.com>
References: <CAK8P3a0VxM1BkjY1D2FfHi6L-ho_NH3v3+gBu45EfpjLF5NU5w@mail.gmail.com> <CAHk-=wiO2CWONDBud4nxoPgUJN1JEewFWhHa5wAqY8G5rrTXRQ@mail.gmail.com> <20190814000622.GB20365@mit.edu> <342565604d704b6ebaf2e9ec28d3e109@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: RE: New kernel interface for sys_tz and timewarp?
To:     David Laight <David.Laight@ACULAB.COM>,
        "'Theodore Y. Ts'o'" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        Karel Zak <kzak@redhat.com>,
        Lennart Poettering <lennart@poettering.net>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
From:   hpa@zytor.com
Message-ID: <0089C4CC-DD85-48A1-869B-A9D71852BEC7@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On August 14, 2019 9:26:36 AM PDT, David Laight <David=2ELaight@ACULAB=2ECO=
M> wrote:
>From: Theodore Y=2E Ts'o
>> Sent: 14 August 2019 01:06
>> On Tue, Aug 13, 2019 at 10:30:34AM -0700, Linus Torvalds wrote:
>> >
>> > I suspect the only actual _valid_ use in the kernel for a time zone
>> > setting is likely for RTC clock setting, but even that isn't really
>> > "global", as much as "per RTC"=2E
>>=20
>> As I recall (and I may or may not have been original for the original
>> sys_tz; it was many years ago, and my memories of 1992 are a bit
>> fuzzy) the only reason why we added it was because x86 systems that
>> were dual-booting with Windows had a RTC which ticked localtime, and
>> originally, the system time was fetched from the RTC in early boot,
>> and then when the timezone was set, the time would be warped so it
>> would be correct=2E
>
>x86 systems are very likely to have the RTC set by the bios config=2E
>In which case it will almost certainly get set to local time=2E
>It is certainly the default for windows installs - I don't even know
>if you have any other option=2E
>
>The 'real fun' (tm) happens when a dual boot system changes from
>winter to summer time=2E
>ISTR that it is quite easy to get both (or more) OS to change the
>RTC by an hour (I went home an hour early one year)=2E
>Although the x86 RTC chip has a bit defined for 'summertime', nothing
>sets it (at least when I looked)=2E
>
>	David
>
>-
>Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes,
>MK1 1PT, UK
>Registration No: 1397386 (Wales)

I believe Windows 10 changed the default RTC to UTC, although perhaps only=
 if running under UEFI=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
