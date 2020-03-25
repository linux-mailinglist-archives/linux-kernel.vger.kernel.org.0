Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2889191E9D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 02:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbgCYBhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 21:37:40 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35977 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbgCYBhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 21:37:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id 31so1014151wrs.3;
        Tue, 24 Mar 2020 18:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a9qWI6hMo401elWvdD41jj0JPGvsjes6z66C6PUVL+0=;
        b=HV7Lug93LSMJB9brLeuKVPDy7YfrjtxPnsPyDJbJU+0MF9Zv/YanIDRGEJMNNsff6i
         DuXp6sQlwrzakVY/2AGqO/fVO60ugEJK//y70qtVMnCVKodERWr+Pv2v1NuyRWHZty0l
         6hfUyKqhmLZ5apBpMaxnHJigh7HWkKiYnIzplOxhC2WkkH+fXhz5U05r6sDqUdft2ZSb
         jbaV1oOugFseJyil674hvq8h32+pXGRswqiAxul2umNKeTm0j6J8ICUP/A91XTO40Vz7
         XJ1Dscn3pTkid0yat4aj3irgL2bgB/aAl8qoN0UR8eSwQOPSoCujvv74+KBB4tweLtVT
         kjlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a9qWI6hMo401elWvdD41jj0JPGvsjes6z66C6PUVL+0=;
        b=Fa2CSWRNEwbrOF9RC6OifMGg/17aV0KZB6H8JDreSqAHzcu5tpXE+whvW5BnRbr1Sc
         LOkAYK9U5itLf8l9HQmpLWiZCmzci2kow/SeKtk2/ZFbDduEasA7YI4SjdQr+eCYXpZQ
         gFXokfvexM3G4F2g1gYmmQDJ/VQbz4IVi+S27ixhpEzjgOSNzAMuWar6MhDlA0JFNYDu
         93mPyjwHa1a+EONUvkE49ylpJgun5PkQSGyCmecI/W266cRuGujDheS7VRICmCHzsVRd
         I55xNcb5vuktLLyjbjMz+OIrAngq7hsbFYJQRtOBUVbSUhfkXzGitPB9w8uMAZVMv0N0
         N0jA==
X-Gm-Message-State: ANhLgQ2aRrMs8u32Tyqoz7ClpoEASMTBjZsuFIDx3FVd+rvuoI8+/0Da
        aYSyK3XIbHgbkrZcBViReMmP3j2tTSQurpv/tTw=
X-Google-Smtp-Source: ADFU+vsYEZcEDp8W81eFeo4cINGnisZQvoBT4h0/Ri9E1wbFb8bEQO8TQTtPBXc7r9nrxTimWU1T/sudDfU1VjyLzag=
X-Received: by 2002:adf:efc2:: with SMTP id i2mr576666wrp.420.1585100256835;
 Tue, 24 Mar 2020 18:37:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200324064949.23697-1-zhang.lyra@gmail.com> <20200324112115.GA10018@lakrids.cambridge.arm.com>
In-Reply-To: <20200324112115.GA10018@lakrids.cambridge.arm.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Wed, 25 Mar 2020 09:37:00 +0800
Message-ID: <CAAfSe-u7SjWr7VK37OFrFDfm1o-6VwEoUMLctP61us+iQ1emTw@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: make SERIAL_SPRD depends on ARM or ARM64
To:     Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark, Greg,

Pleas see my answer below.

On Tue, 24 Mar 2020 at 19:21, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Tue, Mar 24, 2020 at 02:49:49PM +0800, Chunyan Zhang wrote:
> > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> >
> > kbuild-test reported an error:
> >
> >   config: mips-randconfig-a001-20200321 ...
> >   >> drivers/tty/serial/sprd_serial.c:1175: undefined reference
> >   to `clk_set_parent'
> >
> > Because some mips Kconfig-s select CONFIG_HAVE_CLK but not CONFIG_COMMON_CLK,
> > so it's probably that clk_set_parent is missed for those configs.
> >
> > To fix this error, this patch adds dependence on ARM || ARM64
> > for SERIAL_SPRD.
>
> From the above, isn't the real dependency COMMON_CLOCK?

Some arch can implement its own clock APIs, for example AR7 [1].

The sprd serial driver is used on ARM and ARM64 platforms only for
now, which uses clock functions provided by COMMON_CLK, but it has the
possibility of being used on other architecture platforms, that was my
thought.

I should revise this commit message to:
"
Because some mips Kconfig-s select CONFIG_HAVE_CLK but not define
clk_set_parent which is used by the sprd serial driver.
...
"

Does it make sense?

Thanks,
Chunyan

[1] https://elixir.bootlin.com/linux/v5.5.11/source/arch/mips/ar7/clock.c#L475

>
> Mark.
>
> >
> > Fixes: 7ba87cfec71a ("tty: serial: make SERIAL_SPRD not depend on ARCH_SPRD")
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > ---
> >  drivers/tty/serial/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> > index b43dce785a58..417f7e45a3f8 100644
> > --- a/drivers/tty/serial/Kconfig
> > +++ b/drivers/tty/serial/Kconfig
> > @@ -1444,6 +1444,7 @@ config SERIAL_MEN_Z135
> >  config SERIAL_SPRD
> >       tristate "Support for Spreadtrum serial"
> >       select SERIAL_CORE
> > +     depends on ARM || ARM64 || COMPILE_TEST
> >       help
> >         This enables the driver for the Spreadtrum's serial.
> >
> > --
> > 2.20.1
> >
