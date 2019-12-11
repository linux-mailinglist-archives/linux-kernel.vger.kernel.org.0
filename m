Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCBC11A48D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 07:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbfLKGe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 01:34:29 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:45773 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbfLKGe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 01:34:29 -0500
Received: by mail-il1-f196.google.com with SMTP id p8so18419394iln.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 22:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LnlhPhwrwhKWR1phS0Nm+X1oLAnw1Q6Ps2LzFwtjOXA=;
        b=iWKx872KPmJDhgFcf5COT7Op+IIuz8zU4qTC/GkfEPj+L4ny0kYCXvXcvnrF7slFtO
         tRTq8JfxBf+FgO4ZsVHcARsFtCGen0274loCE2qfu2jt8RQaJf4pniitusGBQ/Qk/+tW
         jxZRhZ6WiohSl8XkyFg4MVrs3mQIB4j7FmLHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LnlhPhwrwhKWR1phS0Nm+X1oLAnw1Q6Ps2LzFwtjOXA=;
        b=uCnNn3HwcFXXvsV22wQVa630FCf5oNmSX7UnXZggqV81mIzhrKPDYdrXqberFrqG1s
         aIPbqXbhIgsU3JE30u72srZV7tfLDYYH/jAknA4KChog9Rq0wqQPbJ20perc6MGhZq79
         NbFDO9ExjyZIRtvcrNyNArI3kfivsMJPIV2Xdd2MlFQpRDbMuYWZ+oWjssk5muDms2Fc
         AelEjLALcepGe6gut+qpabmAq8REraz98bgU3ADG/HEs/FghzRX3UGzUUFcrb5g6ofPo
         WeXBG5v8kH3tDkUmTPQ30v6v7fF9nE7qlnduDQ2i6UR/BXLGlN2Ln+pdkL/Kca1elnyK
         w1Qg==
X-Gm-Message-State: APjAAAV6AbMHQ82qJUBExJLQYf+e7Gtmb7Ai0uzYTeHodIcv9qc6rJQz
        wva83+uKYOQu5LUH43rMw6naLGm0lZh9iMRxhpW93A==
X-Google-Smtp-Source: APXvYqwyDUXZr0DPSegpq3sAtZxRx7aKRikChcC82VUiHoKa26vAu7iCTYDvSPxVVC1O1YVH3pzvAaJlwxGQZUvjaFU=
X-Received: by 2002:a92:d610:: with SMTP id w16mr1456477ilm.283.1576046068601;
 Tue, 10 Dec 2019 22:34:28 -0800 (PST)
MIME-Version: 1.0
References: <20191209145016.227784-1-hsinyi@chromium.org> <20191209145016.227784-4-hsinyi@chromium.org>
 <20191209145552.GD12841@pendragon.ideasonboard.com> <CAJMQK-hNSF-Vu4CfTKiCUdBRmaONf=Lp3NN0-nFor6mxY1seJg@mail.gmail.com>
 <20191209153238.GE12841@pendragon.ideasonboard.com>
In-Reply-To: <20191209153238.GE12841@pendragon.ideasonboard.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Wed, 11 Dec 2019 14:34:02 +0800
Message-ID: <CAJMQK-hMYodXFDWTGAXTOOG9A=12M7vvYooXA8yaD9L--G1qog@mail.gmail.com>
Subject: Re: [PATCH RESEND 3/4] dt-bindings: drm/bridge: analogix-anx78xx:
 support bypass GPIO
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Archit Taneja <architt@codeaurora.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 9, 2019 at 11:32 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
Hi Laurent,
> You may have used a proportional font when writing this, the | doesn't
> align with anything using a fixed font. Do I assume correctly that the
> hardware multiplexer is actually a demultiplexer with one input and two
> outputs ?
>                                      +-----------+
> +---------+         +------+    /--> | HDMI      |
> | MT8173  |  HDMI   |   -->| --/     | Connector |
> |  HDMI   | ------> |--/   |         +-----------+
> | Encoder |         |    ->| --\     +-----------+      +-----------+
> +---------+         +------+    \--> | ANX7688   | ---> | USB-C     |
>                                      | Bridge    |      | Connector |
>                                      +-----------+      +-----------+
>
Sorry for not noticing the font issue, this graph is correct.

> > There's a hardware mux that takes mt8173 hdmi as input and has 2
> > output port: native hdmi and anx7688 bridge.
> > If gpio is active, we would like it to go to HDMI.
> >
> > Previous approach is to make hardware mux a generic gpio mux bridge,
> > but this is probably a very rare use case that is only for
> > mt8173.(https://lore.kernel.org/lkml/57723AD2.8020806@codeaurora.org/)
> > We merge the mux and anx7688 to a single bridge and leave this as an
> > optional feature in this time.
>
> I think that's a better approach, at least at the DT level. The HDMI
> demultiplexer should be represented as a DT node with 3 ports (one input
> and two outputs) with a control GPIO.
>
I've resend the original gpio mux driver. So for anx7688 there's 1
input and 1 output.

Thanks
