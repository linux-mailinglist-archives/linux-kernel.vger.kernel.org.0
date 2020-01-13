Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CABF9138DAF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jan 2020 10:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgAMJYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 04:24:06 -0500
Received: from gloria.sntech.de ([185.11.138.130]:53146 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbgAMJYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 04:24:05 -0500
Received: from wf0253.dip.tu-dresden.de ([141.76.180.253] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iqvx3-0001zw-Vv; Mon, 13 Jan 2020 10:24:02 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: add reg property to brcmf sub node
Date:   Mon, 13 Jan 2020 10:24:01 +0100
Message-ID: <1821445.7jhtsCTu8y@phil>
In-Reply-To: <20200110142128.13522-1-jbx6244@gmail.com>
References: <20200110142128.13522-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 10. Januar 2020, 15:21:28 CET schrieb Johan Jonker:
> An experimental test with the command below gives this error:
> rk3399-firefly.dt.yaml: dwmmc@fe310000: wifi@1:
> 'reg' is a required property
> rk3399-orangepi.dt.yaml: dwmmc@fe310000: wifi@1:
> 'reg' is a required property
> rk3399-khadas-edge.dt.yaml: dwmmc@fe310000: wifi@1:
> 'reg' is a required property
> rk3399-khadas-edge-captain.dt.yaml: dwmmc@fe310000: wifi@1:
> 'reg' is a required property
> rk3399-khadas-edge-v.dt.yaml: dwmmc@fe310000: wifi@1:
> 'reg' is a required property
> So fix this by adding a reg property to the brcmf sub node.
> Also add #address-cells and #size-cells to prevent more warnings.
> 
> make ARCH=arm64 dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

applied for 5.6

Thanks
Heiko


