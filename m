Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B24BDD5286
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2019 22:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729589AbfJLUzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Oct 2019 16:55:55 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33805 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728506AbfJLUzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 16:55:55 -0400
Received: by mail-lf1-f65.google.com with SMTP id r22so9304067lfm.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 13:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PozVrf68QgImeH7sK38rIhWBtZm9HKA3PtIRQs99eCM=;
        b=PvLl6XRrpKcqWyzznbvcOgTu7bmEN2AEJokhLIVnTMcZzISkcllFFNUi0Hdcdp985h
         fyg1Z1DYVdSQUR3qlR8GbmGd2uuSsqBEvbN1Wl6eWBohenTsYpBhXCOxrj32i8tGsW3R
         0yMCmvBuIU04vqizuM0MXW12LjHSAFtRLJVqpvgKxl8SpHnMeTOKhqhaMTZrK6n7+IYQ
         kqbd8c8Cfxa3magfuvkked5lvIzn8BtvObewcXNHitrxUoCBdN4UfZ6+DyMfl+GNyb7U
         Ociw/jrpsn/4ILGTprFm13NHT2Qn/2+7JzDEIZAcyV6SD9wX1HcRcMr2HS/qieOeODeq
         V/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PozVrf68QgImeH7sK38rIhWBtZm9HKA3PtIRQs99eCM=;
        b=kRwwnRCbFB8PsGVsKpNCEyzHwcK7GMyYNB4KOMwdcB5H0EF/FxR2giZkTEjPL6dc+M
         IUhqRRXDPKHf0pK1MifGrbZrvUlQHg1pY1ixADD2gO/ok+og3LPmqFhwqPYyexdlRzMc
         kcle4R7WuNm5nrJoRQb86uaSG0ItbfyAl2/5geJukqVtwxw9ky+U9M6V6doroNHn+ISV
         gUmua84Dr+dE4bjpIZ0RE27Ru4jiCKcLFdj6+dVkegcIW79lQEQjChgJAcXNGSb2SSZc
         D4OcsfDJEKHut8sQz9vEJlCJH7Ym3yPyy8oSrSiDV6bATfG9zyLWwafLdh/w3RpKTrVE
         zMdw==
X-Gm-Message-State: APjAAAU2VxDVnJ8/meL0jJ+fxM0sgT/+gD+sqPvIT1FG+lKGSlwJO6hN
        SYVrT5EVarOTQocbaF7+l4VWXLPTZUa29pDmsLdDT7fP/w==
X-Google-Smtp-Source: APXvYqwP7qTN+qak3JzgSQA3zrclJSMQRn99WTuRIYR8bh//95Y7p76Jth2NXJXzNWzJl+PP4QfUyT6NMkA4feSos+M=
X-Received: by 2002:ac2:5542:: with SMTP id l2mr12035993lfk.119.1570913751542;
 Sat, 12 Oct 2019 13:55:51 -0700 (PDT)
MIME-Version: 1.0
References: <48afc878-5424-7554-cd02-4175ec12eaea@googlemail.com>
In-Reply-To: <48afc878-5424-7554-cd02-4175ec12eaea@googlemail.com>
From:   Gabriel C <nix.or.die@gmail.com>
Date:   Sat, 12 Oct 2019 22:55:19 +0200
Message-ID: <CAEJqkgjAMkoiAQeitQ1gdEpmZWvdqQE+fAsQU4W7M7JGxHboyQ@mail.gmail.com>
Subject: Re: Linux 5.3.6
To:     Chris Clayton <chris2553@googlemail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sa., 12. Okt. 2019 um 21:16 Uhr schrieb Chris Clayton
<chris2553@googlemail.com>:
>
>
> > I'm announcing the release of the 5.3.6 kernel.
>
>
> 5.3.6 build fails here with:
>
> arch/x86/entry/vdso/vdso64.so.dbg: undefined symbols found
>   CC      arch/x86/kernel/cpu/mce/threshold.o
> make[3]: *** [arch/x86/entry/vdso/Makefile:59: arch/x86/entry/vdso/vdso64.so.dbg] Error 1
> make[3]: *** Deleting file 'arch/x86/entry/vdso/vdso64.so.dbg'
> make[2]: *** [scripts/Makefile.build:497: arch/x86/entry/vdso] Error 2
> make[1]: *** [scripts/Makefile.build:497: arch/x86/entry] Error 2
> make[1]: *** Waiting for unfinished jobs....
>

What is your default linker ?

Also does make LD=ld.bfd fixes that for you ?

See https://bugzilla.kernel.org/show_bug.cgi?id=204951

BR,

Gabriel C.
