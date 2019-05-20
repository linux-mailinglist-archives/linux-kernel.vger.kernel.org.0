Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5298C23FDB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 20:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfETSDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 14:03:38 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41664 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbfETSDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 14:03:37 -0400
Received: by mail-ot1-f66.google.com with SMTP id l25so5473269otp.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 11:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lg7t75rB4qsd4s6bpU4YxhlW8EWy8AlH8d1j0mkYGbQ=;
        b=aB/+gm/N1HtoFCU/k46QW8IBr9SqqX2Xd1UivpNP9QWz8TAu9TYbiIF2+3EMwo4JB+
         bC3eXFKgjWk3FzIkHstiW0t2sl0GiPFWlF6087C4LfbG/DUfpBlSO0Dpfwhn9MBa9GFy
         TO8coCBXhkCs9buhCyAjRsQDKbblWQDtMGKevRb8gUKpffwVcNRhoVnvhlqO6hvQ33G/
         L82DmaoMlvySscXWNU7DDgKKkl7bbSlJIXFhg3tFnpU6+mOUraWjQ14oa6UrO/uUWiCT
         MSUbDSm/svW5aSGRFccKZzdBx7931ih3B9Z/TcOFzvWYyfJHGtkpNUNHz9Fy+94JQhDq
         Uw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lg7t75rB4qsd4s6bpU4YxhlW8EWy8AlH8d1j0mkYGbQ=;
        b=RzHdWWL594V8S8hgxVNrczQvvTUR4ICwEgLNNTOHznRbABjf5T67nRMVLItcpvSFJK
         uMwtXeFZTWV3aARqqAGkACaaCj779IPhv7TcQgsvvyDIH1oE3tcaW0+SaSE58bumWXh9
         jJnQIrjIYPKgThKXa2XZoM8lHtTBUzs5+QZomShZ4dNMc/r81Ya/dDt89hBDgw+a7Nl4
         ooFmtitOLX1reoHeLZg/4EBelJKcUMUduCOc6f4l6T+N8rvqwWWhQB7fa4KpAXpRSvHC
         21/mdz2m36lLhdEWDUErViAvJHJy35xuDm4wl5BZfMvIyz7vj5RJIo/G8GPAXCaYX2a8
         RMeQ==
X-Gm-Message-State: APjAAAXa/G9Ouyf+lzgtbSoINf2nUxWZtCiWsvRfy1/BczgUcPs7WqxX
        UoAhnz9nZjbmxtgf0LPt1PBW+rt8udVCcTx2llM=
X-Google-Smtp-Source: APXvYqxUQ4r21V391pp1rPbD48TGr1U/0J/RR9mhH1nqmJEvSFynCdpRaHREgDtfIR3rbJ3Gdi1/Ka7KaQ4LloCsTS0=
X-Received: by 2002:a9d:7c84:: with SMTP id q4mr37874589otn.98.1558375416758;
 Mon, 20 May 2019 11:03:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190520143812.2801-1-narmstrong@baylibre.com> <20190520143812.2801-9-narmstrong@baylibre.com>
In-Reply-To: <20190520143812.2801-9-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 20 May 2019 20:03:25 +0200
Message-ID: <CAFBinCB3Q9ZZP6UwiivWB_eb47vh6j2N9Og1qZWAi6hm4+17Tg@mail.gmail.com>
Subject: Re: [PATCH 08/10] ARM: dts: meson8b: update with SPDX Licence identifier
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Mon, May 20, 2019 at 4:39 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  arch/arm/boot/dts/meson8b.dtsi | 42 +---------------------------------
>  1 file changed, 1 insertion(+), 41 deletions(-)
>
> diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
> index 800cd65fc50a..c38b0828b7ec 100644
> --- a/arch/arm/boot/dts/meson8b.dtsi
> +++ b/arch/arm/boot/dts/meson8b.dtsi
> @@ -1,47 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0 OR X11
the GPL text below states "either version 2 of the License, or (at
your option) any later version" so I believe this should be GPL-2.0+
the second license text matches the MIT license [0] better than the
X11 license [1] due to the phrase "THE AUTHORS OR COPYRIGHT" (while
X11 uses "THE X CONSORTIUM")


Martin


[0] https://spdx.org/licenses/MIT.html
[1] https://spdx.org/licenses/X11.html
