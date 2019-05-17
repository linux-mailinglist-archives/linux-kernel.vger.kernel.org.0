Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A89121709
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 12:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbfEQKhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 May 2019 06:37:54 -0400
Received: from gloria.sntech.de ([185.11.138.130]:60862 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727309AbfEQKhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 06:37:54 -0400
Received: from we0524.dip.tu-dresden.de ([141.76.178.12] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hRaFG-0001Rc-81; Fri, 17 May 2019 12:37:46 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: gpu: add #cooling-cells property to the ARM Mali Midgard GPU binding
Date:   Fri, 17 May 2019 12:37:45 +0200
Message-ID: <13349008.xMc91k09bk@phil>
In-Reply-To: <CAD=FV=UQcv1+HC2eAk2ctBofufCi9-VvWc+OnY0mtBw3L-YG+Q@mail.gmail.com>
References: <20190516172510.181473-1-mka@chromium.org> <CAD=FV=UQcv1+HC2eAk2ctBofufCi9-VvWc+OnY0mtBw3L-YG+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 16. Mai 2019, 19:40:38 CEST schrieb Doug Anderson:
> Hi,
> 
> On Thu, May 16, 2019 at 10:25 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> 
> > The GPU can be used as a thermal cooling device, add an optional
> > '#cooling-cells' property.
> >
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > Changes in v2:
> > - patch added to the series
> > ---
> >  Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
> > index 18a2cde2e5f3..61fd41a20f99 100644
> > --- a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
> > +++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
> > @@ -37,6 +37,8 @@ Optional properties:
> >  - operating-points-v2 : Refer to Documentation/devicetree/bindings/opp/opp.txt
> >    for details.
> >
> > +- #cooling-cells: Refer to Documentation/devicetree/bindings/thermal/thermal.txt
> > +  for details.
> >
> >  Example for a Mali-T760:
> >
> > @@ -51,6 +53,7 @@ gpu@ffa30000 {
> >         mali-supply = <&vdd_gpu>;
> >         operating-points-v2 = <&gpu_opp_table>;
> >         power-domains = <&power RK3288_PD_GPU>;
> > +       #cooling-cells = <2>;
> >  };
> 
> You will conflict with d5ff1adb3809 ("dt-bindings: gpu: mali-midgard:
> Add resets property"), but it's easy to rebase.  I'll leave it to
> whoever is going to land this to decide if they would like you to
> re-post or if they can handle resolving the conflict themselves.
> +Kevin who appears to be the one who landed the conflicting commit.

No problem, I can update this comment when applying
(likely to drm-misc to not create more conflicts),
but will give Rob a bit more time to possibly object :-)

[somewhere in the recent past, he said to not wait on him on the tiny
property-additions, and cooling-cells is pretty well used one at that]


> With that:
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>





