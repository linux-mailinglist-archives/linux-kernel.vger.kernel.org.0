Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5723A4FE8C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 03:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfFXBo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jun 2019 21:44:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:33592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbfFXBoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 21:44:25 -0400
Received: from dragon (li1322-146.members.linode.com [45.79.223.146])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 247F1205ED;
        Mon, 24 Jun 2019 01:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561340664;
        bh=L51b/2QgjrPE0+cEczSNkLZTA7o5n080OlbpRGOR1Wc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z3szbyA/JEupNJmaT4Fg6uC+zWG5smbJXs7IBZuivL/JVx5Gu1fQRikaE8HM0eq8G
         ErFlU0Xwvigdrgh4HApZzEavQK9GYlxf3e4szYfLTv44iS9iIjGB/+5T553tZcpo0g
         BpPtCwsmDFIQz1aleU9NTtzTsIzUSPFhRw33g7N0=
Date:   Mon, 24 Jun 2019 09:44:11 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson.Huang@nxp.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, abel.vesa@nxp.com,
        ccaione@baylibre.com, leonard.crestez@nxp.com,
        aisheng.dong@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH 1/2] clk: imx: Remove __init for
 imx_register_uart_clocks() API
Message-ID: <20190624014410.GI3800@dragon>
References: <20190619071240.38503-1-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619071240.38503-1-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 03:12:39PM +0800, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> Some of i.MX SoCs' clock driver use platform driver model,
> and they need to call imx_register_uart_clocks() API, so
> imx_register_uart_clocks() API should NOT be in .init section.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied both, thanks.
