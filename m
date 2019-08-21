Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B805981D7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 19:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbfHURzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 13:55:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43878 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729508AbfHURzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 13:55:04 -0400
Received: by mail-wr1-f68.google.com with SMTP id y8so2864140wrn.10;
        Wed, 21 Aug 2019 10:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dcXFfpfF7Y1vSw3aVBKIoINByXS6ksD7OwWYj454PWY=;
        b=C9KV221Eocif3ZekpE++QYsPVzUwSukjZei79hd9cPiO+acWKnIJR3q5PDoG9GwF3D
         1a3b08fTOrahtAnpNIMfKzDqG03RtqJeEuHNGp6jr6uVefZp4ymQZfGJcy+rBO+nmiiY
         OucKl0Jl4nZxgFmU/I2t4VEJIGjVQhQS9vprDl6annqJRWKYqRiurxQuhCtYcNzzyfz0
         ePOkODMaJk5U2GXoY2T1Avpj7mjPPOPu91Ue7WDyfkp2LhA1rCMnjg9AKG5WFODN4coW
         HqZ9FuXYDZ5/vb+j2w4/FOPdpEzm/HJu8Gdh9PvZOe4XY/7lyR+/02/pka0f8KPZkgwQ
         Cq3g==
X-Gm-Message-State: APjAAAV7E8KU/sq3EOz1diAxAuB7Nipe5ceqMpx38OQVYv64MUk4mPpx
        jNw80Qu2uhRJNuD15hRC0+E=
X-Google-Smtp-Source: APXvYqzXpe8lKkcvUAGrZ3oVo70oJ142K2QzLV1sGyFExlTS0Degv28KaJGOvQor2VcwLb4RuY3/2g==
X-Received: by 2002:a5d:5183:: with SMTP id k3mr37435361wrv.270.1566410101601;
        Wed, 21 Aug 2019 10:55:01 -0700 (PDT)
Received: from kozik-lap ([194.230.147.11])
        by smtp.googlemail.com with ESMTPSA id 39sm72535478wrc.45.2019.08.21.10.55.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Aug 2019 10:55:00 -0700 (PDT)
Date:   Wed, 21 Aug 2019 19:54:58 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Schrempf Frieder <frieder.schrempf@kontron.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6 3/4] dt-bindings: arm: fsl: Add Kontron i.MX6UL N6310
 compatibles
Message-ID: <20190821175458.GA25168@kozik-lap>
References: <1566315318-30320-1-git-send-email-krzk@kernel.org>
 <1566315318-30320-3-git-send-email-krzk@kernel.org>
 <CAL_JsqJLSZ50tdFcdPFc2ifcDoFZFuw=SoKsunzjtAhZ-11fBg@mail.gmail.com>
 <CAJKOXPfkNcWw9sunwXGRz42jOL0cdRC-iiHLtWCYvo5oxCMwFQ@mail.gmail.com>
 <CAL_JsqKAH6n1sMoWOhfiHKxgREr-EN1tw0QtC1H8Fm=a7PNzOA@mail.gmail.com>
 <20190820202142.GA15866@kozik-lap>
 <CAL_JsqKBWB2FiVjYo9O7DPw1JYJvan7uRgbR0VBG=FfHDVYdZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL_JsqKBWB2FiVjYo9O7DPw1JYJvan7uRgbR0VBG=FfHDVYdZQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 03:27:39PM -0500, Rob Herring wrote:
> > I see. If I understand the schema correctly, this should look like:
> 
> Looks correct, but a couple of comments.
> 
> > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> > index 7294ac36f4c0..eb263d1ccf13 100644
> > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > @@ -161,6 +161,22 @@ properties:
> >          items:
> >            - enum:
> >                - fsl,imx6ul-14x14-evk      # i.MX6 UltraLite 14x14 EVK Board
> > +              - kontron,imx6ul-n6310-som  # Kontron N6310 SOM
> 
> Is the SOM ever used alone? If not, then no point in listing this here.

SoM alone: no, because it requires some type of base board. However it
will be used by some customer designs with some amount of
changes/addons.

Looking at other aproaches, usually SoMs have their own compatible.  In
such case - I should document it somewhere.

> 
> > +          - const: fsl,imx6ul
> > +
> > +      - description: Kontron N6310 S Board
> > +        items:
> > +          - enum:
> > +              - kontron,imx6ul-n6310-s
> 
> This could be a 'const' instead. It depends if you think there will
> ever be more than one entry.

Indeed, I'll make this and entry below for S 43 board const.


Best regards,
Krzysztof

