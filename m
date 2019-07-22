Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2DCD70A68
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 22:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732511AbfGVUMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 16:12:55 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38358 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfGVUMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 16:12:55 -0400
Received: by mail-io1-f66.google.com with SMTP id j6so1669691ioa.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 13:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5VssAIpTuFKmj2zUfyBOJyi8Rg6YT/l3GL1/5vXR4ZQ=;
        b=dhcAjgoi9+qQzUWcowFh6AlTVc+cXX7gatGHZHks9JeKOOGWGHE25dYo58g5iTWmrD
         3G/gh1KuafpOXHyPB3O9Kx6l0P+HUGpADF788Pho/ArJ54Y6THO8vkWWltGAd20KH+rG
         +YCXOMQ1JrFmhW9LQuw9Gn91Qi5wwFKaVWueo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5VssAIpTuFKmj2zUfyBOJyi8Rg6YT/l3GL1/5vXR4ZQ=;
        b=A3MH//6xSP6Poj2060QyXewsUwkatDCnABTOnrfax71XNzumMSda17kAZMLZh4pz3g
         MjYnIBLBmTAZu8+PCVRa1dOU8t4jwjR/RdVfrpvL2Ytv3ahh1J5WZMNlPFE0P/SSeMOe
         S0AvJsWhkPIysqSAQQhsoKVtZ5RZRcmBxBLgf1R+JwsVqQBzVoRLYSoE8Wb1RJY2Tx1Z
         sSyAt6bRLCbyxwGgheDGmS1S1FUIn88Yvq9ehL2b/M66tUl7x6oePhPwTb+xwE+g4HqU
         wkfZaGxAx52oRheyHgvzFbbRyKnB6k00MLU/jyi3/MFJ8YzLH+KM/tlb388PUtfgLz6c
         zeig==
X-Gm-Message-State: APjAAAVCsOXgKBo3PO3lCn8KhkFtMBgsJLOwxvFXoY5ETVeqUolGZ9cc
        EtQIsFoIIohYgVmYGPuNdBcjUIMpfwI=
X-Google-Smtp-Source: APXvYqyKgA6gzWM71js4GQuvA/a3ttv99Um3nFdJ78iW2AgF7fR2kAOtvLpQ2egC4ZG+PMbHxWIdZg==
X-Received: by 2002:a02:300b:: with SMTP id q11mr76505551jaq.54.1563826374123;
        Mon, 22 Jul 2019 13:12:54 -0700 (PDT)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com. [209.85.166.42])
        by smtp.gmail.com with ESMTPSA id j5sm30977223iom.69.2019.07.22.13.12.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 13:12:53 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id e20so46449133iob.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 13:12:53 -0700 (PDT)
X-Received: by 2002:a5e:8f08:: with SMTP id c8mr66758646iok.52.1563826372789;
 Mon, 22 Jul 2019 13:12:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190722181945.244395-1-mka@chromium.org>
In-Reply-To: <20190722181945.244395-1-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 22 Jul 2019 13:12:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XP=3z9GWPU+K15jmzHeOWT9uzqgaC6zL3M+Wm7b4jOhQ@mail.gmail.com>
Message-ID: <CAD=FV=XP=3z9GWPU+K15jmzHeOWT9uzqgaC6zL3M+Wm7b4jOhQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: dw-hdmi: Refuse DDC/CI transfers on the
 internal I2C controller
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Adam Jackson <ajax@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 22, 2019 at 11:19 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> The DDC/CI protocol involves sending a multi-byte request to the
> display via I2C, which is typically followed by a multi-byte
> response. The internal I2C controller only allows single byte
> reads/writes or reads of 8 sequential bytes, hence DDC/CI is not
> supported when the internal I2C controller is used. The I2C
> transfers complete without errors, however the data in the response
> is garbage. Abort transfers to/from slave address 0x37 (DDC) with
> -EOPNOTSUPP, to make it evident that the communication is failing.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v2:
> - changed DDC_I2C_ADDR to DDC_CI_ADDR
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 045b1b13fd0e..28933629f3c7 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -35,6 +35,7 @@
>
>  #include <media/cec-notifier.h>
>
> +#define DDC_CI_ADDR            0x37
>  #define DDC_SEGMENT_ADDR       0x30
>
>  #define HDMI_EDID_LEN          512
> @@ -322,6 +323,13 @@ static int dw_hdmi_i2c_xfer(struct i2c_adapter *adap,
>         u8 addr = msgs[0].addr;
>         int i, ret = 0;
>
> +       if (addr == DDC_CI_ADDR)
> +               /*
> +                * The internal I2C controller does not support the multi-byte
> +                * read and write operations needed for DDC/CI.
> +                */
> +               return -EOPNOTSUPP;
> +

In theory we could also solve this by detecting (in other parts of the
function) the bad multi-byte read/write operations.  That would maybe
be more generic (AKA it would more properly handle random userspace
tools fiddling with i2c-dev) but add complexity to the code.

...possibly a better long-term solution is to just totally stop
emulating a regular i2c adapter when the hardware just doesn't support
that.  In theory we could remove the "drm_get_edid()" call in
dw_hdmi_connector_get_modes() and replace it with a direct call to
drm_do_get_edid() if we're using the built-in adapter.  Possibly
"tda998x_drv.c" would be a good reference.  If we did that, we could
remove all the weird / hacky i2c code in this driver.


Since the bigger cleanup seems like a bit much to ask, I'm OK with
this as a stopgap to at least prevent userspace tools from getting
confused.  Thus:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
