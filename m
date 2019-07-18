Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09D996C983
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 08:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389263AbfGRGxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 02:53:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:50448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbfGRGxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 02:53:36 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2414121019;
        Thu, 18 Jul 2019 06:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563432815;
        bh=8IzAReYqXq/3S0bhs+CviSUdY7AnwzXlaXmrb9FgxdY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XVJlqVi7f4GhO4/cKQL49MIOrK6GMB+ubiXyb8S16WTZyV1NTzZQ/GhShnJPOCLv5
         MoiE3tTVc+KI4rTatpDDjH96PAWcjsEGqID5qtA85xkZVG3g1odXN0wd9wUtmLyj8B
         PkyCPmgqabTPER/WUVKDa4OgcvEHMSz1AmDXptoA=
Date:   Thu, 18 Jul 2019 14:53:16 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson.Huang@nxp.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, leonard.crestez@nxp.com,
        ping.bai@nxp.com, peng.fan@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH RESEND 1/2] clk: imx8mm: Fix typo of pwm3 clock's mux
 option #4
Message-ID: <20190718065314.GJ3738@dragon>
References: <20190626012803.45627-1-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626012803.45627-1-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 09:28:02AM +0800, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> i.MX8MM has no sys3_pll2_out clock, PWM3 clock's mux option #4
> should be sys_pll3_out, sys3_pll2_out is a typo, fix it.
> 
> Fixes: ba5625c3e272 ("clk: imx: Add clock driver support for imx8mm")
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied both, thanks.
