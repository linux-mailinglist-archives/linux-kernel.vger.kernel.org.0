Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2175C107F0C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2019 16:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfKWPdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Nov 2019 10:33:54 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:55048 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfKWPdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 10:33:54 -0500
X-Greylist: delayed 370 seconds by postgrey-1.27 at vger.kernel.org; Sat, 23 Nov 2019 10:33:53 EST
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 82F112008B;
        Sat, 23 Nov 2019 16:28:23 +0100 (CET)
Date:   Sat, 23 Nov 2019 16:28:22 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: panel: Document Frida FRD350H54004 LCD
 panel
Message-ID: <20191123152822.GB27045@ravnborg.org>
References: <20191120171027.1102250-1-paul@crapouillou.net>
 <20191120171027.1102250-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120171027.1102250-2-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=eMA9ckh1 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=ER_8r6IbAAAA:8
        a=W2ngg1vp0vrSmQVp3HYA:9 a=CjuIK1q_8ugA:10 a=9LHmKk7ezEChjTCyhBa9:22
        a=pHzHmUro8NiASowvMSCR:22 a=6VlIyEUom7LUIeUMNQJH:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul.

On Wed, Nov 20, 2019 at 06:10:26PM +0100, Paul Cercueil wrote:
> Add bindings documentation for the Frida 3.5" (320x240 pixels) 24-bit
> TFT LCD panel.

New bindings using the meta-schema (.yaml) syntax please.

	Sam
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  .../bindings/display/panel/frida,frd350h54004.txt    | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/frida,frd350h54004.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/frida,frd350h54004.txt b/Documentation/devicetree/bindings/display/panel/frida,frd350h54004.txt
> new file mode 100644
> index 000000000000..8428f8b05b93
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/frida,frd350h54004.txt
> @@ -0,0 +1,12 @@
> +Frida 3.5" (320x240 pixels) 24-bit TFT LCD panel
> +
> +Required properties:
> +- compatible: should be "frida,frd350h54004"
> +- power-supply: as specified in the base binding
> +
> +Optional properties:
> +- backlight: as specified in the base binding
> +- enable-gpios: as specified in the base binding
> +
> +This binding is compatible with the simple-panel binding, which is specified
> +in simple-panel.txt in this directory.
> -- 
> 2.24.0
