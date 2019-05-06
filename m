Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9B81553A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2019 23:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfEFVEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 17:04:42 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35659 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbfEFVEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 17:04:42 -0400
Received: by mail-pg1-f196.google.com with SMTP id h1so7080390pgs.2;
        Mon, 06 May 2019 14:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4dZVddJX6dMijqEXGKkV471ROICyanljBDry/3kQwHE=;
        b=rEWglwM7FrXe29arU/lKim1znCqIQIKo71qAmJUZ8tQeLam9LNqYnznBKa6vHh2M9q
         fLYfBl2XMLeI7z3xwKHdzK6+DF65yuTxE02rgAa4lZsFxhD7EAygFJzfvDnGJdgACgUs
         kierdsh75TiIZG80k+qjjHj9YCajOyTuWiooia+ThQMdYlKhcooIygGEoMGDuc/bJqNb
         r5wu1nGOZWGUGD2g/fzHJleSRmFPYDUjuJ6kvEGdH6nrB5Krv3qyUmKeyvstyz/SvnBP
         ItfexgvmNFlmdPZEaVOmE/TOJUOHybrbKsImBxQsX5vyiF0KwR/EP52NfPY2/l8FyxRh
         POPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4dZVddJX6dMijqEXGKkV471ROICyanljBDry/3kQwHE=;
        b=ZVcqDa8H6TNWLeuSfemyDCNrnu8HLBrxtPdNcHQisubVSbdcnOAvB3OhfiARSr8WOt
         Kz1p8ADM1e86Ticvpwk9yUXQnFFu5+oHIh8shyUqUmXOip7+qMsJbL+OWfrq4UuwMsaD
         3I8FfBr2Slh0c2U//gW8wVLp+9Pefroh1Xajikcr8qh7En1WQUDw96SzCcAlpHnZW0XA
         gXyT4lCE6DbC/Ce3QTg1dG34ka7eTDm+kH3Sc2sVv0X2B35sNdsNF874BpArMVV4Bm7d
         zWtgwIUU5onNfpGNIJA9WHjb9/582+/V92/8FLdZ9XPT7R01ij1ef2Any2cqQOX1mJXR
         T48Q==
X-Gm-Message-State: APjAAAXAlrSgZBMSavtl5nIwvLkAYWzVieWqkzFkEKWaH/fI0FdLxyI6
        W8HAklkqQB1qPI4JK9f9yQ39AR0l72vHujElgq4=
X-Google-Smtp-Source: APXvYqwkYd9R+WPJnLY9uPOahv8nf186eg24IAcFCrV7u8vAy0nUe9XlS1pkRvKRo3qfnyWJe01ZrID2vLEl3PI653Q=
X-Received: by 2002:a63:dd58:: with SMTP id g24mr34753988pgj.161.1557176681420;
 Mon, 06 May 2019 14:04:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190430140416.4707-1-esben@geanix.com> <20190430153736.GL9224@smile.fi.intel.com>
 <874l6efxta.fsf@haabendal.dk> <20190502104556.GS9224@smile.fi.intel.com>
 <87pnp11112.fsf@haabendal.dk> <20190502153124.GA9224@smile.fi.intel.com>
 <87ef5boaa7.fsf@haabendal.dk> <20190506164426.GO9224@smile.fi.intel.com> <87o94f32iw.fsf@haabendal.dk>
In-Reply-To: <87o94f32iw.fsf@haabendal.dk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 7 May 2019 00:04:30 +0300
Message-ID: <CAHp75VevGGYiWPLE_T5cXFKSNHDh=ORUNC2xW_CwTAtYsS8S1A@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250: Add support for using platform_device resources
To:     Esben Haabendal <esben@haabendal.dk>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Enrico Weigelt <lkml@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        He Zhe <zhe.he@windriver.com>, Marek Vasut <marex@denx.de>,
        Douglas Anderson <dianders@chromium.org>,
        Paul Burton <paul.burton@mips.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's start from simple things:
- I really failed to find where resources are requested in
mfd_add_device():
https://elixir.bootlin.com/linux/latest/ident/mfd_add_device
- as for 8250_dw.c (as MFD child of intel-lpss-pci.c) see below...

1. 8250_dw.c remaps resources, but doesn't request them.
2. It calls
 -> serial8250_register_8250_port(), which sets UPF_BOOT_AUTOCONF
unconditionally, as you noticed
  -> uart_add_one_port()
   -> uart_configure_port()
    -> port->ops->config_port(), if UPF_BOOT_AUTOCONF is set, see above
3. And ->config_port() is defined to serial8250_config_port() in
https://elixir.bootlin.com/linux/latest/source/drivers/tty/serial/8250/8250_port.c#L3147

So, it *does* request resources implicitly via 8250 core.

I maybe miss something obvious, though.

-- 
With Best Regards,
Andy Shevchenko
