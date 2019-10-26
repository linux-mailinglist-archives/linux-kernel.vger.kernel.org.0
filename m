Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42A73E5934
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2019 10:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfJZIQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Oct 2019 04:16:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:59458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbfJZIQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 04:16:42 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87EE121D7F;
        Sat, 26 Oct 2019 08:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572077802;
        bh=GAJf0+ZsT9zLGFJe4VA1UIx4iLZZPPhj7MOQvVx/7gw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cGHdFdVpjZ6TFyXj2mLLzZnSb1d/zbaYiGMhJO9BxsomW3x+jE30Xxku2F1x+ZbsR
         EBhVxNs/BYHM6s7D72V5dapQruo2Gdb79/GTnSeJIC7bbcdqPNNz5LKe692y9TxvTL
         0J+tx83UdQ/w/QTFpJZVsCEYdN1f1H1j9MzaVtRo=
Date:   Sat, 26 Oct 2019 16:16:26 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, aisheng.dong@nxp.com,
        gustavo@embeddedor.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V2] clk: imx7ulp: Correct system clock source option #7
Message-ID: <20191026081625.GC14401@dragon>
References: <1571014565-4807-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571014565-4807-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 08:56:05AM +0800, Anson Huang wrote:
> In the latest reference manual Rev.0,06/2019, the SCS's option #7
> is no longer from upll, it is reserved, update clock driver accordingly.
> 
> Fixes: b1260067ac3d ("clk: imx: add imx7ulp clk driver")
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Applied, thanks.
