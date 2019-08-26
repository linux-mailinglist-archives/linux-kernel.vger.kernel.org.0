Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0239D81F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 23:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbfHZVWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 17:22:42 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:35401 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbfHZVWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 17:22:41 -0400
Received: by mail-pg1-f181.google.com with SMTP id n4so11363078pgv.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 14:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=VPS4MAzvQAs+keaEvLctLZOSLaEpPwLRduR/Z+4g8a4=;
        b=bxBkkRjbR1i2wpYutu34wdqibtjiP/i7+NEPQREwVGN+P30osjQuBVN/FHfR3WVymj
         OqhWrdzgautvhTkf7HCMoCzIooevpp1q7xjnfJR/P92LLp1mvKWb0ieDYuY4hjrqk2ip
         Bbj4ODZ9QVcdDhQtoP8oxLUi/+KznuJWT471ODu4z3oxcI6UIXJ25YIHkUYaK5qnxGRs
         fz3woP6LwPJs9bBIxiUhDBSo55ZvpfFshWXFBG1IBtYNd/9/Y+uu4qy8LdgNgZpIFgCo
         HjlLLInCvo/I9lDAUUj5RVnkKBRT8Q2OCcQsX2nPvJ1Hbg7Q7utpzofOSdlarmW0j7bN
         R3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=VPS4MAzvQAs+keaEvLctLZOSLaEpPwLRduR/Z+4g8a4=;
        b=uVWYnOis78DdeIwhO2U3Yhuns5Yx9MMRbbdw1pSZGeFFGOSCQ2mBocTxYVl/6Vk0jw
         1UI4M5u89OOVp0gLgkaBh1F+uzKKDyeClQnymCIKQC0Lv6Yvr78P5xpw9IacFvgXg5GJ
         ii0/oc8nvdrp6DnPx5sMCv+yB32kZz476jxIOcUral98fwYmz7ILEsIdh7HiXZDaaMQX
         XUY/9RbNn0ZIPEw0+Xg7spgtulHjed9xfMf4Q+xu1HIdx/8cpT9ibB2CFNdade5PRMjz
         fTrWtteJGBjP1XW7+OO+vFMWKcY7fs7SwsGFXGa2RHSlv/l5Hd8lORnN4k6adKmbJ3w5
         kI8Q==
X-Gm-Message-State: APjAAAUhD4mw9lYNMYs+IDdwEuTsSwfUL4aECgoU+HqChPGf+v+L1w0O
        xWJ/uapkObtWSpYjDVZGDOLkNJy+4J2VkqpPeve+7w==
X-Google-Smtp-Source: APXvYqyb2gWPbsA3iHcEhKfPrmDeuCqAraBuwgFgcu4r6fhBhnjK4FcpO4JC2Ch2c12s7RX0PMmGFcrdbxvQ+X3ydn4=
X-Received: by 2002:a63:60a:: with SMTP id 10mr18067622pgg.381.1566854560201;
 Mon, 26 Aug 2019 14:22:40 -0700 (PDT)
MIME-Version: 1.0
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 26 Aug 2019 14:22:29 -0700
Message-ID: <CAKwvOdnJAApaUhTQs7w_VjSeYBQa0c-TNxRB4xPLi0Y0sOQMMQ@mail.gmail.com>
Subject: a bug in genksysms/CONFIG_MODVERSIONS w/ __attribute__((foo))?
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm looking into a linkage failure for one of our device kernels, and
it seems that genksyms isn't producing a hash value correctly for
aggregate definitions that contain __attribute__s like
__attribute__((packed)).

Example:
$ echo 'struct foo { int bar; };' | ./scripts/genksyms/genksyms -d
Defn for struct foo == <struct foo { int bar ; } >
Hash table occupancy 1/4096 = 0.000244141
$ echo 'struct __attribute__((packed)) foo { int bar; };' |
./scripts/genksyms/genksyms -d
Hash table occupancy 0/4096 = 0

I assume the __attribute__ part isn't being parsed correctly (looks
like genksyms is a lex/yacc based C parser).

The issue we have in our out of tree driver (*sadface*) is basically a
EXPORT_SYMBOL'd function whose signature contains a packed struct.

Theoretically, there should be nothing wrong with exporting a function
that requires packed structs, and this is just a bug in the lex/yacc
based parser, right?  I assume that not having CONFIG_MODVERSIONS
coverage of packed structs in particular could lead to potentially
not-fun bugs?  Or is using packed structs in exported function symbols
with CONFIG_MODVERSIONS forbidden in some documentation somewhere I
missed?
-- 
Thanks,
~Nick Desaulniers
