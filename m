Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0093A1BB5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 15:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfH2Nnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 09:43:37 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39782 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfH2Nng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 09:43:36 -0400
Received: by mail-pf1-f194.google.com with SMTP id y200so2080821pfb.6;
        Thu, 29 Aug 2019 06:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8zPNbZDUiMhdq/ieedCuYewAeGQ+edqxjj6irK3rFuk=;
        b=ny1BJU7zHymSjrJnVno3H/+nPslnl3iVcEUY5179US9gDUYOyLuRNAjYuQGBGrRbdz
         l6GaK7U8gzf/eNTky7FvG4KCJeuTL2DuAFVVXeSCC6YCrX2v74Sg+oegZLOPn3OzZlZ2
         D5NyAOxMPjx/prwMNsL6bH1+O4sDRi/P3/K9jCwezfp14ZnPDl6sHvA5RYGYLdeaMvqT
         BUvDIh3lvVkC/yR3hCUhGHj+HQC8QzqX0kEwWpd6BRYnEuxdjBCj+lZfggxx7WT8O6DV
         oXC1MUGfOsEHujAL+drJYZqE+JiGuSPIri1oB2E6fXwWFpnxm0p7end0wbsy89dD4qda
         VLhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8zPNbZDUiMhdq/ieedCuYewAeGQ+edqxjj6irK3rFuk=;
        b=iAYkpAkDfZ1F1uZg98x9qamljIufpsY0mfDO43Qxawp1QWxMOuc+QCXpVtsdlVpUGw
         Bi/0+SLwsQIU+7g2a6t4P45qUbt/jtQy5HdUbPOAHZYwsaciessLGQvdodR8GmcvXiPY
         f3CXeGvhiSyzOgox9pKrJc0XoE/0o4lnKdTHuC0QbjybWiOrjhqxxYdfqS6+TM+l4i/l
         J4/AYp/VBfV6yaoA9a2d4P1VqFy+fdETzCj6I7M6LCZlSvgbGlVB6BXv/6ssnDuLbXkX
         shRBs/MG1cXnh5ULcAwW///J8KGsOUVR0lSujpfIPohIlc3IkdOst4G7YJevq4jABqnh
         DJwQ==
X-Gm-Message-State: APjAAAXztKgPnwJrezifbakybt9I6QLpj4dxtz88YpAaLGtveigllWGF
        o11PbPUXg9H1dmxhpDA1E+3xGH73X4fkPMsxlQY=
X-Google-Smtp-Source: APXvYqxBEzf1LYRCXKjSqfC3G4XRdlGyv3ix/Ro7ebl58PTSdhxOhn+Rmk9ARuIu9ZzwXYUK2aPiBTZDBQEnefAnMoU=
X-Received: by 2002:a63:1020:: with SMTP id f32mr8694066pgl.203.1567086215455;
 Thu, 29 Aug 2019 06:43:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190829043716.5223-1-uwe@kleine-koenig.org>
In-Reply-To: <20190829043716.5223-1-uwe@kleine-koenig.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 29 Aug 2019 16:43:24 +0300
Message-ID: <CAHp75VeV8jDP1uP3HtkJ+j7+SbkB50cs4V9tJ+j9tS6icO95FQ@mail.gmail.com>
Subject: Re: [PATCH] [RFC] tty/serial: imx: make use of format specifier %dE
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Enrico Weigelt <lkml@metux.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 7:40 AM Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.or=
g> wrote:
>
> I created a patch that teaches printk et al to emit a symbolic error
> name for an error valued integer[1]. With that applied
>
>         dev_err(&pdev->dev, "failed to get ipg clk: %dE\n", ret);
>
> emits
>
>         ... failed to get ipg clk: EPROBE_DEFER
>
> if ret is -EPROBE_DEFER. Petr Mladek (i.e. one of the printk
> maintainers) had concerns if this would be well received and worth the
> effort. He asked to present it to a few subsystems. So for now, this
> patch converting the imx UART driver shouldn't be applied yet but it
> would be great to get some feedback about if you think that being able
> to easily printk (for example) "EIO" instead of "-5" is a good idea.

> Would it help you? Do you think it helps your users?

No, it makes sense only for debug where the user is supposed to be
developer and thus needs anyway to know code base better than average.


--=20
With Best Regards,
Andy Shevchenko
