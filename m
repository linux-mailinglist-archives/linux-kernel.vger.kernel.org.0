Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC84D181415
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 10:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbgCKJIC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 11 Mar 2020 05:08:02 -0400
Received: from gloria.sntech.de ([185.11.138.130]:37994 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbgCKJIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 05:08:01 -0400
Received: from p5b127c69.dip0.t-ipconnect.de ([91.18.124.105] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1jBxLH-0000Xw-Dr; Wed, 11 Mar 2020 10:07:55 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/5] ARM: dts: rockchip: fix vqmmc-supply property name for rk3188-bqedison2qc
Date:   Wed, 11 Mar 2020 10:07:54 +0100
Message-ID: <37714750.JZCpAI0Cju@phil>
In-Reply-To: <20200307134841.13803-1-jbx6244@gmail.com>
References: <20200307134841.13803-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 7. M�rz 2020, 14:48:37 CET schrieb Johan Jonker:
> A test with the command below does not detect all errors
> in combination with 'additionalProperties: false' and
> allOf:
>   - $ref: "synopsys-dw-mshc-common.yaml#"
> allOf:
>   - $ref: "mmc-controller.yaml#"
> 
> 'additionalProperties' applies to all properties that are not
> accounted-for by 'properties' or 'patternProperties' in
> the immediate schema.
> 
> First when we combine rockchip-dw-mshc.yaml,
> synopsys-dw-mshc-common.yaml and mmc-controller.yaml it gives
> this error:
> 
> arch/arm/boot/dts/rk3188-bqedison2qc.dt.yaml: mmc@10218000:
> 'vmmcq-supply' does not match any of the regexes:
> '^.*@[0-9]+$',
> '^clk-phase-(legacy|sd-hs|mmc-(hs|hs[24]00|ddr52)|
> uhs-(sdr(12|25|50|104)|ddr50))$',
> 'pinctrl-[0-9]+'
> 
> 'vmmcq-supply' is not a valid property name for mmc nodes.
> Fix this error by renaming it to 'vqmmc-supply'.
> 
> make ARCH=arm dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

applied all 5 for 5.7

Thanks
Heiko


