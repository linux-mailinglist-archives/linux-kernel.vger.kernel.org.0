Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03AA811FCE6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 03:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfLPCbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Dec 2019 21:31:23 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36772 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfLPCbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 21:31:23 -0500
Received: by mail-wr1-f68.google.com with SMTP id z3so5400479wru.3;
        Sun, 15 Dec 2019 18:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UpvyF0EdWS+Om5YRvxySlIG/mvo3QAlXjzlkgGDs+DU=;
        b=qyYKRuHITiwOw8aoERmomP1QcHaO+ooqgl8sHMof/j+kkt5elHSOIoZoc3sZU51TTI
         9+b/HmOBTAYfvCnIBmhDNIwQnr6rHfZp6O6CdXCSqCjqmXxS6+QyyJTmiL038YJ0Olr3
         boxuoqeIoYyTIKv149gGeIQAmJzc1J3jHXMrGeXqfzEJCdxiGNkduZTa9PRlkKvIXBES
         lpgoKthKfyyqdy7bsZ+Uj+LA0PgGOzsXJKQFzkBRUesKUV/wgMkC0eeudFnDFdXH/swQ
         cOtCRrOOkQcDL9J1/RjCSvKZcvOXfgL0EpZo530ASU1N0/BUn0ev8uNJaVQdi2SM5wu7
         WivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UpvyF0EdWS+Om5YRvxySlIG/mvo3QAlXjzlkgGDs+DU=;
        b=QWwVdq7a1IStvhbLtzuBf5IdiAwG7qoibB1cxz63XktlyPHMnS5u8Lz5EUMGMC8miF
         Cdq7YNKqzU2HuROG9PyE10FHE85L6I8Ckkhqly7su6rYs9BbMTU/oHJrguSn17xs044c
         +0ZofNxU8us5+ysmDf6OoV7oaY8KplzbnmIO9fkA+DKx1v2urWK4RSGcoIKCvtlxtFfD
         +C/unwze/Npl9g4duC4rJpoaZg/QFDF/8m+/y1G0adGCAGdLwfZZj71PdPINodFdb4M5
         kX0ldyiqnuPfrfYY18+smxZcQa4fLP9em/AqBMDpdk962NGhwbHLac4fjGkowUGyRoIv
         CrJw==
X-Gm-Message-State: APjAAAX2YDwE1u42GsDWqtv1l0RCociOs/P6TUoe66QPMjRP6nmpHmBV
        ySY85BE3Gjy5k2CzMHzET6unQVyf8O9xvaguR5U=
X-Google-Smtp-Source: APXvYqzanKQKeZzVCBDeRO025pcfvhaYt/GmOW9Lg/MsvSWs3HFfoyA0PsRJFAPGYRjReAgZnyTlDiteWR5qO68vSZM=
X-Received: by 2002:adf:f847:: with SMTP id d7mr28220980wrq.35.1576463481435;
 Sun, 15 Dec 2019 18:31:21 -0800 (PST)
MIME-Version: 1.0
References: <20191213000657.931618-1-dima@arista.com> <20191213000657.931618-43-dima@arista.com>
In-Reply-To: <20191213000657.931618-43-dima@arista.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Mon, 16 Dec 2019 10:30:45 +0800
Message-ID: <CAAfSe-vSZZcNSgcCj_OPmgVxMNKgV8f4Os6vJCHcL-SU+EVjeg@mail.gmail.com>
Subject: Re: [PATCH 42/58] tty/serial: Migrate sprd_serial to use has_sysrq
To:     Dmitry Safonov <dima@arista.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org, Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Dec 2019 at 08:09, Dmitry Safonov <dima@arista.com> wrote:
>
> The SUPPORT_SYSRQ ifdeffery is not nice as:
> - May create misunderstanding about sizeof(struct uart_port) between
>   different objects
> - Prevents moving functions from serial_core.h
> - Reduces readability (well, it's ifdeffery - it's hard to follow)
>
> In order to remove SUPPORT_SYSRQ, has_sysrq variable has been added.
> Initialise it in driver's probe and remove ifdeffery.
>
> Cc: Baolin Wang <baolin.wang7@gmail.com>
> Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> Cc: Orson Zhai <orsonzhai@gmail.com>
> Signed-off-by: Dmitry Safonov <dima@arista.com>

Acked-by: Chunyan Zhang <zhang.lyra@gmail.com>

> ---
>  drivers/tty/serial/sprd_serial.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
> index 31df23502562..0c3b7420b01e 100644
> --- a/drivers/tty/serial/sprd_serial.c
> +++ b/drivers/tty/serial/sprd_serial.c
> @@ -3,10 +3,6 @@
>   * Copyright (C) 2012-2015 Spreadtrum Communications Inc.
>   */
>
> -#if defined(CONFIG_SERIAL_SPRD_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
> -#define SUPPORT_SYSRQ
> -#endif
> -
>  #include <linux/clk.h>
>  #include <linux/console.h>
>  #include <linux/delay.h>
> @@ -1227,6 +1223,7 @@ static int sprd_probe(struct platform_device *pdev)
>         up->fifosize = SPRD_FIFO_SIZE;
>         up->ops = &serial_sprd_ops;
>         up->flags = UPF_BOOT_AUTOCONF;
> +       up->has_sysrq = IS_ENABLED(CONFIG_SERIAL_SPRD_CONSOLE);
>
>         ret = sprd_clk_init(up);
>         if (ret)
> --
> 2.24.0
>
