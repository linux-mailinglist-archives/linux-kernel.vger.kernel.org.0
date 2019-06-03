Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE5BB332AF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 16:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbfFCOvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 10:51:11 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38106 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbfFCOvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 10:51:11 -0400
Received: by mail-lf1-f65.google.com with SMTP id b11so13850342lfa.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 07:51:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=MBL+fg5s5nyVMmV2qt2b4wiQiWgUX3PyPuGbAGODoQ4=;
        b=GHmDEOrfOGINJ+aHijLPpZ6ByIwzqLKsHiBLIH2J8utLTFyqilWsScbm209p9wiYNA
         XBh6whIFs2O0vVfOPcSWnpvLY0cyimIqokxFtezYv4AR70NXomAZlzrDYLnopvDpLLu3
         tlWmSJvJk1v934EOLgqy652xNA0nYFXeb5V6DzjWv0c1HtcTubX0ytbumqtxw4GXhORw
         saFeJML/H5XfRS1pzYKT6OMSZdizF3ef5CiXqV/HYTDdIGlWkbaA9tST1kbg1Mq6JBow
         C1V+w2D4Th0dxjyjA00DFXMgQnvIun9M4SqBAL+s4smekxesTquOy2dhfuZ6ubyhs8DV
         MCRw==
X-Gm-Message-State: APjAAAWsloeRBWYBsCU8PIdViJsPk0ZcmMPeZ+8C3IZ5gNKr5QJcgSvD
        6TDeacB6XFY+Vsme8TQzxl/wD150AhANFpuUgcWpY/pA
X-Google-Smtp-Source: APXvYqzWLeGY44R+uRX3tAMm0/HO0tLxdjS3U05upj/AVMWlONG6QXW8AAVKGOiAZKNh9a4Phe96MtImkCzJyAeVkbk=
X-Received: by 2002:ac2:5a04:: with SMTP id q4mr13870259lfn.90.1559573468125;
 Mon, 03 Jun 2019 07:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190603142838.25494-1-geert@linux-m68k.org>
In-Reply-To: <20190603142838.25494-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 3 Jun 2019 16:50:55 +0200
Message-ID: <CAMuHMdXvSoc2CqOcovpCSYWuuQ_z1OsgTJPX8nXJZ+2JXF7vWg@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.2-rc3
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 3, 2019 at 4:29 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v5.2-rc3[1] to v5.2-rc2[3], the summaries are:
>   - build errors: +1/-3

  + error: "devm_ioremap" [drivers/counter/ftm-quaddec.ko] undefined!:  => N/A

um-all{yes,mod}config (patch available)

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/f2c7c76c5d0a443053e94adb9f0918fa2fb85c3a/ (all 242 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/cd6c84d8f0cdc911df435bb075ba22ce3c605b07/ (240 out of 242 configs)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
