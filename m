Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26C05B5937
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 03:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbfIRBUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 21:20:15 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42871 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfIRBUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 21:20:14 -0400
Received: by mail-lf1-f65.google.com with SMTP id c195so4336270lfg.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 18:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XZNPfc6roJDRqmm7Hq8AaswPkY6LR6E77xlBLQ/HJ7I=;
        b=FzJhEyBPVTskda0cSucuaFKcE8AEsBpYdGOJjLPClHwFKc2AS/i3sV9dJdFatrdl9/
         d0bWr9ZHhztIufS7u+2stdRbWIRLzOK/Bwm0TtRbjePzxKxcyg40NuanmOr9EE+lFHAf
         T09bX7Lwf4TX2HtwM0RbKJPmFyV4HubOteVNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XZNPfc6roJDRqmm7Hq8AaswPkY6LR6E77xlBLQ/HJ7I=;
        b=Wx71Pjr91gkH7YRq3N1/SbWxuGC9VZFpIZqhtQ7tpKF4tsm9yBEHbeFgX+8K9z7TAN
         PGpPFShQp/AyHANc2CmSgVufqdBv8OinQ1ZxMVzpjgW6g0iKiq1QfFw/r92RfkV7Rfqu
         4jMWg6GN088Q9ta00wcFuIKow+MDwrhkpq2xuq7FRykHv7de2rEAVfdUO5s9wwpq6twS
         2K+zxq8qgMRlcMm7scfLfTUlpY2LPoUdtbx7eyPHQZflm3znMZ9lVOF83Ao9sIRTzH8B
         fPQ5VPl8DXa3Xn2yOt1HwG2beahl3Pp9vtLDYYaLUg9ZPhuuG7aQXlZxd/559tNVs0FH
         B8Gw==
X-Gm-Message-State: APjAAAW3fB1+jXIBe1zqWNsgmy+5AXNFn7t9Yw5Ox8pteM09nwSozYWx
        w9enjKva7gMEQfYDy9e0bSD3lQrHxQc=
X-Google-Smtp-Source: APXvYqzkanEfAmCVtq3MBWbFdHrpx0tYhaWI1gYzVMz50QeWm8pDBZWXYiWhaXFaOG3oipNGajzg1g==
X-Received: by 2002:a05:6512:4dd:: with SMTP id w29mr601279lfq.2.1568769612396;
        Tue, 17 Sep 2019 18:20:12 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id y16sm724031ljj.25.2019.09.17.18.20.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2019 18:20:12 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id d17so4342497lfa.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 18:20:12 -0700 (PDT)
X-Received: by 2002:ac2:50cb:: with SMTP id h11mr580490lfm.170.1568769268404;
 Tue, 17 Sep 2019 18:14:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190916222133.9119-1-jacek.anaszewski@gmail.com> <CAHk-=wgxNj_RBpE0xRYnMQ9W6PtyLx+LS+pZ_BqG31vute1iAg@mail.gmail.com>
In-Reply-To: <CAHk-=wgxNj_RBpE0xRYnMQ9W6PtyLx+LS+pZ_BqG31vute1iAg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Sep 2019 18:14:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjAVTCZ9-X6ETA7SASNhrOyJuCgn792E_Wmn+JaEQ8N0Q@mail.gmail.com>
Message-ID: <CAHk-=wjAVTCZ9-X6ETA7SASNhrOyJuCgn792E_Wmn+JaEQ8N0Q@mail.gmail.com>
Subject: Re: [GIT PULL] LED updates for 5.4-rc1
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-leds@vger.kernel.org, ada@thorsis.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        christophe.jaillet@wanadoo.fr, dmurphy@ti.com,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>, info@metux.net,
        Joe Perches <joe@perches.com>, kw@linux.com,
        Linus Walleij <linus.walleij@linaro.org>,
        nishkadg.linux@gmail.com, nstoughton@logitech.com, oleg@kaa.org.ua,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Tony Lindgren <tony@atomide.com>, wenwen@cs.uga.edu,
        wsa+renesas@sang-engineering.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 6:13 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So this is fine and I've pulled it,

Famous last words. I now get a new warning:

drivers/i2c/i2c-core-acpi.c:347:12: warning:
=E2=80=98i2c_acpi_find_match_adapter=E2=80=99 defined but not used [-Wunuse=
d-function]
  347 | static int i2c_acpi_find_match_adapter(struct device *dev,
const void *data)
      |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~

with this pull request.  I'll have to look at it after dinner.

              Linus
