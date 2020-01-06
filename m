Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD4F131197
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 12:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgAFLuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 06:50:35 -0500
Received: from gloria.sntech.de ([185.11.138.130]:50416 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgAFLue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 06:50:34 -0500
Received: from ip5f5a5f74.dynamic.kabel-deutschland.de ([95.90.95.116] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1ioQtw-0004hK-5T; Mon, 06 Jan 2020 12:50:28 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Sandy Huang <hjc@rock-chips.com>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 11/11] arm64: dts: rockchip: Add PX30 LVDS
Date:   Mon, 06 Jan 2020 12:50:27 +0100
Message-ID: <2384472.TJ9hiSgVgr@phil>
In-Reply-To: <20191224143900.23567-12-miquel.raynal@bootlin.com>
References: <20191224143900.23567-1-miquel.raynal@bootlin.com> <20191224143900.23567-12-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 24. Dezember 2019, 15:39:00 CET schrieb Miquel Raynal:
> Describe LVDS IP. Add the CRTC and LVDS relevant endpoints so they can
> be linked together.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

> +
> +			vopb_out_lvds: endpoint@0 {
> +				reg = <0>;
> +				remote-endpoint = <&lvds_vopb_in>;
> +			};

> +
> +			vopl_out_lvds: endpoint@0 {
> +				reg = <0>;
> +				remote-endpoint = <&lvds_vopl_in>;
> +			};

applied for 5.6, with the endpoints becoming @1 after the dsi

Thanks
Heiko


