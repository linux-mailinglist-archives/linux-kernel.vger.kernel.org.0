Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14E4626006
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 11:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbfEVJCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 05:02:23 -0400
Received: from gloria.sntech.de ([185.11.138.130]:43766 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727946AbfEVJCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 05:02:23 -0400
Received: from we0524.dip.tu-dresden.de ([141.76.178.12] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hTN8Z-0008FU-O8; Wed, 22 May 2019 11:02:15 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 2/3] ARM: dts: rockchip: Add #cooling-cells entry for rk3288 GPU
Date:   Wed, 22 May 2019 11:02:14 +0200
Message-ID: <23265091.NWmblD6evz@phil>
In-Reply-To: <20190516172510.181473-2-mka@chromium.org>
References: <20190516172510.181473-1-mka@chromium.org> <20190516172510.181473-2-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 16. Mai 2019, 19:25:09 CEST schrieb Matthias Kaehlcke:
> The Mali GPU of the rk3288 can be used as cooling device, add
> a #cooling-cells entry for it.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

applied patches 2+3 for 5.3

Thanks
Heiko


