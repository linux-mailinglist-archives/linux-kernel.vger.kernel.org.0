Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25DCE636C5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 15:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfGINUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 09:20:20 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34154 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfGINUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 09:20:19 -0400
Received: by mail-lf1-f68.google.com with SMTP id b29so13444632lfq.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 06:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GKRMa+Kxr/0AVlCfTGD8ya+QzV6VZBsG8RNlbGuSaXU=;
        b=NlotDVqUGttPOKvpca7ffuSwOx3mdZOtNeefjZVANPbNjTeMqB11gYruAonGJzIBCM
         KrMoIrxmDSXxiWsQeMmMPeC7qDoIT51QuBBn8IXkxh5rNnLMDhcIPP4tqHMu8XkH+40+
         0ikv6AqK1ccSNRtpzQvMT/Kyz4Xa+NNKJw2Vd+k6px6HvtvizWFgfzfbjeBOxJEiBTNt
         GJvwN6JUNrsi480Qw3w6B4JePL/Y3h3Q5+gE+q0Lxktj1Mq7z9BVJNRW6Wd+YFz5qymK
         T1wLisEIRPDBJdYhN7PfgFpvFbF8tOF+eJJgq+4XeAKA7NsK/7xIZ8r/TKdhiOjKYCn6
         8yEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GKRMa+Kxr/0AVlCfTGD8ya+QzV6VZBsG8RNlbGuSaXU=;
        b=d2C/2F3uwdkrTZV+r8SqjjgwSFUavraDI+MvcMuCGo0HJPdEldD7/cKhxTA4UGtyw6
         hcbO2voELIrLfi/HAj+TCxNG08NKl3TJJl07XGPMoOZIR6QbHNJ5UYjTEiWSU8GtFbzf
         +Gja/xzHQpvxeWCZ6gYucF46HccrCIigftXiy7I4fLGNK7T0slSwYUf0fLQaeoxWJrhm
         82i/KC/x6zaElo0uaLWN7vFSdtMRCXuXTjBlti4ZZl/TyUnGKDvt+1FJwXOiiVkSB+Uo
         +K4i4LgQeTXtrLLQ/iEUjOaGQyOl/hnMRFmmWxJmFW44n8oZmZr4OBuCvWAczMQPCl9u
         O5CQ==
X-Gm-Message-State: APjAAAWswfhoU/W5YE+X0RrROPTIcojtQetH5eMynCBcs8nDYFDrmg2i
        gFTUQnUmadZBpJ0h+9SOU3OKH3aSIBBwEk7xVT/qP6+w
X-Google-Smtp-Source: APXvYqypndextSv7lD0G/DINvYDcmg4OLd7rXOvdO556BBK3HPFwOKmfetXYHPn7V8VLnu7Riy6N1iNhpUYiWdIHbqM=
X-Received: by 2002:a19:e006:: with SMTP id x6mr11338723lfg.165.1562678417264;
 Tue, 09 Jul 2019 06:20:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190628172807.4ae7edfc@canb.auug.org.au> <20190709101557.3e950748@canb.auug.org.au>
In-Reply-To: <20190709101557.3e950748@canb.auug.org.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 9 Jul 2019 15:20:05 +0200
Message-ID: <CACRpkdZHVGUamcVfVK_-0G4EJ6S0tJfZ1YULGMR_pg7WPfBM6w@mail.gmail.com>
Subject: Re: linux-next: manual merge of the gpio tree with the mfd tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen, Linus

On Tue, Jul 9, 2019 at 2:16 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> > Today's linux-next merge of the gpio tree got a conflict in:
> >
> >   drivers/gpio/Makefile
> >
> > between commit:
> >
> >   18bc64b3aebf ("gpio: Initial support for ROHM bd70528 GPIO block")
> >
> > from the mfd tree and commit:
> >
> >   db16bad6efd9 ("gpio: Sort GPIO drivers in Makefile")
> >
> > from the gpio tree.
(...)
> I am still getting this conflict (the commit ids may have changed).
> Just a reminder in case you think Linus may need to know.

Of course I forgot to mention that in my pull request to Torvalds.

Linus: there might be some trival merge conflict in the Makefile
because Geert made a patch restructuring the Makefile and a
new GPIO driver was merged orthogonally in the MFD tree.

The resolution should be trivial, and the end result that we see
less of this because now the files are in alphabetic order so
we (or so it is believed) get a rectangular distribution of
conflicts since all filenames are equally plausible (yeah right).
It's a best effort to keep some sane order at least.

Yours,
Linus Walleij
