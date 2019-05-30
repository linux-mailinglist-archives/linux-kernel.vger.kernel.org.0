Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33A9B303C5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 23:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfE3VFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 17:05:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:40724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbfE3VFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 17:05:50 -0400
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C10B261B9
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 21:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559250349;
        bh=aX4nWpK3YPagRgr8m+/PDxPcJhmavRTwT1hAhpBBjhc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P8feyAZTdY6tYSIMaxhOd9VKwkYsoguGLmVosrWiC6G8IzzXHAPvMUXiOuApTaLTM
         vn7at6FJJUNb67uHqqWFkG3bo9gg2ymv/3ZBs+kAIvkhkxOlSkbcPNS8+jublJyGpF
         SatAbgSICW1YmddRGQpjDj5hH0cWmtOnq2EKRZ8E=
Received: by mail-wm1-f48.google.com with SMTP id 15so4611371wmg.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 14:05:49 -0700 (PDT)
X-Gm-Message-State: APjAAAXgdxjnmBNXC/Mxp7MUXgCTi95fAzvaMwIqvX5UvOKTDbIcuMKl
        J+ZzaPhdbCIHd16MzOPRpgDZIiJLyZIPBzNOLS85ZQ==
X-Google-Smtp-Source: APXvYqzXUTbDrA3vUqBAbcXhZxg9NZts1vRUB+Qvc7Dbln+5et7YUa8U6E6+YShFvjBZK6B0hkZLvoV1ryQMwDGFYew=
X-Received: by 2002:a7b:c450:: with SMTP id l16mr3048203wmi.0.1559250347748;
 Thu, 30 May 2019 14:05:47 -0700 (PDT)
MIME-Version: 1.0
References: <1558742162-73402-1-git-send-email-fenghua.yu@intel.com> <1558742162-73402-3-git-send-email-fenghua.yu@intel.com>
In-Reply-To: <1558742162-73402-3-git-send-email-fenghua.yu@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 30 May 2019 14:05:36 -0700
X-Gmail-Original-Message-ID: <CALCETrUiVVNMmVCuZgZi4UWGpWd+K=+8Mx3+DhcjzmQ55MxGbA@mail.gmail.com>
Message-ID: <CALCETrUiVVNMmVCuZgZi4UWGpWd+K=+8Mx3+DhcjzmQ55MxGbA@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] x86/umwait: Initialize umwait control values
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 5:05 PM Fenghua Yu <fenghua.yu@intel.com> wrote:
>
> umwait or tpause allows processor to enter a light-weight
> power/performance optimized state (C0.1 state) or an improved
> power/performance optimized state (C0.2 state) for a period
> specified by the instruction or until the system time limit or until
> a store to the monitored address range in umwait.
>
> IA32_UMWAIT_CONTROL MSR register allows kernel to enable/disable C0.2
> on the processor and set maximum time the processor can reside in
> C0.1 or C0.2.
>
> By default C0.2 is enabled so the user wait instructions can enter the
> C0.2 state to save more power with slower wakeup time.
>
> Default maximum umwait time is 100000 cycles. A later patch provides
> a sysfs interface to adjust this value.

Reviewed-by: Andy Lutomirski <luto@kernel.org>

with the caveat that we should really clean up our CPU init code to
have a function like cpu_prepare_for_user_code() that is called on all
CPUs after every boot, resume, etc before running user code.  This
would subsume syscall_init().

--Andy
