Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75C0649960
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 08:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbfFRGwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 02:52:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:56560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728455AbfFRGwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 02:52:12 -0400
Received: from dragon (li1322-146.members.linode.com [45.79.223.146])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D39020679;
        Tue, 18 Jun 2019 06:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560840731;
        bh=aCHd527iEyPOQrGtxKzpIz/rVHqvtEEHCM75bJPOonc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OiTQ44nLfa5pPquo//DDSOvtfEk9pMHAkszfOQdVf6bDJr+dp3yEgN/oBFVFVDFRk
         Xeqtmq5acyTULJq+UNzhMIQ7oe7AT2foIANW1p9z7WG3zO9wvTzCU4GHMv4F75M4MC
         cQ07bkLQKCeeu3Flpf8XiLjLf0pWa7zhbpmm1ujU=
Date:   Tue, 18 Jun 2019 14:51:17 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson.Huang@nxp.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, abel.vesa@nxp.com,
        l.stach@pengutronix.de, ccaione@baylibre.com,
        leonard.crestez@nxp.com, aisheng.dong@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH 1/2] clk: imx: Remove __init for imx_check_clocks() API
Message-ID: <20190618065116.GA29881@dragon>
References: <20190610053634.14339-1-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610053634.14339-1-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 01:36:33PM +0800, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> Some of i.MX SoCs' clock driver use platform driver model,
> and they need to call imx_check_clocks() API, so
> imx_check_clocks() API should NOT be in .init section.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied both, thanks.
