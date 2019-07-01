Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFFB45C1B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 14:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbfFNME7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 08:04:59 -0400
Received: from gloria.sntech.de ([185.11.138.130]:40006 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727690AbfFNME6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 08:04:58 -0400
Received: from we0305.dip.tu-dresden.de ([141.76.177.49] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hbkwr-0004uz-7x; Fri, 14 Jun 2019 14:04:49 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Justin Swartz <justin.swartz@risingedge.co.za>
Cc:     Sandy Huang <hjc@rock-chips.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/rockchip: dw_hdmi: add basic rk3228 support
Date:   Fri, 14 Jun 2019 14:04:48 +0200
Message-ID: <1679832.6k0ngRgKtg@phil>
In-Reply-To: <20190522224631.25164-1-justin.swartz@risingedge.co.za>
References: <20190522224631.25164-1-justin.swartz@risingedge.co.za>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 23. Mai 2019, 00:46:29 CEST schrieb Justin Swartz:
> Like the RK3328, RK322x SoCs offer a Synopsis DesignWare HDMI transmitter
> and an Innosilicon HDMI PHY.
> 
> Add a new dw_hdmi_plat_data struct, rk3228_hdmi_drv_data.
> Assign a set of mostly generic rk3228_hdmi_phy_ops functions.
> Add dw_hdmi_rk3228_setup_hpd() to enable the HDMI HPD and DDC lines.
> 
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>

applied to drm-misc-next

Thanks
Heiko


