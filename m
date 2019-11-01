Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88237EC0E1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2019 10:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbfKAJ4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Nov 2019 05:56:05 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39860 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbfKAJ4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 05:56:05 -0400
Received: by mail-ot1-f68.google.com with SMTP id t8so7908705otl.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 02:56:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RLK8g8v/VUBKu+/ZUT8I6KEEkTbsWdVAtw2AVixp0is=;
        b=ttzzy0Wqqd+/TOuvwkkzn7NwEojrCUGpyqNS0W1K1zpeY39fcUY0RrWiPdzUrdVGrY
         aOl0TrUMBJGfIg3VtsgJYI/TF1lO9gZe3hSSvmwMSs2A0uog6CoWeOVn2xlREGrgAfz/
         t+bA8hMILmnTBwyNH2/z7cT0UHy5W9ak85cuTSD2f5WevJ6owNECs+MR+vHkogXD2Bsk
         TV5yzwDV8iolNERZ04FJZ+SXUvzEHaUuIhqc+3C2gSGFk7zWsZCvUZynI7dWFK2+aOI4
         vvtEPGN+pzHiK6BxfQ1kgCjTAv1no/Ref/UbFL35UOM2g4OWsabd6lrYenFXOdaIlKC7
         Q2+g==
X-Gm-Message-State: APjAAAU+EczRuXO8lb7lYrMLBZ6RHFAyaGmqG9j9Bkf7IcSVC4IXkYow
        uiin50uA7YkqKfQXuKtHqEesol6kAxw0LVawIAmGwTfseAU=
X-Google-Smtp-Source: APXvYqzElZjoT5apZmKRSENSAVootNVs6FK80VxiUE3enYS4OrBGS3kYIbwuG1uCCbT/4i0Ziubbe4Xvutpzho+P2Xs=
X-Received: by 2002:a05:6830:20d2:: with SMTP id z18mr2731298otq.297.1572602163856;
 Fri, 01 Nov 2019 02:56:03 -0700 (PDT)
MIME-Version: 1.0
References: <20191101092824.8907-1-geert@linux-m68k.org>
In-Reply-To: <20191101092824.8907-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 1 Nov 2019 10:55:52 +0100
Message-ID: <CAMuHMdVagd_kL-xji9NYOGeqGzhTVr0BQp3afgZXAQbkViPSYg@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.4-rc5
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 1, 2019 at 10:39 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v5.4-rc5[1] to v5.4-rc4[3], the summaries are:
>   - build errors: +1/-0

  + /kisskb/src/drivers/staging/octeon/ethernet-spi.c: error:
'OCTEON_IRQ_RML' undeclared (first use in this function); did you mean
'OCTEON_IS_MODEL'?:  => 224:12, 198:19

This was "fixed" in v5.4-rc4/mips/mips-allmodconfig, but reappeared
in v5.4-rc5/mips-gcc8/mips-allmodconfig, presumably due to a different
"make -j" compile order.

Michael: perhaps you can use "make -k", so the build continues as far as
it can get, and we no longer see these fake changes?

Thanks!

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/d6d5df1db6e9d7f8f76d2911707f7d5877251b02/ (232 out of 242 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/7d194c2100ad2a6dded545887d02754948ca5241/ (232 out of 242 configs)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
