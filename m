Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 155D9138D7A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jan 2020 10:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgAMJQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 04:16:02 -0500
Received: from gloria.sntech.de ([185.11.138.130]:53052 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbgAMJQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 04:16:02 -0500
Received: from wf0253.dip.tu-dresden.de ([141.76.180.253] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iqvpF-0001xO-Fh; Mon, 13 Jan 2020 10:15:57 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: fix dwmmc clock name for px30 and rk3308
Date:   Mon, 13 Jan 2020 10:15:56 +0100
Message-ID: <3203839.F8si9oFvou@phil>
In-Reply-To: <20200110161200.22755-1-jbx6244@gmail.com>
References: <20200110161200.22755-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

Am Freitag, 10. Januar 2020, 17:12:00 CET schrieb Johan Jonker:
> An experimental test with the command below gives this error:
> px30-evb.dt.yaml: dwmmc@ff390000: clock-names:2:
> 'ciu-drive' was expected
> rk3308-evb.dt.yaml: dwmmc@ff480000: clock-names:2:
> 'ciu-drive' was expected
> 
> 'ciu-drv' is not a valid dwmmc clock name,
> so fix this by changing it to 'ciu-drive'.
> 
> make ARCH=arm64 dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

thanks for this fix, I've split it into two patches (px30 and rk3308) and
applied for 5.6

Thanks
Heiko



