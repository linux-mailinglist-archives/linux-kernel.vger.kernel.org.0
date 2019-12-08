Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3D7116346
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2019 19:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfLHSFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Dec 2019 13:05:12 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36719 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfLHSFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 13:05:11 -0500
Received: by mail-lf1-f66.google.com with SMTP id n12so8936674lfe.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 10:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ABGlqVpN991a0nTMf6FEfD82UigkTYB16rwzNeGUA1o=;
        b=fNvOByc3NZ0GAbRWTSkpquabTeoYcVtplUCgZggq3Aepi3EzJPLXx3abo3pWsDs5qf
         sKNddR4IqoNSKmAJDSPx/RmG6lgfadYTYSOho6JTjI6xasLvp6XbhfV12IZg7Fxv9hB/
         sv5caupH6WixLG01Msc9x2ZAIOHmQ87OQdy5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ABGlqVpN991a0nTMf6FEfD82UigkTYB16rwzNeGUA1o=;
        b=s/hU5Pga91Ki1IWa2qDZjBxV2nn4cDcEGYqrNRz2nouswr8RmBRXxvq52k7DVXvBmC
         6TxQmm2hM3+c6QN0b31RQqmbT4FY0UItiiEC6LD5GwPsakrHrNa2gnZQ+bR2bbPkwMlw
         1y3vk0m9VN0oBSAHotZsEJHPmGhidHS2OVodQLfVkOs/wgdUtFhaK6lzzQDAeuCNSU/S
         5kBlKDPz1anQlXqQ+wKS8Zx8FQT/7uJRMpmzFH3XehDT4dkkp2AZ9xlej3gYNZqARRzR
         Th07A507vBwRaIKITYjiLhQX1Lp9noRqe9oaunjP2/UAo4O5fHUTpuBL9itYtHAjn07s
         CFMg==
X-Gm-Message-State: APjAAAUmN0JDZiqUVyuUTJl/IHsMFjtj8HTVkHdIyczDoZC/EhPZEJpP
        5ZcfkPgkgYbdis35co8LsqB1vaG74pA=
X-Google-Smtp-Source: APXvYqx+fM1KtF14GamFD1u5wHme+fUnT5MVClWlXsGipD7Wn8Sy9XITlzljTFywDADyMbnvcxEpbg==
X-Received: by 2002:a19:7d04:: with SMTP id y4mr8830478lfc.111.1575828309322;
        Sun, 08 Dec 2019 10:05:09 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id j10sm1451667ljc.76.2019.12.08.10.05.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Dec 2019 10:05:08 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id h23so13017770ljc.8
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 10:05:08 -0800 (PST)
X-Received: by 2002:a05:651c:239:: with SMTP id z25mr12153795ljn.48.1575828307903;
 Sun, 08 Dec 2019 10:05:07 -0800 (PST)
MIME-Version: 1.0
References: <157558502272.10278.8718685637610645781.stgit@warthog.procyon.org.uk>
 <20191206135604.GB2734@twin.jikos.cz> <CAHk-=wj42ROD+dj1Nix=X7Raa9YjLfXykFczy0BkMqAXsFeLVA@mail.gmail.com>
 <CAHk-=wga+oXMeMjftCKGT=BA=B2Ucfwx18C5eV-DcPwOAJ18Fg@mail.gmail.com>
 <CAHk-=wj9pprDUeoJd5EeN-2x7+GXdSsm44mSv1y9f5e7MrTZ2A@mail.gmail.com>
 <qsh5n2$3pu9$1@blaine.gmane.org> <CABA31DrsaqT-TsOVx=kbRBnuM5He53+=NLgwm94swY-x1UPjuA@mail.gmail.com>
In-Reply-To: <CABA31DrsaqT-TsOVx=kbRBnuM5He53+=NLgwm94swY-x1UPjuA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 8 Dec 2019 10:04:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgteio3DVccVPZrD-dd9BNDM5128EQqCFxaEOb4Eu9H=w@mail.gmail.com>
Message-ID: <CAHk-=wgteio3DVccVPZrD-dd9BNDM5128EQqCFxaEOb4Eu9H=w@mail.gmail.com>
Subject: Re: [PATCH 0/2] pipe: Fixes [ver #2]
To:     Akemi Yagi <toracat@elrepo.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 8, 2019 at 8:46 AM Akemi Yagi <toracat@elrepo.org> wrote:
>
> I forgot to mention that the aforementioned bug in make was originally
> reported for Fedora. They now have a patched version of make
> (make-4.2.1-15.fc32) in Rawhide.

Yes, as mentioned I do expect it's some jobserver interaction - I've
seen bad jobserver behavior before. But my 'make' hasn't been upgraded
since May, as far as I can tell from my logs, so the huge performance
regression was new.

So the huge slowdown is real, and was triggered by the kernel changes.
But yes, it's entirely possible - even likely - that it's due to a
jobserver bug that ends up being sensitive to scheduling.

We do treat even "user space is buggy and shouldn't have done that" as
a regression.

It's annoying. Timing-related issues are some of the worst to debug.
Particularly when (at least I) primarily debug by looking at the code
and trying to see what's wrong that way.

                Linus
