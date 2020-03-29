Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47C71196EAA
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Mar 2020 19:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbgC2Re1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Mar 2020 13:34:27 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46298 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727933AbgC2Re0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 13:34:26 -0400
Received: by mail-lj1-f196.google.com with SMTP id r7so7817502ljg.13
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 10:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uF9ju1VXjYMdKAq7SYnU4SKEXhGZYS4gUazfdnb0Iv8=;
        b=X0ytTSPzpoiXAuUiU+FOLPgIBg2tMnUBEy6YmzKbNk3TPoZ8rR4vp8K3MKE3TLGyfB
         tZ5sgEHNwUJHmB6iqy/G36WYjTSaSFkZXEt7VVe0f9rHHZ+HVVmhx7c7smnFsdelQsZx
         ATJMbSrFSl2IFNWyfIHWPnZMQWjUneHs7abQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uF9ju1VXjYMdKAq7SYnU4SKEXhGZYS4gUazfdnb0Iv8=;
        b=poyPIQaR7S9CC/WxM4OkdhZF/eRi3bGNkynGDGzN7z+xQv76oy+A+ELOMgyM82gZSn
         wyVh2ZBfpBq6R8sL2PkEiflxzIVZcqoKoIhjx/JgnzPXKK90lCOY5/pk1p22gksvcJ/l
         k1JaVXPd3S7XtrngiOnTCqq5ybNOlSLSSq0qpkj0yTZczc08kIkcP05uy4oWM8OaLVp6
         nzjjp4atGD3KkezVVwXq2+SBG9V6fG/I04y+0mRL4jqzTYYV3ZIpq0maWFTR6eS8tsRc
         gHo12G9X1Q3q9tHhz8+XV6PovWo1wZr3ehL6raIOfBi4eiNEf9NM0Ex7N/9t8aCiIHTP
         hfLg==
X-Gm-Message-State: AGi0Pub6yXRYvPfyiIPhxa/WlXR71FrPf3tN0WeGz04npQskBCe9eN0V
        pP3FWiieLCTYi8nzIXlsGlsGy1Ul1HQ=
X-Google-Smtp-Source: APiQypJmVuOCcCRIg2uTvTdTBT7uws+WjGEFUQhIWWhgN+Y912dqye2w0Pgncd/MOtqE5ko8PhJgTw==
X-Received: by 2002:a2e:b521:: with SMTP id z1mr5264770ljm.19.1585503263728;
        Sun, 29 Mar 2020 10:34:23 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id j14sm6525142lfc.32.2020.03.29.10.34.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2020 10:34:22 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id r7so7817423ljg.13
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 10:34:22 -0700 (PDT)
X-Received: by 2002:a2e:9b8e:: with SMTP id z14mr5057608lji.150.1585503262229;
 Sun, 29 Mar 2020 10:34:22 -0700 (PDT)
MIME-Version: 1.0
References: <158549780513.2870.9873806112977909523.tglx@nanos.tec.linutronix.de>
 <158549780514.2870.1236107824707197925.tglx@nanos.tec.linutronix.de>
In-Reply-To: <158549780514.2870.1236107824707197925.tglx@nanos.tec.linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 29 Mar 2020 10:34:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=whTDGWiaBcUfx2UhffL8FAPZ2Qy4dzmAcVoB+_=0vvx3w@mail.gmail.com>
Message-ID: <CAHk-=whTDGWiaBcUfx2UhffL8FAPZ2Qy4dzmAcVoB+_=0vvx3w@mail.gmail.com>
Subject: Re: [GIT pull] x86/urgent for v5.6
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 29, 2020 at 9:03 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> please pull the latest x86/urgent branch from:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-03-29

Heh. I already got this from Ingo, where it was "x86-urgent-for-linus"
and merged on Tuesday: commit 3f3ee43a4623 ("Merge branch
'x86-urgent-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")

              Linus
