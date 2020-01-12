Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6005913853D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jan 2020 07:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732267AbgALGJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jan 2020 01:09:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:45198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732256AbgALGJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 01:09:14 -0500
Received: from T480 (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E69D72084D;
        Sun, 12 Jan 2020 06:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578809354;
        bh=Heu80LHCoPJcbS3RqgvNvmIR7Uh41kQ9EeMPtb6yrP0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JcubbLrL47hwtFgDulYq855+Bm5soO0vJ1tGx8/eBpAN5zNtpMbB0xuwVlFsCGSjw
         rnoj1JK4nZTheXAJ+O95le9bNr3zkuGNHvBL5C8fo5MBaJ0Hgsp8FiuG0BdB/1PJfl
         bTWeV151u59oNBiRdXhy2ke3SSdwRSTm+SWBest4=
Date:   Sun, 12 Jan 2020 14:09:00 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, catalin.marinas@arm.com,
        will@kernel.org, bjorn.andersson@linaro.org, olof@lixom.net,
        maxime@cerno.tech, leonard.crestez@nxp.com, dinguyen@kernel.org,
        marcin.juszkiewicz@linaro.org, ping.bai@nxp.com, abel.vesa@nxp.com,
        nsekhar@ti.com, t-kristo@ti.com, peng.fan@nxp.com,
        yuehaibing@huawei.com, aisheng.dong@nxp.com, sfr@canb.auug.org.au,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V3 1/4] clk: imx: gate4: Switch imx_clk_gate4_flags() to
 clk_hw based API
Message-ID: <20200112060859.GA27570@T480>
References: <1578448417-17760-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578448417-17760-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 09:53:34AM +0800, Anson Huang wrote:
> Switch the imx_clk_gate4_flags() function to clk_hw based API, rename
> accordingly and add a macro for clk based legacy. This allows us to
> move closer to a clear split between consumer and provider clk APIs.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied all, thanks.
