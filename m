Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5F1ECF39C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 09:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730334AbfJHHUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 03:20:49 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:36523 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730144AbfJHHUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 03:20:48 -0400
Received: by mail-yw1-f66.google.com with SMTP id x64so6101849ywg.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 00:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vlcH/WZUIe1tFNe94ltDSVt7kfUxOrKgjsM+yEf+das=;
        b=QBybfdx0WhFzeUSvnu+iOZ8BN30w8BFc59qbkEiZJ2sA2O4CAg0vUm5RdT+1rcs89f
         Pw5cQWeeugWIH5NTcqfJGfC8O68msLLbpXAe6S+GCmBOW98SxXKGu7U/e6w02XnuBEY4
         MjumrKJIKlSx1MXljvhEEm4NLQ5/wdBak4vTxd596T7VFV63sc0pYZoLIOQwakOQArq6
         lmAtXwKYUxAaHO9h2Q9TKx9VODcX+G/2okGvNgDr4qFWq259bpumtBLc3/T0UDQj+1j/
         v9jgMLlB4oiC3egDdymwHJmDNv4VAyBo0aMffB9+TZwE1xuehAuL7MhTBTUc+KHwfBVw
         cYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vlcH/WZUIe1tFNe94ltDSVt7kfUxOrKgjsM+yEf+das=;
        b=KdKb6wKS+iuF2VV7/7DeadyI4Sbl/cQhZAwv1XpkHexej6tCK/E2TJNwvbCc1rxP4Y
         YT5+QtYOdPOmjHTQuNQedd/jY6L4o7mVPEMD/A8jVBafbigTp+fOv06g+IufxmEsxHkF
         GYMDWbOQxGLmZcpIkQBseW3KAjyL7hyAx811JP+hHK+/LfV/iOrpIsWRlrnZ/yLQjs7i
         W4/j+3YNn+pL8KCRVSBZcJkP0WwRKtn3qZYluI25AQDs5Ly6cFVnnJdfaFYKPRYcOPiX
         VYgZkY/+StzrHMIfigOrt8/TlaQe3GqiVYr6RQHJG1X7hE3dfvwEJUOsbe8vtrUHF965
         BS9Q==
X-Gm-Message-State: APjAAAW9nPcws9Hm9XoYNtgPVEyhm7fDYW/2SaBfUaBEJ/Jey007DdGS
        jFQrPRKnNEtvCQ6um/cBFwsjxlWCS8tqJkOnGgk=
X-Google-Smtp-Source: APXvYqwj62Yi+GVJBXzGytO8nIrTiGFbzVYO4xeKYQn0X6ubZwcIB7n4g0A4m089pqMPp80zVbhxmKUxGoa5o6XZC/s=
X-Received: by 2002:a0d:d7d1:: with SMTP id z200mr22934400ywd.464.1570519247780;
 Tue, 08 Oct 2019 00:20:47 -0700 (PDT)
MIME-Version: 1.0
References: <1569483508-18768-1-git-send-email-candlesea@gmail.com> <20190930153437.ocatny7u4z3oj7k2@willie-the-truck>
In-Reply-To: <20190930153437.ocatny7u4z3oj7k2@willie-the-truck>
From:   Candle Sun <candlesea@gmail.com>
Date:   Tue, 8 Oct 2019 15:20:36 +0800
Message-ID: <CAPnx3XMqnQ4R=_gkL6Rye=4adV=qCRUs2sm5A6kJccDCQ82xnw@mail.gmail.com>
Subject: Re: [RESEND PATCH] ARM/hw_breakpoint: add ARMv8.1/ARMv8.2 debug
 architecutre versions support in enable_monitor_mode()
To:     Will Deacon <will@kernel.org>
Cc:     mark.rutland@arm.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org,
        lkml <linux-kernel@vger.kernel.org>,
        Candle Sun <candle.sun@unisoc.com>,
        Nianfu Bai <nianfu.bai@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,
Sorry for not instant respond.


On Mon, Sep 30, 2019 at 11:34 PM Will Deacon <will@kernel.org> wrote:
>
> On Thu, Sep 26, 2019 at 03:38:28PM +0800, Candle Sun wrote:
> > From: Candle Sun <candle.sun@unisoc.com>
> >
> > When ARMv8.1/ARMv8.2 cores are used in AArch32 mode,
> > arch_hw_breakpoint_init() in arch/arm/kernel/hw_breakpoint.c will be used.
> >
> > From ARMv8 specification, different debug architecture versions defined:
> > * 0110 ARMv8, v8 Debug architecture.
> > * 0111 ARMv8.1, v8 Debug architecture, with Virtualization Host Extensions.
> > * 1000 ARMv8.2, v8.2 Debug architecture.
> >
> > So missing ARMv8.1/ARMv8.2 cases will cause enable_monitor_mode() function
> > returns -ENODEV, and arch_hw_breakpoint_init() will fail.
> >
> > Signed-off-by: Candle Sun <candle.sun@unisoc.com>
> > Signed-off-by: Nianfu Bai <nianfu.bai@unisoc.com>
> > ---
> >  arch/arm/include/asm/hw_breakpoint.h | 2 ++
> >  arch/arm/kernel/hw_breakpoint.c      | 2 ++
> >  2 files changed, 4 insertions(+)
>
> How did you test this?
>
> Will

We have the SoC with A55 cores. On one Android project, for saving memory usage,
we let A55 run in aarch32 mode.
While the following failures occue on Android CtsBionicTestCases:
--sys_ptrace#watchpoint_imprecisede
--sys_ptrace#hardware_breakpoint
--sys_ptrace#watchpoint_stress

The code snippet for testing is:

static void check_hw_feature_supported(pid_t child, HwFeature feature) {
#if defined(__arm__)
  long capabilities;
  long result = ptrace(PTRACE_GETHBPREGS, child, 0, &capabilities);
  if (result == -1) {
    EXPECT_EQ(EIO, errno);
    GTEST_SKIP() << "Hardware debug support disabled at kernel
configuration time";
  }
  uint8_t hb_count = capabilities & 0xff;
  capabilities >>= 8;
  uint8_t wp_count = capabilities & 0xff;
  capabilities >>= 8;
  uint8_t max_wp_size = capabilities & 0xff;
  if (max_wp_size == 0) {
    GTEST_SKIP() << "Kernel reports zero maximum watchpoint size";
  } else if (feature == HwFeature::Watchpoint && wp_count == 0) {
    GTEST_SKIP() << "Kernel reports zero hardware watchpoints";
  } else if (feature == HwFeature::Breakpoint && hb_count == 0) {
    GTEST_SKIP() << "Kernel reports zero hardware breakpoints";
  }
#elif defined(__aarch64__)
  user_hwdebug_state dreg_state;
  iovec iov;
  iov.iov_base = &dreg_state;
  iov.iov_len = sizeof(dreg_state);

  long result = ptrace(PTRACE_GETREGSET, child,
                       feature == HwFeature::Watchpoint ?
NT_ARM_HW_WATCH : NT_ARM_HW_BREAK, &iov);
  if (result == -1) {
    ASSERT_EQ(EINVAL, errno);
  }
  if ((dreg_state.dbg_info & 0xff) == 0) GTEST_SKIP() << "hardware
support missing";
#else
  // We assume watchpoints and breakpoints are always supported on x86.
  UNUSED(child);
  UNUSED(feature);
#endif
}

The max_wp_size field returned by __ptrace() from kernel is zero,
which causes the test failures.

After futher analysis, we found max_watchpoint_len variable is not
right initialized in kernel
arch_hw_breakpoint_init() function. Missing the case of ARM_DEBUG_ARCH_V8_2 in
enable_monitor_mode() directly aborts the arch_hw_breakpoint_int().

Candle
Best regards
