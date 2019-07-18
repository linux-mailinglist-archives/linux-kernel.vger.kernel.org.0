Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32A4A6D129
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 17:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbfGRPag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 11:30:36 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42357 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfGRPag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 11:30:36 -0400
Received: by mail-pl1-f194.google.com with SMTP id ay6so14073011plb.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 08:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:cc:from:user-agent:date;
        bh=enTxUkUzWwDVJKls4jnHiVkcuCVL3Z4nxXwF8v+fVOY=;
        b=MWl276meOjKDs2ZS61poZVM2fiDXKc6ShVWsOBZzjVtWKusvdwhSesvk7MvjqjkoyL
         g1rWRtaUPlMy/4rS4zBg1y7kfjnCaxe/N7x5YSaEwh/xVHHkACf2EW3e4Qx1v0E6NogR
         zXri1kaUUKJ9QcZk/OmRUkOalB6Cb57IwqzQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:cc:from
         :user-agent:date;
        bh=enTxUkUzWwDVJKls4jnHiVkcuCVL3Z4nxXwF8v+fVOY=;
        b=lvF83oVVnHckOd5jjZj4+6rhWmSw9U1WvLtYeblSF2gEl8kuL+TyOTmrFXsrBz3062
         U44qqL9pNzivtAY/idd/GGZhNHpPtIldi5rpnnUja/HY2IkzJ2JPBAM5EHfsXitJjfvS
         3v5Y74ZAT2gYjZgQqBJVWJ/9MZbMFVw1m+JKkUCUcaQr5GrzxqkbonQ6eOnvyoqpJte9
         rY5UdK3qsieeSDUk34sHIZgKA06gxltsR9SygunUc9FzDSzcj7JM5jNlvZ5xXUGk6g1n
         WgSEzhBsPGPRiEJ7efRMXiC3hZ5fxYZVoD7YIXdmc4yDci9cRgVv/lmA0ud7AUP/ThhJ
         x8Yw==
X-Gm-Message-State: APjAAAVG6XBmUs9SAPtxNhzbQeLqAL7kRSa4rg7iH+Ar7rAa3q0udame
        gNUPlMAb4K7MdGLqE1kRSOyyvw==
X-Google-Smtp-Source: APXvYqwwHOdtFI3g0e9QUZENq+nEdLyWEtPqwnAB8Ja1AUOSKTg5KC9sGrRwnscxa+7h15LnEJpM1Q==
X-Received: by 2002:a17:902:26c:: with SMTP id 99mr52459455plc.215.1563463835657;
        Thu, 18 Jul 2019 08:30:35 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id s5sm2217471pfm.97.2019.07.18.08.30.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 08:30:34 -0700 (PDT)
Message-ID: <5d30909a.1c69fb81.23a02.413d@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190718065101.26994-1-yamada.masahiro@socionext.com>
References: <20190718065101.26994-1-yamada.masahiro@socionext.com>
Subject: Re: [PATCH] gpio: refactor gpiochip_allocate_mask() with bitmap_alloc()
To:     Linus Walleij <linus.walleij@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-gpio@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Thu, 18 Jul 2019 08:30:33 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Masahiro Yamada (2019-07-17 23:51:01)
> Refactor gpiochip_allocate_mask() slightly by using bitmap_alloc().
>=20
> I used bitmap_free() for the corresponding free parts. Actually,
> bitmap_free() is a wrapper of kfree(), but I did this for consistency.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

