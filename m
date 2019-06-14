Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFB5846536
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 18:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfFNQ5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 12:57:42 -0400
Received: from gloria.sntech.de ([185.11.138.130]:43354 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbfFNQ5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 12:57:42 -0400
Received: from we0305.dip.tu-dresden.de ([141.76.177.49] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hbpWE-0006XT-5C; Fri, 14 Jun 2019 18:57:38 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-clk@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org, mturquette@baylibre.com,
        sboyd@kernel.org, papadakospan@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] clk: rockchip: add a type from SGRF-controlled gate clocks
Date:   Fri, 14 Jun 2019 18:57:37 +0200
Message-ID: <2861779.VsSVQ8N6Tg@phil>
In-Reply-To: <20190606090934.4443-1-heiko@sntech.de>
References: <20190606090934.4443-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 6. Juni 2019, 11:09:33 CEST schrieb Heiko Stuebner:
> Some clk gates on Rockchip SoCs are part of the SGRF (secure general
> register files) and thus only controllable from secure mode, with the
> most prominent example being the watchdog.
> 
> In most cases we still want to define this as a real clock though,
> to have complete clock tree and not reference the generic base-clock
> from the devicetree.
> 
> So far we've just defined this as factor-1-1 clocks in the clock init,
> so define a special clock-type for it so that this definition can be
> part of the general tree-definition and save some boilerplate code.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

applied both for 5.3


