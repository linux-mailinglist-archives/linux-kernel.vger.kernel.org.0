Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9416CC79
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 12:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389453AbfGRJ77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 05:59:59 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36671 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfGRJ77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 05:59:59 -0400
Received: by mail-io1-f68.google.com with SMTP id o9so50564994iom.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 02:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=td1HNio79rUWb+NcoR9IwgMiKGmE3lwyhncFJcCDp44=;
        b=IZAppM5Y50mja8NGPFV1GDclMbKijeYYcITtnbJ6sW6aMb3OVXWrOo4LZ4Xig7oVel
         36ShU61KzqQm2/2ozUBFLA0WwfcQR9sxpDbt+ngZrxG7adBuYr+ZEFOOVpFS/3xfRYow
         LvZtfWwCiLIFUdwxjN6KrnAJC4Au27s7E/o3EvS7IUzy4OkIniS26Nc9iA20eIiZAIan
         xL/JuG9IXv6RZmdYD/8/XGw8wGo3e4zGbNVmNgkxR0m7GaotSdbgeomdzWnKUubdWcau
         vhM3tb7E/o9TTQ2YrxjwjZWpJrf24ngRD+mePZLl8IWwBFods8EvW3uR/zSUjWfce5KP
         aJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=td1HNio79rUWb+NcoR9IwgMiKGmE3lwyhncFJcCDp44=;
        b=GQQFWmgxajmgY1AH0FwONzZLPkSu1umD1T0FStyuMV81zq6ThORS6hWDcWWY+O3UqM
         ZuLCAMpwmmlsfJQt7X+UQo511IYF5lltKJ0nDT8Ha1GdKn3dPrgmus2/LIi8EZn0KAoj
         hfvdfr3Pi4vYinQcdKPEKdGXFSQV3g0LapMJKqQmjjHBG/CuxB/1jtwBeDs6EnUxJD/d
         w6o3JlRksUDOrVtgrS+BxV3Whc3Co5dVxmPb6ZNPY1Ae9moNLpJFxEMmTcjlH8GQsBjE
         e0dqwnYJQ7X6HTklvDO4YIXob4ewS8ZERwhS/wzgrhIsHbS+JZPBK8iEF63SL7fz2O0B
         hSgw==
X-Gm-Message-State: APjAAAVW9MaSD9fs2uTR8AMualLOwhimkbxTvYZd1ESIoNM4KaSI5/Zh
        xqbVx+wb+b4sGWpG8AAjjNkhDQPh3993+SxoFqA=
X-Google-Smtp-Source: APXvYqzud4Nxrnbh/PR/qsFuLeijrfWc+GtbQkjrYSx0pkm9JVhMAxNcRNl3hHIX/xhg46sLiQ+hB988QEtyYUyyPD0=
X-Received: by 2002:a02:4005:: with SMTP id n5mr48318285jaa.73.1563443998110;
 Thu, 18 Jul 2019 02:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190716072805.22445-1-pmladek@suse.com>
In-Reply-To: <20190716072805.22445-1-pmladek@suse.com>
From:   Konstantin Khlebnikov <koct9i@gmail.com>
Date:   Thu, 18 Jul 2019 12:59:47 +0300
Message-ID: <CALYGNiPETLPeOOuRwQtYca=yrwWHgg11A6Fc_qZipG56N8KP8A@mail.gmail.com>
Subject: Re: [PATCH 0/2] panic/printk/x86: Prevent some more printk-related
 deadlocks in panic()
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Tesarik <ptesarik@suse.cz>, x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 10:28 AM Petr Mladek <pmladek@suse.com> wrote:
>
> Hi,
>
> I have found some spare duct tape and wrapped some more printk-related
> deadlocks in panic().
>
> More seriously, someone reported a deadlock in panic(). Some non-trivial
> debugging pointed out a problem with the following combination:
>
>      + x86_64 architecture
>      + panic()
>      + pstore configured as message dumper (kmsg_dump())
>      + crash kernel configured
>      + crash_kexec_post_notifiers
>
> In this case, CPUs are stopped by crash_smp_send_stop(). It uses
> NMI but it does not modify cpu_online_mask. Therefore logbuf_lock
> might stay locked, see 2nd patch for more details.
>
> The above is a real corner case. But similar problem seems to be
> even in the common situations on architectures that do not use
> NMI in smp_send_stop() as a fallback, see 1st patch.
>
> Back to the duct tape. I hope that we will get rid of these problems
> with the lockless printk ringbuffer rather sooner than later.
> But it still might take some time. And the two fixes might be
> useful also for stable kernels.

Looks good.

Reviewed-by: Konstantin Khebnikov <khlebnikov@yandex-team.ru>

>
>
> Petr Mladek (2):
>   printk/panic: Access the main printk log in panic() only when safe
>   printk/panic/x86: Allow to access printk log buffer after
>     crash_smp_send_stop()
>
>  arch/x86/kernel/crash.c     |  6 +++++-
>  include/linux/printk.h      |  6 ++++++
>  kernel/panic.c              | 49 +++++++++++++++++++++++++++------------------
>  kernel/printk/printk_safe.c | 37 ++++++++++++++++++++++------------
>  4 files changed, 65 insertions(+), 33 deletions(-)
>
> --
> 2.16.4
>
