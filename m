Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE6018143F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 10:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbgCKJLt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 11 Mar 2020 05:11:49 -0400
Received: from gloria.sntech.de ([185.11.138.130]:38104 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbgCKJLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 05:11:49 -0400
Received: from p5b127c69.dip0.t-ipconnect.de ([91.18.124.105] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1jBxOz-0000b0-QO; Wed, 11 Mar 2020 10:11:45 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: remove rockchip,grf from vop nodes for px30
Date:   Wed, 11 Mar 2020 10:11:45 +0100
Message-ID: <3610438.YMqP0VFAyP@phil>
In-Reply-To: <20200309081600.3887-1-jbx6244@gmail.com>
References: <20200309081600.3887-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 9. März 2020, 09:16:00 CET schrieb Johan Jonker:
> An experimental test with the command below without
> additional properties in 'rockchip-vop.yaml' gives this error:
> 
> arch/arm64/boot/dts/rockchip/px30-evb.dt.yaml: vop@ff470000:
> 'power-domains', 'rockchip,grf'
> do not match any of the regexes: 'pinctrl-[0-9]+'
> arch/arm64/boot/dts/rockchip/px30-evb.dt.yaml: vop@ff460000:
> 'power-domains', 'rockchip,grf'
> do not match any of the regexes: 'pinctrl-[0-9]+'
> 
> 'rockchip,grf' is not used by the Rockchip VOP driver,
> so remove it from 'vop' nodes in 'px30.dtsi'.
> 
> make ARCH=arm64 dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/display/
> rockchip/rockchip-vop.yaml
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

applied for 5.7

Thanks
Heiko


