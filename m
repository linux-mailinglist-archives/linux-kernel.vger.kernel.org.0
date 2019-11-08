Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E034F5151
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 17:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbfKHQiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 11:38:23 -0500
Received: from gloria.sntech.de ([185.11.138.130]:33050 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbfKHQiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 11:38:23 -0500
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iT7H4-0002KZ-2x; Fri, 08 Nov 2019 17:38:14 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     linux-clk@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        finley.xiao@rock-chips.com, zhangqing@rock-chips.com,
        christoph.muellner@theobroma-systems.com
Subject: Re: [PATCH 1/5] clk: rockchip: Add div50 clock-ids for sdmmc on px30 and nandc
Date:   Fri, 08 Nov 2019 17:38:10 +0100
Message-ID: <4980410.dClP0N2Ixt@diego>
In-Reply-To: <20190917081903.25139-1-heiko@sntech.de>
References: <20190917081903.25139-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 17. September 2019, 10:18:59 CET schrieb Heiko Stuebner:
> From: Finley Xiao <finley.xiao@rock-chips.com>
> 
> EMMC and SDIO already have these clock-ids (still unused) only sdmmc is
> missing them, so fix that.
> 
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

applied all 5 for 5.5


