Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5CF8D640B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 15:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732137AbfJNNXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 09:23:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:36384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfJNNXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 09:23:08 -0400
Received: from dragon (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 227D621848;
        Mon, 14 Oct 2019 13:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571059387;
        bh=/8QNopu9sg/HvKCl5p+5djIJbq//CVacOt1EOwSJXtE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jRkO2K34EPsHAUrgHWJK7FGDuYVosHluCoBbos0eb8HKebh0j0NygFfczV3PxeFTN
         GO3gNDnlmkT4B0YbXpPFY84ut0N/0dXFZUrBeCE6eDM5yKeWxq6jO7SN7bO48d8W36
         vcxl8Yn6bxZxz1r+IrqDbc6kedXhSt58NIlbRxFg=
Date:   Mon, 14 Oct 2019 21:22:43 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        leonard.crestez@nxp.com, peng.fan@nxp.com, Anson.Huang@nxp.com,
        ping.bai@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] clk: imx: clk-pll14xx: Make two variables static
Message-ID: <20191014132241.GY12262@dragon>
References: <20191008071908.24568-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008071908.24568-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 03:19:08PM +0800, YueHaibing wrote:
> Fix sparse warnings:
> 
> drivers/clk/imx/clk-pll14xx.c:44:37:
>  warning: symbol 'imx_pll1416x_tbl' was not declared. Should it be static?
> drivers/clk/imx/clk-pll14xx.c:57:37:
>  warning: symbol 'imx_pll1443x_tbl' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied, thanks.
