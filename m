Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E31C41029C4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2019 17:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbfKSQu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 11:50:28 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:44537 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728563AbfKSQu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 11:50:27 -0500
Received: by mail-io1-f66.google.com with SMTP id j20so12934368ioo.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 08:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gJZxSWnOG8Gs2dy+Q5ughCz+Da0hQ1yJBJ+RDGbHpkw=;
        b=nDDU/6xBhkkZKiUVL5Ocxj7cHCsYU4c0MefmZkqPYH0eKRB2JYB2UZt217GSyNryga
         i0HmYl3s5H1A1Q62MU6oqERAk5Fn4PH/oL86+g4t4+AlS+MaRN/h6GJfSTST69GkI0G4
         W5eu6cHoHNLVEfYFYA4fFqOuBbWxy2p78Vonc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gJZxSWnOG8Gs2dy+Q5ughCz+Da0hQ1yJBJ+RDGbHpkw=;
        b=CDcNCRfOudyeEJG/JZEmx5Vi88Y9ooVLUdfFqA47A+NsnnzAWCEfJyNactEAS30YlT
         Kq9WV4zZLhelYM8Nn+BjOsKXI3J2+qChrDLeRCzzNWjSUT0oZJWVbiFRblaYXW3WHBZv
         U+FJZYmIQfgJCcq2Sp/0SqToh7mn2Y3ZYEceWhmtrJ0NTZTej0Zs2NVH02PEMpRbj5X1
         F1MirD99qSaMuICmBgKmHCLSFYe8SOrPczA5jgXVNsTt2JIozT2UMx55V50V2oo4UVXM
         JPkQyT20pAkuS8apF/7NrcNPsReyN/MKJZ7x4RUaWgQ9yGB+2uZN6LHbCFjixhFYVatL
         XtsQ==
X-Gm-Message-State: APjAAAUgC04ngYwPY44ZhrNLfx/Y6KcjSQ4tuj1DqlYss+YrIOIcb1HF
        0Ra6zD+vgDZ8iscg2WbkPQGhSn7OUKk=
X-Google-Smtp-Source: APXvYqxaS5SBufRZl9nD2rWCtYd3FI0l9TiCp9geFPt+e92aL1NxGp4gf4kNk1U122dBMB8TjxZldw==
X-Received: by 2002:a5d:8195:: with SMTP id u21mr19166551ion.178.1574182226356;
        Tue, 19 Nov 2019 08:50:26 -0800 (PST)
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com. [209.85.166.178])
        by smtp.gmail.com with ESMTPSA id h16sm1760023iog.27.2019.11.19.08.50.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2019 08:50:25 -0800 (PST)
Received: by mail-il1-f178.google.com with SMTP id p6so20315766ilp.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 08:50:24 -0800 (PST)
X-Received: by 2002:a92:ca8d:: with SMTP id t13mr21900377ilo.58.1574182224501;
 Tue, 19 Nov 2019 08:50:24 -0800 (PST)
MIME-Version: 1.0
References: <20191118192123.82430-1-abhishekpandit@chromium.org>
 <20191118110335.v6.3.I18b06235e381accea1c73aa2f9db358645d9f201@changeid> <079C85BE-FBC5-4A2B-9EBF-0CEDB6F30C18@holtmann.org>
In-Reply-To: <079C85BE-FBC5-4A2B-9EBF-0CEDB6F30C18@holtmann.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 19 Nov 2019 08:50:11 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U4qOyLWTg3w-AfF3o_0VBTxanpaa6of70viL2v9g3Xgg@mail.gmail.com>
Message-ID: <CAD=FV=U4qOyLWTg3w-AfF3o_0VBTxanpaa6of70viL2v9g3Xgg@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] dt-bindings: net: broadcom-bluetooth: Add pcm config
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-bluetooth@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ondrej Jirman <megous@megous.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 18, 2019 at 9:39 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Abhishek,
>
> > Add documentation for pcm parameters.
> >
> > Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > ---
> >
> > Changes in v6: None
> > Changes in v5: None
> > Changes in v4: None
> > Changes in v3: None
> > Changes in v2: None
> >
> > .../bindings/net/broadcom-bluetooth.txt       | 16 ++++++++++
> > include/dt-bindings/bluetooth/brcm.h          | 32 +++++++++++++++++++
> > 2 files changed, 48 insertions(+)
> > create mode 100644 include/dt-bindings/bluetooth/brcm.h
> >
> > diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
> > index c749dc297624..8561e4684378 100644
> > --- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
> > +++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
> > @@ -29,10 +29,20 @@ Optional properties:
> >    - "lpo": external low power 32.768 kHz clock
> >  - vbat-supply: phandle to regulator supply for VBAT
> >  - vddio-supply: phandle to regulator supply for VDDIO
> > + - brcm,bt-sco-routing: PCM, Transport, Codec, I2S
> > + - brcm,bt-pcm-interface-rate: 128KBps, 256KBps, 512KBps, 1024KBps, 2048KBps
> > + - brcm,bt-pcm-frame-type: short, long
> > + - brcm,bt-pcm-sync-mode: slave, master
> > + - brcm,bt-pcm-clock-mode: slave, master
> >
> > +See include/dt-bindings/bluetooth/brcm.h for SCO/PCM parameters. The default
> > +value for all these values are 0 (except for brcm,bt-sco-routing which requires
> > +a value) if you choose to leave it out.
> >
> > Example:
> >
> > +#include <dt-bindings/bluetooth/brcm.h>
> > +
> > &uart2 {
> >        pinctrl-names = "default";
> >        pinctrl-0 = <&uart2_pins>;
> > @@ -40,5 +50,11 @@ Example:
> >        bluetooth {
> >                compatible = "brcm,bcm43438-bt";
> >                max-speed = <921600>;
> > +
> > +               brcm,bt-sco-routing        = <BRCM_SCO_ROUTING_TRANSPORT>;
>
> in case you use transport which means HCI, you would not have values below. It is rather PCM here in the example.
>
> > +               brcm,bt-pcm-interface-rate = <BRCM_PCM_IF_RATE_512KBPS>;
> > +               brcm,bt-pcm-frame-type     = <BRCM_PCM_FRAME_TYPE_SHORT>;
> > +               brcm,bt-pcm-sync-mode      = <BRCM_PCM_SYNC_MODE_MASTER>;
> > +               brcm,bt-pcm-clock-mode     = <BRCM_PCM_CLOCK_MODE_MASTER>;
> >        };
> > };
>
> And I am asking this again. Is this adding any value to use an extra include file? Inside the driver we are not really needing these values since they are handed to the hardware.

Personally I find that they add value in that it makes it easier for
someone tweaking the device tree to know what the expected valid
values are and what they mean.  I think Matthias also found value in
them since he suggested them in:

https://lore.kernel.org/r/20191114175836.GI27773@google.com

There, he said:

> I'd suggest to define constants in include/dt-bindings/bluetooth/brcm.h
> and use them instead of literals, with this we wouldn't rely on (optional)
> comments to make the configuration human readable.

...which seems to make sense to me.

-Doug
