Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84374CC3E3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 22:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731166AbfJDUFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 16:05:04 -0400
Received: from gloria.sntech.de ([185.11.138.130]:37456 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727978AbfJDUFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 16:05:04 -0400
Received: from 94.112.246.102.static.b2b.upcbusiness.cz ([94.112.246.102] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iGTp0-0006VL-8Z; Fri, 04 Oct 2019 22:05:02 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Soeren Moch <smoch@web.de>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: rockchip: fix RockPro64 sdhci settings
Date:   Fri, 04 Oct 2019 22:05:01 +0200
Message-ID: <1725946.B0GZWAYfbM@phil>
In-Reply-To: <20191003215036.15023-2-smoch@web.de>
References: <20191003215036.15023-1-smoch@web.de> <20191003215036.15023-2-smoch@web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 3. Oktober 2019, 23:50:35 CEST schrieb Soeren Moch:
> The RockPro64 schematics [1], [2] show that the rk3399 EMMC_STRB pin is
> connected to the RESET pin instead of the DATA_STROBE pin of the eMMC module.
> So the data strobe cannot be used for its intended purpose on this board,
> and so the HS400 eMMC mode is not functional. Limit the controller to HS200.
> 
> [1] http://files.pine64.org/doc/rockpro64/rockpro64_v21-SCH.pdf
> [2] http://files.pine64.org/doc/rock64/PINE64_eMMC_Module_20170719.pdf
> 
> Fixes: e4f3fb490967 ("arm64: dts: rockchip: add initial dts support for Rockpro64")
> Signed-off-by: Soeren Moch <smoch@web.de>

applied as fix for 5.4

Thanks
Heiko




