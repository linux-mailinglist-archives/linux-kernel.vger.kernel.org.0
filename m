Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF99F2CCFF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 19:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfE1RD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 13:03:59 -0400
Received: from mailoutvs53.siol.net ([185.57.226.244]:39936 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727222AbfE1RD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 13:03:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 9EE2F52258D;
        Tue, 28 May 2019 19:03:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id wq2yfM6iCzA8; Tue, 28 May 2019 19:03:55 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 5042F523805;
        Tue, 28 May 2019 19:03:55 +0200 (CEST)
Received: from jernej-laptop.localnet (cpe-86-58-52-202.static.triera.net [86.58.52.202])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id CE07C52258D;
        Tue, 28 May 2019 19:03:52 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Jonas Karlman <jonas@kwiboo.se>
Cc:     "a.hajda@samsung.com" <a.hajda@samsung.com>,
        "Laurent.pinchart@ideasonboard.com" 
        <Laurent.pinchart@ideasonboard.com>,
        "narmstrong@baylibre.com" <narmstrong@baylibre.com>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "zhengyang@rock-chips.com" <zhengyang@rock-chips.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "wens@csie.org" <wens@csie.org>,
        "hjc@rock-chips.com" <hjc@rock-chips.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] drm/bridge: dw-hdmi: Add support for HDR metadata
Date:   Tue, 28 May 2019 19:03:52 +0200
Message-ID: <2731176.DZk0TneY9u@jernej-laptop>
In-Reply-To: <VI1PR03MB420621617DDEAB3596700DE0AC1C0@VI1PR03MB4206.eurprd03.prod.outlook.com>
References: <VI1PR03MB420621617DDEAB3596700DE0AC1C0@VI1PR03MB4206.eurprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne nedelja, 26. maj 2019 ob 23:18:46 CEST je Jonas Karlman napisal(a):
> Add support for HDR metadata using the hdr_output_metadata connector
> property,  configure Dynamic Range and Mastering InfoFrame accordingly.
> 
> A drm_infoframe flag is added to dw_hdmi_plat_data that platform drivers
> can use to signal when Dynamic Range and Mastering infoframes is supported.
> This flag is needed because Amlogic GXBB and GXL report same DW-HDMI
> version, and only GXL support DRM InfoFrame.
> 
> The first patch add functionality to configure DRM InfoFrame based on the
> hdr_output_metadata connector property.
> 
> The remaining patches sets the drm_infoframe flag on some SoCs supporting
> Dynamic Range and Mastering InfoFrame.
> 
> Note that this was based on top of drm-misc-next and Neil Armstrong's
> "drm/meson: Add support for HDMI2.0 YUV420 4k60" series at [1]
> 
> [1] https://patchwork.freedesktop.org/series/58725/#rev2

For Allwinner H6:
Tested-by: Jernej Skrabec <jernej.skrabec@siol.net>

Thanks for working on this!

Best regards,
Jernej



