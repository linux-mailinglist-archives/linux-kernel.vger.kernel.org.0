Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87C05AC601
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2019 12:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730858AbfIGKK0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 7 Sep 2019 06:10:26 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:52527 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726012AbfIGKK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 06:10:26 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 18407577-1500050 
        for multiple; Sat, 07 Sep 2019 11:10:07 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <CAHk-=wi_nBULUyO=OKtNBCZ+VSqdOcEiUeFqXTQY_D5ga5k4gQ@mail.gmail.com>
Cc:     Bandan Das <bsd@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
References: <CAHk-=wi_nBULUyO=OKtNBCZ+VSqdOcEiUeFqXTQY_D5ga5k4gQ@mail.gmail.com>
Message-ID: <156785100521.13300.14461504732265570003@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: Linux 5.3-rc7
Date:   Sat, 07 Sep 2019 11:10:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Linus Torvalds (2019-09-02 18:28:26)
> Bandan Das:
>       x86/apic: Include the LDR when clearing out APIC registers

Apologies if this is known already, I'm way behind on email.

I've bisected

[   18.693846] smpboot: CPU 0 is now offline
[   19.707737] smpboot: Booting Node 0 Processor 0 APIC 0x0
[   29.707602] smpboot: do_boot_cpu failed(-1) to wakeup CPU#0

https://intel-gfx-ci.01.org/tree/drm-tip/igt@perf_pmu@cpu-hotplug.html

to 558682b52919. (Reverts cleanly and fixes the problem.)

I'm guessing that this is also behind the suspend failures, missing
/dev/cpu/0/msr, and random perf_event_open() failures we have observed
in our CI since -rc7 across all generations of Intel cpus.
-Chris
