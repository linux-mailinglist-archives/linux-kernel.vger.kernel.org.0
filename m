Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03FF4116BA6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2019 12:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfLILCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 06:02:31 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38400 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfLILCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:02:31 -0500
Received: by mail-ot1-f67.google.com with SMTP id h20so11800986otn.5;
        Mon, 09 Dec 2019 03:02:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fJNDi0M45jZlryP2aMU9SVRVU8qA2CoeN4czv5XE8B0=;
        b=dCUqEjh9x4+cZLqWy2jS6zA8TI9k5OmbMq6a4Q+tI8D3eeDVo6gZZbdh9rIcixZctv
         KhumO9mG8mBQTZKf2Z2yFBrAc9js6Bzq6WsGW0WFHOOl5XuyukVYnmy/yOgCowJNn5o2
         tDQDJ+S1hkyQP2t+HKw5jka8aF2DGkKAGkpWrUNgYA0eY5ubkdEKW5tqE9Itnletp+k+
         KEsbvPMZl8bo7gHPeBXUGt+6RHp5d4O6OmsNz540mTBn6cLsoP6FD4nRzkwATXhhjbhO
         PYxHSih883TXVzoPpG2Tdz0wl2enOoJ39aEvY+oee7JJKA3ClGV7RhN0nfh2DP90KadQ
         k8kQ==
X-Gm-Message-State: APjAAAUOqbzKJEmyiojW37wMyRnXAf0w6ziAAiC3xQH053GTTajhBQFd
        h94Oi2tmjrWG4+LvdUe+p/w6rnIbyzJnGxCiceY=
X-Google-Smtp-Source: APXvYqyASDMcvMVSw4ovcmQTB9nrbrRo9vpc8QeLZxBQuzWqrh2Fn/ZsF/x2Wn3kfeBGED/KFwngR4cbLXN67MVIfhE=
X-Received: by 2002:a9d:dc1:: with SMTP id 59mr13146650ots.250.1575889350841;
 Mon, 09 Dec 2019 03:02:30 -0800 (PST)
MIME-Version: 1.0
References: <20191209105613.2491-1-geert@linux-m68k.org>
In-Reply-To: <20191209105613.2491-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 Dec 2019 12:02:19 +0100
Message-ID: <CAMuHMdV+4Q2atJUPsYuc+UFxyoh1fscQL7aLUp4CWrb7=U706g@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.5-rc1
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 9, 2019 at 11:57 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Below is the list of build error/warning regressions/improvements in
> v5.5-rc1[1] compared to v5.4[2].
>
> Summarized:
>   - build errors: +2/-8
>   - build warnings: +84/-87
>
> Happy fixing! ;-)
>
> Thanks to the linux-next team for providing the build service.
>
> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/e42617b825f8073569da76dc4510bfa019b1c35a/ (all 232 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/219d54332a09e8d8741c1e1982f5eae56099de85/ (all 232 configs)
>
>
> *** ERRORS ***
>
> 2 error regressions:
>   + error: "clk_set_min_rate" [drivers/devfreq/tegra30-devfreq.ko] undefined!:  => N/A
>   + error: tegra30-devfreq.c: undefined reference to `clk_set_min_rate':  => .text+0xcc8)

sh-all{mod,yes}config

Legacy non-CCF platform do not provide clk_set_min_rate(), so this needs
a dependency on CCF.

BTW, it seems this was already known back in June...
https://lore.kernel.org/linux-pm/5301c593-97e1-db4e-067b-0522537b55d9@gmail.com/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
