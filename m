Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFB2813ABE8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 15:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbgANOKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 09:10:20 -0500
Received: from mail-qt1-f176.google.com ([209.85.160.176]:43496 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728791AbgANOKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 09:10:20 -0500
Received: by mail-qt1-f176.google.com with SMTP id d18so12501185qtj.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 06:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7vP28yU5QYefVRMgVUvqZBCKpBqmJRQKUJI4P+13Edc=;
        b=Zvw16p2TILaErZPy3ji4/1LZ2TpdWdcJcubKwP1k5QDXnoV2r3GDf821CV9Ubs+Bws
         ssXXOk3hj4350zIytHqo4WA2GmXkCMatzWcB28EWtKViOjZH/Iodb7w0EfhZyW6kG7ko
         U7MsB9c3ZG+UVYszx9Mal+O+QTi3VcDenk3qk1L37+5w6WoZh1Q6lhxy0HPUGHJJJQud
         waHtNy5Vshl2701MxI6yqaxEPT4rRD5vAV4xzfXbv1ze1kw0oonkDG0/aXO7fxRA7QJ4
         V9AgNDuSPqn5GZzoX8AjN95XY7R3nPBicfPUmaWQvgFEiPj7THxKn8BMBOcvurK1Sqfj
         ITZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7vP28yU5QYefVRMgVUvqZBCKpBqmJRQKUJI4P+13Edc=;
        b=rSGOm3vcIMi4eb3Np3U9mRSYNYlTkBnFBxYiLkcdnxCcBUhCWi9hessJvKw1oP9aHU
         KMq0sM79Pk0fgjMV+qVTszQxP42zeKujc7DlG8iTa0MW/gwmAKjKkIJGqDKnv4laMp+t
         VXhJGkMgxovF1I8brfYjEEeP6OBND1QPExj7JVTO+BmR4jY7Vr5nJbVrfDisTKj1CXfw
         Inn5CIQjvuiCf1bBf/yODo1tz9rLitTICfeK65ery3xmqQs7DwK/cKhvkv519vYBg9pA
         /PoIhoigcP3PySlFyCTBG6/ZDyRt0ptg3L0TuEu6s08PGPctolsRmpdY54wj9lP5/Hpn
         hStw==
X-Gm-Message-State: APjAAAXHqVS+W1Ed+MI2HhYeVFG972jqnya1wZLom/u9NfWGsx682jem
        rl040xA7XSye5M4WPl4M6T2DqrKjr6mmWtOiu9FC3A==
X-Google-Smtp-Source: APXvYqwRFRaY5hg4/x0A9VrxpDMj29mGS3CQIm65b63khvnkkIu8sdU9mUZxQfQIXpqJAZmFDuce2aLs4lmYDvSKzMc=
X-Received: by 2002:ac8:6784:: with SMTP id b4mr3620264qtp.27.1579011019735;
 Tue, 14 Jan 2020 06:10:19 -0800 (PST)
MIME-Version: 1.0
References: <1579009062-7154-1-git-send-email-zhangshaokun@hisilicon.com>
In-Reply-To: <1579009062-7154-1-git-send-email-zhangshaokun@hisilicon.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 14 Jan 2020 15:10:08 +0100
Message-ID: <CAMpxmJVrc27pcMA---jRyfmveKfjKfuqSg0j=oomSLvYoeA9dA@mail.gmail.com>
Subject: Re: [PATCH -next] gpio: Remove the unused flags
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 14 sty 2020 o 14:38 Shaokun Zhang <zhangshaokun@hisilicon.com> napisa=
=C5=82(a):
>
> drivers/gpio/gpio-grgpio.c: In function =E2=80=98grgpio_remove=E2=80=99:
> drivers/gpio/gpio-grgpio.c:438:16: warning: unused variable =E2=80=98flag=
s=E2=80=99 [-Wunused-variable]
>   unsigned long flags;
>                  ^
> Fixes: 25d071b3f6db ("gpio: gpio-grgpio: fix possible sleep-in-atomic-con=
text bugs in grgpio_remove()")
> Cc: Jia-Ju Bai <baijiaju1990@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>

Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
