Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 818C3FFE8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 20:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfD3Sqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 14:46:37 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46198 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfD3Sqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 14:46:36 -0400
Received: by mail-ed1-f65.google.com with SMTP id d1so13168166edd.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 11:46:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GfVcR13mJK7zwN78Jy9BFC0lKDvruft3aplDSgedns0=;
        b=qHmMVyGj1vYuLjBVjb2Z7+M/1EMT3jMLbpJ9Cw9sh3P7F95N9FbnLON1U4pBrDR8hF
         OQeUt5CfztMPJCNWhmF68Y857NngFj6nL2rzURswvlZKR4+oAQvPzArVh8EdMMX0uf01
         Y0Myy4/X6RDs0Vk1gbL9nf5ZY9js0VTbZ6UKX8SYHLHQWyzYTBo2hNpzifjAEalCkmaH
         8v8n5VRn7ncWO4Ykk1WAfCrMB2kpsfMJWKXzMXk1dCzmqfJ9ZpWjYSVS2kwtD2yE98ww
         QxPJamrgzW99115a+fYumfcHDr0kwEcz/ywEb34F/su0IVzEIC1yZDhEF4Bts2ZmLvgy
         kbtg==
X-Gm-Message-State: APjAAAVALt0lX1/heEzEr0xWCSVxjE23u4hAluajolPWYq4xkDOU7xOD
        HtteH7Cu3m9JGjxbAZ1qUoUM414eAIoHCZ8RnyXX2A==
X-Google-Smtp-Source: APXvYqyMcJVzfTgiDH3FfFxp8+jK9+9Gfx5s4mLlinbfbakJSxLfGkpTUkSSKo22ZaH6Uu7hmJa3OhRgvA+5PXT3lV4=
X-Received: by 2002:a50:86bd:: with SMTP id r58mr43481422eda.155.1556649995403;
 Tue, 30 Apr 2019 11:46:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190226062012.23746-1-lenb@kernel.org> <20190226190512.GR2861@worktop.programming.kicks-ass.net>
 <CAJvTdK=SGZy+vbTcCKAmBeQSkeuAW0UxEpKXY2YNvmUofFXNUQ@mail.gmail.com> <20190430093338.GA3518@zn.tnic>
In-Reply-To: <20190430093338.GA3518@zn.tnic>
From:   Len Brown <lenb@kernel.org>
Date:   Tue, 30 Apr 2019 14:46:23 -0400
Message-ID: <CAJvTdKkCc0AOiFV5fJ2pwbpQ5iYzjGVotPExJHVOs5CsK8GOsg@mail.gmail.com>
Subject: Re: [PATCH 0/14] v2 multi-die/package topology support
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 5:33 AM Borislav Petkov <bp@alien8.de> wrote:

> So that die thing has only small relevance to some software, as you say:
>
> "These topology changes primarily impact parts of the kernel and some
> applciations that care about package MSR scope."
>
> So if there's no real need to add it there, then it probably shouldn't
> be added. The topology is already too complex - so much so, that tools
> are even generating PDFs from it :)

Agreed.
Let's keep /proc/cpuinfo simple.
If a case emerges where it makes sense to add more detail there, it is
trivial do add later.

thanks,
Len Brown, Intel Open Source Technology Center
