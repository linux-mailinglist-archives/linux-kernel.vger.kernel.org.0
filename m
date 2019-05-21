Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA1D25652
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 19:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbfEURGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 13:06:51 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46712 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728271AbfEURGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 13:06:51 -0400
Received: by mail-oi1-f194.google.com with SMTP id 203so13341730oid.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 10:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DepsFwsb9lkjjmxtM22xms6DJ95kq6d7Pbuq4OqECAc=;
        b=TcSWYAwICafV+txluRy/7vKaRAad1DAY1lz4mpihseezFMb5NRnxsZD+8iDVu3FZB6
         pi5Hw9qEADP/3/GqCwLtF0grO5aJw9lps5WmJNEyCOqLMZ8B+j+9PO3XlO+FUXNRcrSD
         9hZ+Mk5f5Di1ZhVWW86yzuiGlVVa4qKbvBuLdIeAYI1CByBBJes3EdcNqQSevN+e0b5Y
         An+BrCC1DwZl8Uh2vLBt0XKtvl1b5B8gQQ8fhhRvTjtmDCf9+RiAYTjBJhWdRrhVusx9
         ZGWcMMc3Vuq44PfJXwPYNeNFmnk179KaDz6ysOPshDmfndG2FpPgcr8AyPvyoxPFCUv+
         XDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DepsFwsb9lkjjmxtM22xms6DJ95kq6d7Pbuq4OqECAc=;
        b=BFosk2ykGhyvxMH2hBKYiEZUszQGivvlMPNhb15K/y2UUqpW9cmHDt4EuzrCYo2zxl
         URqBvwTtMEvdRedq09NefAbNgRCSDo5MXnPfEKnhnR1hyReVk0Wq117n8pCaIEqYY0dY
         zW/ux4FD7/fq+SfGYLDXu3JtuazGfGIvCv1d7tvtEc1pQGu+61F/wjbS6O+AWApi7krX
         Gs7AsrPG9OpH9ek8bD0N4zv3m0RUxikYWQJa//0+JUtPlBLjFOHTtzBP9rHIr5vDTv/N
         RvcoXM2+3LKyC9EfOo7A00METXydhQAGnrEfJA1Zn5r0I4fjwG0WRNY26uNffu+quhDY
         oxHg==
X-Gm-Message-State: APjAAAWRwbyhq7txicVQAki7CliGGnlQmYoOAxvd0vO7jtf45AK81ofR
        sRwpr9bh08IeeguQ2gw59Hh7MJFAyNpN7ebwDtg=
X-Google-Smtp-Source: APXvYqyhQAU5DIWDIgucQiRsTp1XPcJJXtZurXWE5faQ1ZKAc6K7EtB1j84FC/R0B3u6rDgmNnou1SxGphHWrYAKouY=
X-Received: by 2002:aca:580b:: with SMTP id m11mr1637263oib.169.1558458410830;
 Tue, 21 May 2019 10:06:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190521145116.24378-1-TheSven73@gmail.com> <20190521151059.GM31203@kadam>
 <CAGngYiXLN-oT_b9d1kRyBrrFMALhKO-KnuwXB0MjVq0NFc01Xw@mail.gmail.com>
 <20190521154241.GB15818@kroah.com> <CAGngYiU_iK5=swD_DA5PcOeYFT0zTrdQ+30Db0YrahuEukEP_A@mail.gmail.com>
 <20190521162451.GA19139@kroah.com> <CAGngYiUSgtAXL+utPHz79OEbvrL6_TD9Wfkc6396E9vwQHCFKw@mail.gmail.com>
In-Reply-To: <CAGngYiUSgtAXL+utPHz79OEbvrL6_TD9Wfkc6396E9vwQHCFKw@mail.gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 21 May 2019 13:06:40 -0400
Message-ID: <CAGngYiVZguWhbU_zvczVK3Xgb96nCFsTD-Zkvg8-S1rUVjTypA@mail.gmail.com>
Subject: Re: [PATCH] staging: fieldbus: anybuss: force address space conversion
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 12:53 PM Sven Van Asbroeck <thesven73@gmail.com> wrote:
>
> On Tue, May 21, 2019 at 12:24 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > what is so odd about this code that makes you have to jump through
> > strange hoops that no other driver has to?
> >
>
> Basically because it creates a regmap which accesses __iomem memory,
> instead of i2c/spi.
>

Wait a second... doesn't devm_regmap_init_mmio() do exactly that ?!
How could I overlook this :( :(
