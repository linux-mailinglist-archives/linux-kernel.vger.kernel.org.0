Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5EB54A1E2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 15:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbfFRNSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 09:18:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:40006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbfFRNSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 09:18:33 -0400
Received: from dragon (li1322-146.members.linode.com [45.79.223.146])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E09062070B;
        Tue, 18 Jun 2019 13:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560863912;
        bh=1y2U8X12rJFersG6m+NAIREsnvkoVvu7YAOkiIfgHRA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qIDrUimvv+WuXK5JHBoSh4thayiimM4+9jNtbKpOgnZ8FIRECqs1pHTNFO1jnWPsT
         E6aTpSySvalhFXfc6RtFSVD36Cx8X3HKNDkgjrvkhVx2RJGMfBUlK3Pr2CKZsFGA1E
         RY/p686OEE/Aml8QM+TjxyU6YSl5NwXW0GjizaXo=
Date:   Tue, 18 Jun 2019 21:17:35 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        linux-kernel@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH] clk: imx6q: fix section mismatch warning
Message-ID: <20190618131734.GE1959@dragon>
References: <20190617111159.2124152-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617111159.2124152-1-arnd@arndb.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 01:11:35PM +0200, Arnd Bergmann wrote:
> The imx6q_obtain_fixed_clk_hw lacks an __init marker, which
> leads to this otherwise harmless warning:
> 
> WARNING: vmlinux.o(.text+0x495358): Section mismatch in reference from the function imx6q_obtain_fixed_clk_hw() to the function .init.text:imx_obtain_fixed_clock_hw()
> The function imx6q_obtain_fixed_clk_hw() references
> the function __init imx_obtain_fixed_clock_hw().
> This is often because imx6q_obtain_fixed_clk_hw lacks a __init
> annotation or the annotation of imx_obtain_fixed_clock_hw is wrong.
> 
> Fixes: 992b703b5b38 ("clk: imx6q: Switch to clk_hw based API")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks.
