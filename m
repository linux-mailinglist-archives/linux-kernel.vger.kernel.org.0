Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A11056401B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 06:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbfGJEbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 00:31:17 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:40114 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbfGJEbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 00:31:16 -0400
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x6A4V1jp017183
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 13:31:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x6A4V1jp017183
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1562733061;
        bh=NL0p8549tP4Y6hjgM0f3d+yvfYYRWKVEjoGHNGsWz2o=;
        h=From:Date:Subject:To:Cc:From;
        b=z8i7WWPfe8IVQgH8EpSapKyyp/JGuiyAf4MAtFt2o+iz07mKprZlah0I2giP3Ei0Q
         ovgD59WEXDEBVELLi35eBfxAXOuY5DxNjZj7FAzavVeDaPwqZ7QeVrqwKbyagvYWgt
         aQrLzc0ByG0iWpg2had5be2iT701kixbbxM1aM4kFLWaeJayrJEhD3EbeBJrKuMFI6
         f7dhGcwoVEULT03Y/8hJfgLOZXJd5y8zWCO94VBqy3dR12Zgsyxah2sLbBTdJUX8ua
         nL5Z0U8ZS3ktOBbsKCay/KoURxhSWkpXKxa1jY+d2qqVuaewUgjwJekPAfirSBs3XY
         TLI7ZNfPm+l+w==
X-Nifty-SrcIP: [209.85.222.52]
Received: by mail-ua1-f52.google.com with SMTP id a97so328318uaa.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 21:31:01 -0700 (PDT)
X-Gm-Message-State: APjAAAVBRaw1L2mSWTWEJPrtS2xy8mPrv+j2LeVy2csLvakU5Ee5ko5i
        2GO+//QLkNLTUsL0/ULzpEIfwN4Z4eyzvCzXMXI=
X-Google-Smtp-Source: APXvYqwvzyWAZCiFIry0oNqUjkphe352NGv9d9Jy4gXl11JK87bPaBl4wN/pIxpeQmVqfym5dbPLL41JIQSioxJBgJU=
X-Received: by 2002:ab0:70d9:: with SMTP id r25mr15210467ual.109.1562733060560;
 Tue, 09 Jul 2019 21:31:00 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 10 Jul 2019 13:30:24 +0900
X-Gmail-Original-Message-ID: <CAK7LNASSCvLSXVikR7GenXyb8KywpWKVc1Z=5v3c93rxJ+G73w@mail.gmail.com>
Message-ID: <CAK7LNASSCvLSXVikR7GenXyb8KywpWKVc1Z=5v3c93rxJ+G73w@mail.gmail.com>
Subject: Question about ARM FASTFPE
To:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        masahiroy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I have a question about the following code
in arch/arm/Makefile:


# Do we have FASTFPE?
FASTFPE :=arch/arm/fastfpe
ifeq ($(FASTFPE),$(wildcard $(FASTFPE)))
FASTFPE_OBJ :=$(FASTFPE)/
endif


Since arch/arm/fastfpe does not exist in the upstream tree,
I guess this is a hook to compile downstream source code.

If a user puts arch/arm/fastfpe/ into their local source tree,
Kbuild is supposed to compile the files in it.

Is this correct?


If so, I am afraid this would not work for O= building.

$(wildcard ...) checks if this directory exists in the *objtree*,
while scripts/Makefile.build needs to include
arch/arm/fastfpe/Makefile from *srctree*.

I think the correct code should be like follows:

# Do we have FASTFPE?
FASTFPE :=arch/arm/fastfpe
ifneq ($(wildcard $(srctree)/$(FASTFPE)),)
FASTFPE_OBJ :=$(FASTFPE)/
endif


Having said that, I am not sure this code is worth fixing.

This code was added around v2.5.1.9,
and the actual source code for arch/arm/fastfpe/
was never upstreamed.


In general, we do not care much about the downstream code support.

What should we do about this?
Fix and keep maintaining? Delete?


-- 
Best Regards
Masahiro Yamada
