Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4317B70ADE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 22:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbfGVUwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 16:52:55 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41799 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfGVUwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 16:52:55 -0400
Received: by mail-ed1-f65.google.com with SMTP id p15so41782456eds.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 13:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GMLjbC9YjRUgCF5zGAKD15kt9b4CY1BkByLwAzTGVzU=;
        b=Jp9cBTPwU29wiqBjXqSNe2Ds3OiKv8dsKfL3Phe5kkNX25x/T28nL3L+8191B3JCPR
         hy1sk5Bxfh+AwS4A7EkGg9n2/EpBnGq/Umc8w5i0nBFGgOChJCBXdAgT/IxxQINxsWOo
         plgQv2oNd2yzIlQknQ/QTj+tJFoAuGi+nAOxlaG98kAZ00jU8FmzG2/c5vxKUdYfa7XF
         zOLDTdNEojTG2AlB5NYAoHBnggaUwMVmoO5LIpBj0VdKrk26EHUsn111w7w3FV4VRH0Y
         7Q/I2d5ouTAaUsap3LyQVTZFqEeJQLtzpSaExYDAMv6GqQH2CWvp4jl3HCrV3CqRbpdD
         DfhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GMLjbC9YjRUgCF5zGAKD15kt9b4CY1BkByLwAzTGVzU=;
        b=XZYgvhSdlFNbUWkvTpigLciKaLUFVJ15xRpfmcQmOAgPyomOu6gKs+FbTMWZig1Yjd
         qh7JONRCJHsA4U87cvitsc3lKb7uLSKSxpZtV0dguuVPR64Nc/nVVmU6lPOG74dEq+Qn
         urpPsXhb7nlLp9vGzuRYU4QDjZZ6jXH4LDOuEqnra8EnpMcHHs8rNL/jYMurgwt3WO5j
         MqSHhEbR5aFQ252TcC7a+EinUAwd9GIX1cJjMlJjPVrzGDvpp3lwwAClqRFoDFtZ7i1E
         nYIVS8BYJfbK2bW8l8oWG2DA1GyPoh3joTYzC6IQQgE/mJoR8COhIrk6knjVtsP8xwtY
         Okjw==
X-Gm-Message-State: APjAAAU0twD/DLHy6EcL6Twjo8gaRYtbvNc36fvwuGnUSDx0YwvuOxjo
        5zzAoXuuWak3Ix7S6QgP/MSyi+G5QNYsu43UM1o=
X-Google-Smtp-Source: APXvYqxA8mp6pHUExIYVYg514P87IzaOJ2cRvoDp4dYaIO6GxWQ4MfK0zzMrz18CXiYpnSXjzFce1A5e9xB8fqm2emw=
X-Received: by 2002:a05:6402:14c4:: with SMTP id f4mr61443251edx.170.1563828773560;
 Mon, 22 Jul 2019 13:52:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190722103330.255312-1-marc.zyngier@arm.com>
In-Reply-To: <20190722103330.255312-1-marc.zyngier@arm.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Mon, 22 Jul 2019 13:52:42 -0700
Message-ID: <CA+CK2bAFgDcc6ySCz7zzyeN0wg5WTcxFrKYQ6y5sz7grw-BfAw@mail.gmail.com>
Subject: Re: [PATCH 0/3] arm64: Allow early timestamping of kernel log
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 3:33 AM Marc Zyngier <marc.zyngier@arm.com> wrote:
>
> So far, we've let the arm64 kernel start its meaningful time stamping
> of the kernel log pretty late, which is caused by sched_clock() being
> initialised rather late compared to other architectures.
>
> Pavel Tatashin proposed[1] to move the initialisation of sched_clock
> much earlier, which I had objections to. The reason for initialising
> sched_clock late is that a number of systems have broken counters, and
> we need to apply all kind of terrifying workarounds to avoid time
> going backward on the affected platforms. Being able to identify the
> right workaround comes pretty late in the kernel boot, and providing
> an unreliable sched_clock, even for a short period of time, isn't an
> appealing prospect.
>
> To address this, I'm proposing that we allow an architecture to chose
> to (1) divorce time stamping and sched_clock during the early phase of
> booting, and (2) inherit the time stamping clock as the new epoch the
> first time a sched_sched clock gets registered.

Could we have a stable clock config for arm64: if it is known that
this Linux build is going to run on non-broken firmware, and with a
known stable cntvct_el0 register it can be optionally configured to
use that stable sched_clock instead of generic clock that arm64 is
using? This way, the early printk are going to be available on those
systems without adding a different method for printk's only. It would
also mean that other users of early sched_clock() such as ftrace could
benefit from it.

>
> (1) would allow arm64 to provide a time stamping clock, however
> unreliable it might be, while (2) would allow sched_clock to provide
> time stamps that are continuous with the time-stamping clock.
>
> The last patch in the series adds the necessary logic to arm64,
> allowing the (potentially unreliable) time stamping of early kernel
> messages.
>
> Tested on a bunch of arm64 systems, both bare-metal and in VMs. Boot
> tested on a x86 guest.
>
> [1] https://lore.kernel.org/patchwork/patch/1015110/
>
> Marc Zyngier (3):
>   printk: Allow architecture-specific timestamping function
>   sched/clock: Allow sched_clock to inherit timestamp_clock epoch
>   arm64: Allow early time stamping
>
>  arch/arm64/Kconfig          |  3 +++
>  arch/arm64/kernel/setup.c   | 44 +++++++++++++++++++++++++++++++++++++
>  include/linux/sched/clock.h | 13 +++++++++++
>  kernel/printk/printk.c      |  4 ++--
>  kernel/time/sched_clock.c   | 10 +++++++++
>  5 files changed, 72 insertions(+), 2 deletions(-)
>
> --
> 2.20.1
>
