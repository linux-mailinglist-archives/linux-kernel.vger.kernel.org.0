Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6444412D9E0
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Dec 2019 16:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfLaPdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Dec 2019 10:33:52 -0500
Received: from gloria.sntech.de ([185.11.138.130]:55324 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfLaPdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 10:33:51 -0500
Received: from [185.109.153.2] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1imJWj-0004i6-Eg; Tue, 31 Dec 2019 16:33:45 +0100
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
Subject: Re: [PATCH v2 10/11] arm64: dts: rockchip: Add PX30 DSI DPHY
Date:   Tue, 31 Dec 2019 13:14:02 +0100
Message-ID: <10740878.zWD4iEhqxt@phil>
In-Reply-To: <1796464.bE5sXyoQCg@phil>
References: <20191224143900.23567-1-miquel.raynal@bootlin.com> <20191224143900.23567-11-miquel.raynal@bootlin.com> <1796464.bE5sXyoQCg@phil>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 31. Dezember 2019, 12:56:14 CET schrieb Heiko Stuebner:
> Am Dienstag, 24. Dezember 2019, 15:38:59 CET schrieb Miquel Raynal:
> > Add the PHY which outputs MIPI DSI and LVDS.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> 
> applied for 5.6 (picked early due to it being shared between lvds and dsi)

and I've just added the VO powerdomain to the dsi-dphy node.

While the TRM is not really forthcoming in telling me if the dphy needs
the power-domain as well, the vendor kernel does, so we should probably
just follow their example ;-) .


Heiko


