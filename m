Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADDA187714
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 01:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733193AbgCQAwH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 16 Mar 2020 20:52:07 -0400
Received: from gloria.sntech.de ([185.11.138.130]:51908 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733152AbgCQAwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 20:52:06 -0400
Received: from ip5f5a5d2f.dynamic.kabel-deutschland.de ([95.90.93.47] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1jE0Sh-0004VF-6h; Tue, 17 Mar 2020 01:52:03 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: remove properties from spdif node RK3399 Excavator
Date:   Tue, 17 Mar 2020 01:52:02 +0100
Message-ID: <18213991.ifHWx50xby@phil>
In-Reply-To: <20200312172240.21362-1-jbx6244@gmail.com>
References: <20200312172240.21362-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 12. M�rz 2020, 18:22:39 CET schrieb Johan Jonker:
> An expermental test with the command below gives this error:
> 
> arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dt.yaml:
> spdif@ff870000:
> 'i2c-scl-falling-time-ns', 'i2c-scl-rising-time-ns', 'power-domains'
> do not match any of the regexes: 'pinctrl-[0-9]+'
> 
> 'i2c-scl-falling-time-ns', 'i2c-scl-rising-time-ns'
> are not valid properties for 'spdif' nodes, so remove them.
> 
> make ARCH=arm64 dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/sound/rockchip-spdif.yaml
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

applied for 5.7

Thanks
Heiko


