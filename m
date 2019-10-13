Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7809D586F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2019 23:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbfJMV6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Oct 2019 17:58:37 -0400
Received: from gloria.sntech.de ([185.11.138.130]:50620 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727492AbfJMV6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 17:58:37 -0400
Received: from i59f7e0c5.versanet.de ([89.247.224.197] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iJlsm-0004vN-BX; Sun, 13 Oct 2019 23:58:32 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Sandy Huang <hjc@rock-chips.com>,
        Zheng Yang <zhengyang@rock-chips.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, Johan Jonker <jbx6244@gmail.com>
Subject: Re: [PATCH] drm/rockchip/rk3066: Use devm_platform_ioremap_resource() in rk3066_hdmi_bind()
Date:   Sun, 13 Oct 2019 23:58:26 +0200
Message-ID: <12988569.FbAFs2EWry@phil>
In-Reply-To: <0666bc0b-6624-21a0-47c4-b78e2a3b3ad5@web.de>
References: <0666bc0b-6624-21a0-47c4-b78e2a3b3ad5@web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 21. September 2019, 20:40:16 CEST schrieb Markus Elfring:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 21 Sep 2019 20:32:25 +0200
> 
> Simplify this function implementation by using a known wrapper function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

applied to drm-misc-next

Thanks
Heiko


