Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E31A96F7ED
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 05:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfGVDZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jul 2019 23:25:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:34696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727860AbfGVDZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 23:25:09 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52F6721921;
        Mon, 22 Jul 2019 03:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563765908;
        bh=OuaSMyJ31uzehvilbNtzHBL2+HlRaa400vG7NlP8qIA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gwMTXrZSxokCdVtYuEJue+C7vgSZRNLf9rreY8p7Za0B8QNrzynY3cO7taVJTFZs0
         tGTlH60d28O0DeEM8Wm5vMvTqlSFqaJeXYOCzEdzF/uhvTEzJUpbZLxznp2ZVe/qUY
         cG+sDYZUj4BSiTRGNlv995NBbvkfLRz3YAB5qgG0=
Date:   Mon, 22 Jul 2019 11:24:42 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com, aisheng.dong@nxp.com,
        weiyongjun1@huawei.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, shengjiu.wang@nxp.com
Subject: Re: [PATCH] clk: imx8: Add DSP related clocks
Message-ID: <20190722032441.GW3738@dragon>
References: <20190702152007.12190-1-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702152007.12190-1-daniel.baluta@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 06:20:07PM +0300, Daniel Baluta wrote:
> i.MX8QXP contains Hifi4 DSP. There are four clocks
> associated with DSP:
>   * dsp_lpcg_core_clk
>   * dsp_lpcg_ipg_clk
>   * dsp_lpcg_adb_aclk
>   * ocram_lpcg_ipg_clk
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Applied, thanks.
