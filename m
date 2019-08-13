Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71ED98BFFF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 19:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbfHMRz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 13:55:28 -0400
Received: from zimbra.cs.ucla.edu ([131.179.128.68]:33280 "EHLO
        zimbra.cs.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbfHMRz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 13:55:27 -0400
X-Greylist: delayed 381 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Aug 2019 13:55:26 EDT
Received: from localhost (localhost [127.0.0.1])
        by zimbra.cs.ucla.edu (Postfix) with ESMTP id A263716272D;
        Tue, 13 Aug 2019 10:49:04 -0700 (PDT)
Received: from zimbra.cs.ucla.edu ([127.0.0.1])
        by localhost (zimbra.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Avtv7kHLBo3l; Tue, 13 Aug 2019 10:49:03 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.cs.ucla.edu (Postfix) with ESMTP id D6F6316272F;
        Tue, 13 Aug 2019 10:49:03 -0700 (PDT)
X-Virus-Scanned: amavisd-new at zimbra.cs.ucla.edu
Received: from zimbra.cs.ucla.edu ([127.0.0.1])
        by localhost (zimbra.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id B3FBW389qoKq; Tue, 13 Aug 2019 10:49:03 -0700 (PDT)
Received: from [192.168.1.9] (cpe-23-242-74-103.socal.res.rr.com [23.242.74.103])
        by zimbra.cs.ucla.edu (Postfix) with ESMTPSA id 4DC3F16272D;
        Tue, 13 Aug 2019 10:49:03 -0700 (PDT)
Subject: Re: New kernel interface for sys_tz and timewarp?
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        Karel Zak <kzak@redhat.com>,
        Lennart Poettering <lennart@poettering.net>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
References: <CAK8P3a0VxM1BkjY1D2FfHi6L-ho_NH3v3+gBu45EfpjLF5NU5w@mail.gmail.com>
 <CAHk-=wiO2CWONDBud4nxoPgUJN1JEewFWhHa5wAqY8G5rrTXRQ@mail.gmail.com>
From:   Paul Eggert <eggert@cs.ucla.edu>
Organization: UCLA Computer Science Department
Message-ID: <ecf2742a-6cab-cc00-16ab-589fad07b8db@cs.ucla.edu>
Date:   Tue, 13 Aug 2019 10:49:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiO2CWONDBud4nxoPgUJN1JEewFWhHa5wAqY8G5rrTXRQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> I assume/think that glibc uses (a) environment
> variables and (b) a filesystem-set default (per-user file with a
> system-wide default? I don't know what people do).
glibc relies on the TZ environment variable, with a system-wide default 
specified in /etc/localtime or suchlike (there is no per-user default). glibc 
ignores the kernel's 'struct timezone' settings for of this, as 'struct 
timezone' is obsolete/vestigial and doesn't contain enough info to do proper 
conversions anyway.

I've been thinking of adding NetBSD's localtime_rz etc. functions to glibc. 
These functions let user programs specify the time zone for each conversion 
between time_t and local time, and simplify and/or speed up applications dealing 
with many requests coming from different time zones. These functions also ignore 
'struct timezone'.

There's no need to put any of this stuff into the kernel.
