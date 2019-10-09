Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2B5CD0D41
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 12:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730991AbfJIKzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 06:55:51 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36375 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbfJIKzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 06:55:50 -0400
Received: by mail-ot1-f67.google.com with SMTP id 67so1325901oto.3;
        Wed, 09 Oct 2019 03:55:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x3unWFkcJpXKNb8dXSk7twjyfVkZd7Gwb6TQxf0CzFw=;
        b=lAmUTsQY/CZlaq/zouJspiWWkWjppJp7Bz40rl8QTVpeci1l9iUh513qoiNsMcTl5O
         zkOubDZRouSluts+9nyFP19B14ky/wnw8CwyC+KidIood94Zmw1TSeZUghnbjfeLJ2tx
         GiYQFLGGXnz6X0l6fB3I8sX9vSmSMHj+UaYI2y/rkhEqOsfDrKY7eR+kRGthVwLbrcKP
         AKlw3LBXhjHk7Xdm4sfBWKOskixf9Q6zw/EBvRo7tmLrKlrVtt/tOoEP7HRd46gjjs8Z
         m0ES2RYkxcwW2jLtqolMu36gPd6RxRJhE6eM1FAVp+gEz8yisG/pFYWWnoLti1OwxTyK
         hP3w==
X-Gm-Message-State: APjAAAU0ymdXheYJJlU3ePFOKE4EgWvZZPUhkbU7PhNLEc/a11LBi0Jx
        VMBE3f7nTsiC9Ocg2KT1IHcN0BB1jbSm1UIz+bU=
X-Google-Smtp-Source: APXvYqw5IAzTjVBhlc8iRLqf+cdJpgzj6zNsVffXtkNnQdcMdYKmNwxtMA0YZ+q29ei9YF0gwMf5pwNvdwDZQVDcfXk=
X-Received: by 2002:a9d:70d0:: with SMTP id w16mr2140239otj.107.1570618548788;
 Wed, 09 Oct 2019 03:55:48 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.9999.1910081606370.11044@viisi.sifive.com>
 <CAMuHMdVdPFSU_3VEtO=P73kqLezV5Dmki=N3nxsKibzy-U5pBg@mail.gmail.com> <mvmv9syz10h.fsf@suse.de>
In-Reply-To: <mvmv9syz10h.fsf@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 9 Oct 2019 12:55:37 +0200
Message-ID: <CAMuHMdVh=CUXKwnXee067cRccVBDVuwWpo1wP7crAaCFA=y2Tw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: admin-guide: add earlycon documentation
 for the sifive serial driver
To:     Andreas Schwab <schwab@suse.de>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On Wed, Oct 9, 2019 at 12:06 PM Andreas Schwab <schwab@suse.de> wrote:
> On Okt 09 2019, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > I believe risc-v is DT-only, so if chosen/stdout-path is set up
>
> If.  Currently, it isn't.

IC. So isn't it better to fix that, instead of pointing people to more obscure
legacy solutions?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
