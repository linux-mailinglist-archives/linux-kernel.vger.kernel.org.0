Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAF63174A56
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Mar 2020 01:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbgCAAEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Feb 2020 19:04:20 -0500
Received: from gloria.sntech.de ([185.11.138.130]:55512 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727222AbgCAAEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 19:04:20 -0500
Received: from p508fcd9d.dip0.t-ipconnect.de ([80.143.205.157] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1j8C5g-0004tr-Ls; Sun, 01 Mar 2020 01:04:16 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] arm64: dts: rockchip: fix compatible property for Radxa ROCK Pi N10
Date:   Sun, 01 Mar 2020 01:04:15 +0100
Message-ID: <2564015.4vhmofR5M8@phil>
In-Reply-To: <20200228061436.13506-4-jbx6244@gmail.com>
References: <20200228061436.13506-1-jbx6244@gmail.com> <20200228061436.13506-4-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 28. Februar 2020, 07:14:36 CET schrieb Johan Jonker:
> A test with the command below gives this error:
> 
> arch/arm64/boot/dts/rockchip/rk3399pro-rock-pi-n10.dt.yaml: /: compatible:
> ['radxa,rockpi-n10', 'rockchip,rk3399pro']
> is not valid under any of the given schemas
> 
> During the review process the binding was changed,
> but the dts file was somehow not updated.
> Fix this error by adding 'vamrs,rk3399pro-vmarc-som' to
> the compatible property.
> 
> make ARCH=arm64 dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/arm/rockchip.yaml
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

applied for 5.7

Thanks
Heiko


