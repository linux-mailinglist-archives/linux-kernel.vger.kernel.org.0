Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78A15F98B1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 19:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfKLSdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 13:33:35 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46083 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbfKLSdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 13:33:35 -0500
Received: by mail-wr1-f66.google.com with SMTP id b3so19634059wrs.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 10:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MzMUKm7mW+HiS0KEQh6EiE2vBd+rpZ1avgmO/GjuR8I=;
        b=eAThWRNSQOzWC8Xx6+6jsVEniEBzDbLr/wjeljUOoxx683Mx+TQM0py2RJ6BdmGM0V
         3LZddmT1dxWMQyJdnA2cPCJTzHtnjev0mBRtfzAe5JRm/tPdkncQptAlGGOFT3DxCnOF
         qixjtpn776Y5Xm3uNY+fhZd7MfeMb6Vz0IdbkfGNH7lLOPlw36i2vHJEs9sH4duCoj6p
         OaCXftU6JEM7Cf3odOVhMSq0lxDNwSFmPksFWa9rCWEogaohxtzZz5E4OGpPZlmhjaMA
         RxAPU4DDbjLv2V80wd9MmoE67eQh2w9pQV8tAAtOoXI06zrazZuRTc95HVceTiPzZ0/6
         zIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MzMUKm7mW+HiS0KEQh6EiE2vBd+rpZ1avgmO/GjuR8I=;
        b=VKB5N/EgUic/m4xBL5teUr/TUeU7l8whd4Pzx8eJGTfE8sXOo+awkGu3GyC3zoOM7S
         HvwpyDyXM/yexzdOlGggvmsGL3a4OO++RCoB6cV7Lo4S1zTrJy8d/WH2HyTfGn7xIUDn
         f7y96Mk/xPb9cnPuLikCbJjJWbiBvx4/f+CmLJIUXWUluSG5/QL1VHMHTLBH19py3nLr
         02d+wIgxh1/XFgPUD3fMip4l9PB6EJy+gS88/9GaVwfPvGxgfGvNNA5qvp7ceeaQ5fJK
         cZ6FKlJW1s7VFL/ptz0a15FkkbujdJCLcW+cuWHM9jTVnKgwPKBCDRaMtLrRksW2clex
         zpLg==
X-Gm-Message-State: APjAAAXkCC8q8jI1gRmuDPVrgfJ9XpfKI5SkOkp4ObBVIMqVAanrAVZv
        cOqVsMF0ovA+Lg67SqfStSEbuSPNpAf6u0OrYWZL5g==
X-Google-Smtp-Source: APXvYqxeErPjC1+irjMBoCjBQePU2ciTNK2Cd/02XOe6SmdpmpN+6TWyIwmapdLCP17ZKTaWE/H1tYh+6ekN0cyV33g=
X-Received: by 2002:adf:ffd0:: with SMTP id x16mr3612529wrs.86.1573583612669;
 Tue, 12 Nov 2019 10:33:32 -0800 (PST)
MIME-Version: 1.0
References: <C377A5F1-F86F-4A27-966F-0285EC6EA934@linux.alibaba.com> <20191112154144.GC168812@cmpxchg.org>
In-Reply-To: <20191112154144.GC168812@cmpxchg.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 12 Nov 2019 10:33:21 -0800
Message-ID: <CAJuCfpE7OG6mzSFXhqqoiN8UhcPcEGVn_9NRXgkBxMOvFyhZdg@mail.gmail.com>
Subject: Re: [PATCH] psi:fix divide by zero in psi_update_stats
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     tim <xiejingfeng@linux.alibaba.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 7:41 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Fri, Nov 08, 2019 at 03:33:24PM +0800, tim wrote:
> > In psi_update_stats, it is possible that period has value like
> > 0xXXXXXXXX00000000 where the lower 32 bit is 0, then it calls div_u64 which
> > truncates u64 period to u32, results in zero divisor.
> > Use div64_u64() instead of div_u64()  if the divisor is u64 to avoid
> > truncation to 32-bit on 64-bit platforms.
> >
> > Signed-off-by: xiejingfeng <xiejingfeng@linux.alibaba.com>
>
> This is legit. When we stop the periodic averaging worker due to an
> idle CPU, the period after restart can be much longer than the ~4 sec
> in the lower 32 bits. See the missed_periods logic in update_averages.
>
> What is surprising is that you can hit this repeatedly, as the odds
> are 1 in 4,294,967,296. An extremely coarse clock source?
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>
> There are several more instances of div_u64 in psi.c. They all look
> fine to me except for one in the psi poll() windowing code, where we
> divide by the window size, which can be up to 10s. CCing Suren.
>
> ---
> From 009cece5f37a38f4baeb1bebdcb432ac9ae66ef8 Mon Sep 17 00:00:00 2001
> From: Johannes Weiner <hannes@cmpxchg.org>
> Date: Tue, 12 Nov 2019 10:35:26 -0500
> Subject: [PATCH] psi: fix a division error in psi poll()
>
> The psi window size is a u64 an can be up to 10 seconds right now,
> which exceeds the lower 32 bits of the variable. But div_u64 is meant
> only for 32-bit divisors. Use div64_u64 for the 64-bit divisor.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  kernel/sched/psi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 517e3719027e..84af7aa158bf 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -481,7 +481,7 @@ static u64 window_update(struct psi_window *win, u64 now, u64 value)
>                 u32 remaining;
>
>                 remaining = win->size - elapsed;
> -               growth += div_u64(win->prev_growth * remaining, win->size);
> +               growth += div64_u64(win->prev_growth * remaining, win->size);
>         }
>
>         return growth;
> --
> 2.24.0
>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>
