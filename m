Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 661C748D08
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 20:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbfFQSyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 14:54:11 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:41723 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbfFQSyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 14:54:10 -0400
Received: by mail-lj1-f173.google.com with SMTP id s21so10371799lji.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 11:54:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=66m4iUUvYIXxs91ImWOwQpe/gowMn0dh9jwp7NXwltk=;
        b=kkgx5GryyrSEQE7/3soXS1on3Hyi36tM18M2SFySXIzj7JscZrIvTXutx0L2GU7lOM
         xecqhsl9xMmWji8seDlON3jj1hool9nwt1zP3zIqeM8MWaBHm4VP2P1vtwVcfQ6yfoO+
         O8GTiUv6SpispaFb+hTt/gmpKLOuRrCZPVQmGSTQbPHoN4mQXI/ybCZWx9dsftHN1I9g
         nlUP/fpJPxWQhTwh9+KFvjTGf46Dwgy3a8qXd036fQru7HiKHuZpYtAGI1j+qI7ewFFK
         1uaTqv0P/igkGGtXZ41dMGxAkvEHmBWTJoanvmUPFxk157w6LQMOukEWdDexSerAaVAs
         /mZw==
X-Gm-Message-State: APjAAAVyXFVxnd0hTDH1CwBNJdvobvFqjTIoo0yFdw8T0G6uKMW+qj/4
        Yw0VMSENthlLXcKWdsAkHS8z4UZpJRpHmICEq5I=
X-Google-Smtp-Source: APXvYqxmc0OIHh1u8In/WbFdOyPZmFDCbAj41wxY9ICm/ETICkV5L88DRwCmmCfwk1E5mh9JaqqSXC67mdkWs9VyE/g=
X-Received: by 2002:a2e:b0f0:: with SMTP id h16mr36540791ljl.21.1560797648597;
 Mon, 17 Jun 2019 11:54:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190614102126.8402-1-hch@lst.de>
In-Reply-To: <20190614102126.8402-1-hch@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 17 Jun 2019 20:53:55 +0200
Message-ID: <CAMuHMdVPU5RQyX4FnHFEhxXZeG3v0uh_-t2FB=vAzQ8_3u-gSw@mail.gmail.com>
Subject: Re: [RFC] switch m68k to use the generic remapping DMA allocator
To:     Christoph Hellwig <hch@lst.de>
Cc:     Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Fri, Jun 14, 2019 at 12:21 PM Christoph Hellwig <hch@lst.de> wrote:
> can you take a look at the (untested) patches below?  They convert m68k
> to use the generic remapping DMA allocator, which is also used by
> arm64 and csky.

Thanks. But what does this buy us?

bloat-o-meter says:

add/remove: 75/0 grow/shrink: 11/6 up/down: 4122/-82 (4040)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
