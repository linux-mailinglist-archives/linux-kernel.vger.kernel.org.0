Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3453DC15C3
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2019 16:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbfI2OYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Sep 2019 10:24:53 -0400
Received: from gloria.sntech.de ([185.11.138.130]:43476 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbfI2OYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 10:24:53 -0400
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iEa80-0008VQ-Bc; Sun, 29 Sep 2019 16:24:48 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     mka@chromium.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: rockchip: Add cpu id to rk3288 efuse node
Date:   Sun, 29 Sep 2019 16:24:47 +0200
Message-ID: <9574075.6R2mNjq6rT@phil>
In-Reply-To: <20190919142611.1.I309434f00a2a9be71e4437991fe08abc12f06e2e@changeid>
References: <20190919142611.1.I309434f00a2a9be71e4437991fe08abc12f06e2e@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 19. September 2019, 23:26:41 CEST schrieb Douglas Anderson:
> This just adds in another field of what's stored in the e-fuse on
> rk3288.  Though I can't personally promise that every rk3288 out there
> has the CPU ID stored in the eFuse at this location, there is some
> evidence that it is correct:
> - This matches what was in the Chrome OS 3.14 branch (see
>   EFUSE_CHIP_UID_OFFSET and EFUSE_CHIP_UID_LEN) for rk3288.
> - The upstream rk3399 dts file has this same data at the same offset
>   and with the same length, indiciating that this is likely common for
>   several modern Rockchip SoCs.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

applied for 5.5

Thanks
Heiko


