Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 585D010D258
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2019 09:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfK2IT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Nov 2019 03:19:59 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44927 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfK2IT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 03:19:59 -0500
Received: by mail-lj1-f194.google.com with SMTP id c19so4002983lji.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 00:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gv5zzVxLlG8GDkPCvOw5BxFln15GQXxmdxcqIDkEcJA=;
        b=Hr+/H5eKSVxdaZL3TW+Cs4R15WVDNCGrQGDFkhiDTMqROh8mUQoHjF6OagTz8SKZ2Y
         hVozHvElVuWcFXlImw1kjxdoIM3a56iaME/n009GOhpL3UF8LzvK/CWO4+aw8aoGGffm
         t1+2IXz8AWYE9xR1zAOCxRm+1RuuKkEb71E8FpJkKxelKDWndMI+YerN1FVRPzxuV4Bf
         P0tBe/FyrdTvsis01b/fGSwpjonrjHHp9ZtXKEeg0RLtdAnYiv87woprBHX1CxWB+KZa
         gzoAoLfO8v5zY9FUsOCErJULWnfzvEmOySo5aBDwMg46933Vka+OqM+hiNBVWS2PpAw8
         AIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gv5zzVxLlG8GDkPCvOw5BxFln15GQXxmdxcqIDkEcJA=;
        b=ji0FFJrvb2rVh8uV1JH0NVIkO1rZK1/XiJewsAWu4GVcQuioMWPAOeD6AYJ+c50/5q
         ZHXFaUZytWmzQdAD5WKkOAqgpyDVybtpbTsRqQpX6kVIoS/wNx6AaJRz7Tr52sM1ecIE
         gOZJqP1iQQllkcheRQamclJg3G79XZeB0/qetTda2+cmdbxUHeiwFnjIpABGxO2cf4DF
         GbMZ/1ynQPlB7d8Q0u8cKRRg5dr2e0WRZR9kH2pwWWBVLfsgJCkMDfBSBPvn00VUbw9T
         EbeaNMbAu+lv23fnMZbjjFzJaz66d83L1tJ4m0SZZaVVzc3Qwbh+MzjrUMt0PoSGL7eo
         xXGQ==
X-Gm-Message-State: APjAAAV7NfU9NpyQMwIi6tU8RDMt8Sh14BQQ9h6hPyJn3dkhibxsuM+X
        gwXQ19jCQdSSGdGjX3ABBDTkPe1g8dhCDr46ceV+3A==
X-Google-Smtp-Source: APXvYqxTbw/GWcCmI6F1xAyj7Ov90F12pWRTUeAlSwyu0LjSbeOvd/n0hFxY8xq51whjcI+lFRufiQc5sgvumxHycoc=
X-Received: by 2002:a2e:b4f6:: with SMTP id s22mr24453253ljm.218.1575015597194;
 Fri, 29 Nov 2019 00:19:57 -0800 (PST)
MIME-Version: 1.0
References: <20191127095919.4214-1-geert+renesas@glider.be>
In-Reply-To: <20191127095919.4214-1-geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 29 Nov 2019 09:19:45 +0100
Message-ID: <CACRpkdbRX4D8TtmuvYL7FyJ6_4E+uALhMhi87zCsXQ3M_DBZfQ@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: Fix error message on out-of-range GPIO in lookup table
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Alexandre Courbot <acourbot@nvidia.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 10:59 AM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> When a GPIO offset in a lookup table is out-of-range, the printed error
> message (1) does not include the actual out-of-range value, and (2)
> contains an off-by-one error in the upper bound.
>
> Avoid user confusion by also printing the actual GPIO offset, and
> correcting the upper bound of the range.
> While at it, use "%u" for unsigned int.
>
> Sample impact:
>
>     -requested GPIO 0 is out of range [0..32] for chip e6052000.gpio
>     +requested GPIO 0 (45) is out of range [0..31] for chip e6052000.gpio
>
> Fixes: 2a3cf6a3599e9015 ("gpiolib: return -ENOENT if no GPIO mapping exists")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Patch applied for fixes!

Thanks!
Linus Walleij
