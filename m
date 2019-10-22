Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8484FE0D1E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 22:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389315AbfJVUNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 16:13:32 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:46799 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389303AbfJVUNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 16:13:31 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MSswA-1iRrex3uAw-00UJql for <linux-kernel@vger.kernel.org>; Tue, 22 Oct
 2019 22:13:30 +0200
Received: by mail-qt1-f174.google.com with SMTP id t20so28734686qtr.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 13:13:29 -0700 (PDT)
X-Gm-Message-State: APjAAAX3RIKOBuArGOe92sTgorDQDiwDKyvcTa+gqLok9pHfzEZorhAw
        pv/qrmsGq07wmQ5mkR+JBxWflQb3WUUAppTk0yw=
X-Google-Smtp-Source: APXvYqwHws2+wdbd8O8mZBRDAI3f/vMQUkU/DX6M5bMx+/92TDs7sn5fYNiZg1DtZYJeC8Fy8qgIRm0PfsfvEwlnrmU=
X-Received: by 2002:a0c:fde8:: with SMTP id m8mr3823785qvu.4.1571775208879;
 Tue, 22 Oct 2019 13:13:28 -0700 (PDT)
MIME-Version: 1.0
References: <20191018154052.1276506-1-arnd@arndb.de> <20191018154201.1276638-30-arnd@arndb.de>
 <20191022163913.GV5554@sirena.co.uk>
In-Reply-To: <20191022163913.GV5554@sirena.co.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 22 Oct 2019 22:13:12 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0a2EU8mKNGLNoh+fnpNU6X=qgpAv3kOGN5uXv+f63KwA@mail.gmail.com>
Message-ID: <CAK8P3a0a2EU8mKNGLNoh+fnpNU6X=qgpAv3kOGN5uXv+f63KwA@mail.gmail.com>
Subject: Re: [PATCH 30/46] SoC: pxa: use pdev resource for FIFO regs
To:     Mark Brown <broonie@kernel.org>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Z7gtCbAlZJNUJ5dtscheTnGsImUi59yfxtXxsOnip7nUV+bpUQW
 5e+n+gxjVe1MEgQ88jaJ6Ps9VZopc+E6mgXTiERvAJWNFrw9il0xmOilt6wOqDR3Q1dJKL6
 MbXjRnwZUSF0pu4JV679XLYtqkw4Q9b0J7IAQzouZeWxHuiOuoYlAaJV+olRYwAVlazRSCt
 QTRFu3YRhrSvUBlJ061+g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DxOSmeBgJQM=:DNcJtrdP/WV/ixqJ4D7k4n
 +s7wDYln3wavlJlYMX5ujL3MRAlXj//VCEL9TqlfyNt9a2doZKhzcpaAhdQYjmBbDGcrQ55hm
 lHv26TsgvfBqK6A0Wqx2jB46rcvo0MsC1kc2PqYO4UkiWdV7Gr1b4HOFi62KOrP6QWsdAjFI4
 RFW+JWVMIuXYydNuQjNru8f2q4S/znPVNUS9tpS+3Go78i66yu/9XXgR6RkUZ9DbC7LuT+J43
 fE/ylIzVarGk9yHy1BA74qzWUGpd0yMc0cLJa4K4ne5Otw8RlR/76ErCdIHC29B/yPRjxoQFq
 5F9B/tNu+KVT8DQ0VOUmgLBdokY3lA5yuPUAOZKtbpa8zf60PR9eJNc1qV38vIZVTl5IgxaFB
 xpRe83kfbKlwo1BTqXQx2T0L6jdd2eju6dDIDXZOhEMJIDd9B8aXJBaAskiSqPOv66Z6Yn8KF
 RewU+/Umbz1KLYYmMk/9+c/UPPJ4uQYf7uATjdS7XgSmaaClRhvGHeyOiGo/IwogFHJgvaete
 Qxe4VZ1MY4SN/qXc4VHIJvuBCal4zvraVSDYTm4uepTqJT7KBCb4WPP8TLkYE20QNz+vV8TeR
 FhkTrGThfQzMF4fq2JFJW2lknnTsr+qi/PrZFsdVhz8S9V3w76YLz3pKJQ9+hxRfq7dG8WRIN
 CMRbz73GVnjmqgUJ6jCaYnjAnkCn5yzoY1f+Cu1bcGKs5h+OWp+eXpr931v93H2We0L7uR0pW
 RvhTyC/ZP98hNaakZWGCcofY/P27eukYdcrShU33B/y2ThpU915PktxUEX+2adtptJ+spg/5m
 LffdjlFMyJXnUjdblwi1qkjmBkrHlDx6K8cuvsoVtwa/sisNe6W5yo9qySZGi2S45Q6S10Qfd
 h0SrzERdFWA6Do6BtyFQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 6:39 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Oct 18, 2019 at 05:41:45PM +0200, Arnd Bergmann wrote:
> > The driver currently takes the hardwired FIFO address from
> > a header file that we want to eliminate. Change it to use
> > the mmio resource instead and stop including the heare.
>
> Acked-by: Mark Brown <broonie@kernel.org>
>
> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.

Fixed, I guess I lost an 'A' somewhere.

      Arnd
