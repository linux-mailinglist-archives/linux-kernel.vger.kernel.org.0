Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E573E559CC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 23:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfFYVSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 17:18:52 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:47734 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbfFYVSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 17:18:52 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id E935B8032D;
        Tue, 25 Jun 2019 23:18:46 +0200 (CEST)
Date:   Tue, 25 Jun 2019 23:18:45 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Purism Kernel Team <kernel@puri.sm>
Subject: Re: [PATCH 3/4] dt-bindings: display/panel: jh057n0090: Document
 power supply properties
Message-ID: <20190625211845.GA20625@ravnborg.org>
References: <cover.1561482165.git.agx@sigxcpu.org>
 <5ebbc0cf3fc8fcfd0300fb4d81be5acae156a4d4.1561482165.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ebbc0cf3fc8fcfd0300fb4d81be5acae156a4d4.1561482165.git.agx@sigxcpu.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=8nJEP1OIZ-IA:10 a=7gkXJVJtAAAA:8
        a=ze386MxoAAAA:8 a=awSIf4GHbRsm4FXq22sA:9 a=wPNLvfGTeEIA:10
        a=E9Po1WZjFZOl8hwRPBS3:22 a=iBZjaW-pnkserzjvUTHh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 07:05:18PM +0200, Guido Günther wrote:
> Document the vcc-supply and iovcc-supply propertes of the Rocktech
> jh057n0090 panel.
s/propertes/properties
s/jh057n0090/jh057n00900

With these fixed:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---
>  .../bindings/display/panel/rocktech,jh057n00900.txt          | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt b/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt
> index 1b5763200cf6..a372c5d84695 100644
> --- a/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt
> +++ b/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt
> @@ -5,6 +5,9 @@ Required properties:
>  - reg: DSI virtual channel of the peripheral
>  - reset-gpios: panel reset gpio
>  - backlight: phandle of the backlight device attached to the panel
> +- vcc-supply: phandle of the regulator that provides the vcc supply voltage.
> +- iovcc-supply: phandle of the regulator that provides the iovcc supply
> +  voltage.
>  
>  Example:
>  
> @@ -14,5 +17,7 @@ Example:
>  			reg = <0>;
>  			backlight = <&backlight>;
>  			reset-gpios = <&gpio3 13 GPIO_ACTIVE_LOW>;
> +			vcc-supply = <&reg_2v8_p>;
> +			iovcc-supply = <&reg_1v8_p>;
>  		};
>  	};
> -- 
> 2.20.1
