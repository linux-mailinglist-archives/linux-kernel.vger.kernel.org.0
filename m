Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC05C1569B2
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Feb 2020 09:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbgBIIgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Feb 2020 03:36:42 -0500
Received: from smtprelay0132.hostedemail.com ([216.40.44.132]:50727 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725856AbgBIIgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 03:36:42 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 9E428182CED2A;
        Sun,  9 Feb 2020 08:36:40 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:2:41:355:379:599:800:857:960:966:967:973:982:988:989:1260:1263:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1535:1593:1594:1605:1606:1730:1747:1777:1792:2196:2198:2199:2200:2393:2525:2553:2566:2682:2685:2828:2859:2892:2902:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3167:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4117:4250:4321:4385:4605:5007:6117:6119:7556:7576:7875:7903:8599:8603:9025:9388:9545:10004:10049:10848:10967:11026:11232:11233:11473:11657:11658:11914:12043:12295:12297:12438:12555:12679:12740:12760:12895:12986:13141:13230:13439:13845:14096:14097:14659:21060:21080:21433:21450:21451:21611:21627:21740:21773:21788:21811:21939:30034:30054:30070:30075:30080:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: grain87_3a29ca9f95620
X-Filterd-Recvd-Size: 6270
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Sun,  9 Feb 2020 08:36:39 +0000 (UTC)
Message-ID: <0d0c4ad9e15ce696ad4b470d724fb0d1423f26c0.camel@perches.com>
Subject: Re: checkpatch - "DT binding docs and includes should be a separate
 patch"
From:   Joe Perches <joe@perches.com>
To:     Sam Ravnborg <sam@ravnborg.org>, Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date:   Sun, 09 Feb 2020 00:35:26 -0800
In-Reply-To: <20200209081931.GA5321@ravnborg.org>
References: <20200209081931.GA5321@ravnborg.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-02-09 at 09:19 +0100, Sam Ravnborg wrote:
> Hi Joe.
> 
> The following warnings triggers on the patch below:
> 
> c55d0a554843 (HEAD -> drm-misc-next) dt-bindings: panel: Convert orisetech,otm8009a to json-schema
> -:15: WARNING:FILE_PATH_CHANGES: added, moved or deleted file(s), does MAINTAINERS need updating?
> #15:
> deleted file mode 100644
> 
> -:18: WARNING:DT_SPLIT_BINDING_PATCH: DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.txt
> 
> -:43: WARNING:DT_SPLIT_BINDING_PATCH: DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.txt
> 
> total: 0 errors, 3 warnings, 0 checks, 53 lines checked
> 
> 1)
> yaml files include maintainer information in the file.
> I dunno if this replaces/overrules MAINTAINERS - so first warning may be
> OK. Also because we delete a file it seems semi relevant.
> 
> 2)
> As the patch only touches files in Documentation/devicetree/bindings the
> warning about a separate patch seems wrong.

Rob Herring wrote that bit.  He's now cc'd.  lkml too.

> 
> But the general feedback - in this very special case - is that
> checkpatch seems a bit too noisy.
> 
> If we as a bonus could get a warning when new yaml files do not
> use:
> # SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> That would be great.

Submitted here:

https://lkml.org/lkml/2020/1/29/292

> It is recommended but not mandatory to use the combi license for new yaml
> files.
> 
> I did not try to dive into this myself - in the hope someone more versed
> in checkpatch internals (aka you) could improve it.
> 
> 	Sam
> 
> From c55d0a554843f2c4dfb44d0c8a99a1670c32c33d Mon Sep 17 00:00:00 2001
> From: Benjamin Gaignard <benjamin.gaignard@st.com>
> Date: Thu, 6 Feb 2020 14:33:44 +0100
> Subject: [PATCH 3/3] dt-bindings: panel: Convert orisetech,otm8009a to
>  json-schema
> 
> Convert orisetech,otm8009a to json-schema.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Philippe Cornu <philippe.cornu@st.com>
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Link: https://patchwork.freedesktop.org/patch/msgid/20200206133344.724-4-benjamin.gaignard@st.com
> ---
>  .../display/panel/orisetech,otm8009a.txt      | 23 --------
>  .../display/panel/orisetech,otm8009a.yaml     | 53 +++++++++++++++++++
>  2 files changed, 53 insertions(+), 23 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.txt
>  create mode 100644 Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.txt b/Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.txt
> deleted file mode 100644
> index 203b03eefb68..000000000000
> --- a/Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.txt
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -Orise Tech OTM8009A 3.97" 480x800 TFT LCD panel (MIPI-DSI video mode)
> -
> -The Orise Tech OTM8009A is a 3.97" 480x800 TFT LCD panel connected using
> -a MIPI-DSI video interface. Its backlight is managed through the DSI link.
> -
> -Required properties:
> -  - compatible: "orisetech,otm8009a"
> -  - reg: the virtual channel number of a DSI peripheral
> -
> -Optional properties:
> -  - reset-gpios: a GPIO spec for the reset pin (active low).
> -  - power-supply: phandle of the regulator that provides the supply voltage.
> -
> -Example:
> -&dsi {
> -	...
> -	panel@0 {
> -		compatible = "orisetech,otm8009a";
> -		reg = <0>;
> -		reset-gpios = <&gpioh 7 GPIO_ACTIVE_LOW>;
> -		power-supply = <&v1v8>;
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.yaml b/Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.yaml
> new file mode 100644
> index 000000000000..6e6ac995c27b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/orisetech,otm8009a.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Orise Tech OTM8009A 3.97" 480x800 TFT LCD panel (MIPI-DSI video mode)
> +
> +maintainers:
> +  - Philippe CORNU <philippe.cornu@st.com>
> +
> +description: |
> +             The Orise Tech OTM8009A is a 3.97" 480x800 TFT LCD panel connected using
> +             a MIPI-DSI video interface. Its backlight is managed through the DSI link.
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +
> +  compatible:
> +    const: orisetech,otm8009a
> +
> +  reg:
> +    maxItems: 1
> +    description: DSI virtual channel
> +
> +  enable-gpios: true
> +  port: true
> +  power-supply: true
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    dsi@0 {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      panel@0 {
> +        compatible = "orisetech,otm8009a";
> +        reg = <0>;
> +        reset-gpios = <&gpiof 15 0>;
> +        power-supply = <&v1v8>;
> +      };
> +    };
> +...
> +

