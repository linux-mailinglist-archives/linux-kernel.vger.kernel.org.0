Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78DB711A674
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 10:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbfLKJIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 04:08:00 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33697 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbfLKJH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 04:07:59 -0500
Received: by mail-qk1-f196.google.com with SMTP id d71so11067601qkc.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 01:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+1+2OzonF8JaI5zb2TCQGTWjY1hWFqWalCfMdztL7bw=;
        b=S60wH1RHuXQ8mOnPL0RhPKzQIGXltV0Cv9h00AH+VYro56n5frUBSr4jG3994daVvT
         V+vThx0M+M5TKEPRP7rKgYkWR9SLOxLfctebgbS4/teJyPdNqlqYK9Sqae4OYe3pOZfj
         RbOKuXYBl+rwcuW9scJiI3DZUILjSRdRChb2cUjEMEG/J6gALdSSdCrSN73Zs+Oaq7Ld
         ncsVZLJRCCbXDi37Bkc0aQABg2eiqLVtoela5xrLAMI6eSLhlktSHK/xO5UF2xLQLYer
         yMxhiSsTvhVSoG04ZT4mwPZHx/2a+Y7mdi6v2EwwgKDOC/A2904us+0B2fJX/ZY9l4Bm
         hO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+1+2OzonF8JaI5zb2TCQGTWjY1hWFqWalCfMdztL7bw=;
        b=WbDUtU6ErNzjUKVaZIGCw0XoIXg3UmiMSGI5Hil9Qq6iWL4i4UNui/9Ch444mR0Tm7
         GAjIlEg4DUNjNhIrX5quX+3E2Ht3tmvZMFQHJJDx5ppd4ZzJurDDBQxTzhLvgOPlT1H8
         pKr3pxR302WRsc32o+fkN43HkqImpV6DQ6VmkyTZRChLCrICISj+E0zPFI3N8gG94fbN
         h6XYQWCSNwf/0VQsp2RnEF3YuKo8folBm5/CatlEMXV0LpFTx2pl2vDb5Ufog+r8Uhf2
         Z0KKqBOgtOpHM1OJnBmqJqQROuV+sr//QX0ruQeIYdb6ElxHRh7eJrCznFZed6ybnBqk
         N9MA==
X-Gm-Message-State: APjAAAV2TzF2PrL1kGDNV00712YkhKTA7ixUktqGSYl6H4e3bprdHgJv
        hLZAB3cV7t1jvRRcqIRPxz/RqMTexsykW5uA+QTAGQ==
X-Google-Smtp-Source: APXvYqxo51nvYaIkggIMq8ITtXp9gbKNulM8Wmtc5DRGjuFLLqvLJhg/1ssY8su+0/x7Vipo/ClbnBGeVsB5uoQ3mKs=
X-Received: by 2002:a37:6255:: with SMTP id w82mr1919216qkb.330.1576055278589;
 Wed, 11 Dec 2019 01:07:58 -0800 (PST)
MIME-Version: 1.0
References: <20191210202842.2546758-1-arnd@arndb.de> <f6a514d1-44cb-4577-af07-fd2f3fefc974@www.fastmail.com>
In-Reply-To: <f6a514d1-44cb-4577-af07-fd2f3fefc974@www.fastmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 11 Dec 2019 10:07:47 +0100
Message-ID: <CAMpxmJUD8A1qtmZmOxAq3XojFG5LHu_DS94LC7orinz_O9zY=A@mail.gmail.com>
Subject: Re: [PATCH] gpio: aspeed: avoid return type warning
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Hongwei Zhang <hongweiz@ami.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 10 gru 2019 o 23:10 Andrew Jeffery <andrew@aj.id.au> napisa=C5=82(a):
>
>
>
> On Wed, 11 Dec 2019, at 06:58, Arnd Bergmann wrote:
> > gcc has a hard time tracking whether BUG_ON(1) ends
> > execution or not:
> >
> > drivers/gpio/gpio-aspeed-sgpio.c: In function 'bank_reg':
> > drivers/gpio/gpio-aspeed-sgpio.c:112:1: error: control reaches end of
> > non-void function [-Werror=3Dreturn-type]
> >
> > Use the simpler BUG() that gcc knows cannot continue.
> >
> > Fixes: f8b410e3695a ("gpio: aspeed-sgpio: Rename and add Kconfig/Makefi=
le")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Acked-by: Andrew Jeffery <andrew@aj.id.au>

Applied for fixes.

Bartosz
