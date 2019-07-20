Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE08C6ED87
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2019 05:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390525AbfGTD1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jul 2019 23:27:02 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:51747 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728767AbfGTD1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 23:27:01 -0400
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x6K3QYjE010762;
        Sat, 20 Jul 2019 12:26:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x6K3QYjE010762
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1563593195;
        bh=/cy4zkl9MBndlJPf309omN2x5BYB6od3xL14Bqq951k=;
        h=From:Date:Subject:To:Cc:From;
        b=YBL9SX8nGcdiSDqzzqhaCwQW4V/n+XvKYlm8sCuY3fUDN7SPLhzmnRVzsx+SE2Jvf
         eNaza/lW5/OwBI17PmoK/W9nWBdI5rD0xRnCiA80SmEY5HHnBg2i6sttwv9d8Nz4ZM
         LSLSw/f4andPN3Nu8ltIaR4rVSOoLCVtCoMFlQF2hNPMVk+TnA4CgnKNOoIUJLcwtl
         RbfI2kFtP1wwHK/N6MC31iIO3u3tHCSCeLd0hsPWAiU44o6YLn2dqmJ+oZp52Rg0YM
         ZWpFt/AQCsZ3RU0a0uNa+oq0v6pzg9kUYaJlO4jcDeZse1mgR6GLePk5DV6rzd0QwO
         Xw84/ASDn7gzQ==
X-Nifty-SrcIP: [209.85.222.52]
Received: by mail-ua1-f52.google.com with SMTP id 8so13297460uaz.11;
        Fri, 19 Jul 2019 20:26:34 -0700 (PDT)
X-Gm-Message-State: APjAAAVWV+RQ+XS/6XeqH4EMrQmUh/uipTf8oLr741AgajDR1kvw5ktT
        05QtnOr6Al18wqF/j71peGq6OcnRQdTAK9tjvyM=
X-Google-Smtp-Source: APXvYqxMWol/Hq29+8CUkgjOAH9mDC4bKgEruVV4pjWDHDa2y3dUX8Vbo6R5vHcaU54H7hy2Je1Ilc698k/gWzOxwd0=
X-Received: by 2002:ab0:5ea6:: with SMTP id y38mr35301733uag.40.1563593193773;
 Fri, 19 Jul 2019 20:26:33 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 20 Jul 2019 12:25:58 +0900
X-Gmail-Original-Message-ID: <CAK7LNASyzmYjjBkFxRc06rqf36-en-bvJvrKcg6iiRfjoPCxhQ@mail.gmail.com>
Message-ID: <CAK7LNASyzmYjjBkFxRc06rqf36-en-bvJvrKcg6iiRfjoPCxhQ@mail.gmail.com>
Subject: [Question] orphan platform data header
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        masahiroy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I see several platform-data headers
that are not used in upstream.


For instance, please look at this driver:
drivers/leds/leds-netxbig.c

If I understood it correctly, this driver
supports both device tree and legacy board-file.


I grepped 'netxbig_led_platform_data', but
I only found the driver and platform_data header.
No board-file in upstream.

masahiro@grover:~/ref/linux$ git grep netxbig_led_platform_data
drivers/leds/leds-netxbig.c:                          struct
netxbig_led_platform_data *pdata,
drivers/leds/leds-netxbig.c:                                 struct
netxbig_led_platform_data *pdata)
drivers/leds/leds-netxbig.c:                      struct
netxbig_led_platform_data *pdata)
drivers/leds/leds-netxbig.c:    struct netxbig_led_platform_data
*pdata = dev_get_platdata(&pdev->dev);
include/linux/platform_data/leds-kirkwood-netxbig.h:struct
netxbig_led_platform_data {



So, what shall we do?

Drop the board-file support? Or, keep it
in case somebody is still using their board-files
in downstream?




--
Best Regards
Masahiro Yamada
