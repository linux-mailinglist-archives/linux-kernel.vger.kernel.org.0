Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3CFED6CE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 02:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbfKDBLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Nov 2019 20:11:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:56004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbfKDBLe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 20:11:34 -0500
Received: from dragon (li1038-30.members.linode.com [45.33.96.30])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D51B4222D1;
        Mon,  4 Nov 2019 01:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572829894;
        bh=9Oa/sZWPuyk4aTCFfeZkZBXLeIf0WxdXMrii3wBcuv8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g7ux+1p7dJ82AZDTQVQlwRtgWpqrw6zDT2JfOLcqVufbOeo7EcafI7G1Yd2N651e2
         R6fNuCO8+xM69qoefI+G8iWvOdQ4wsml+wVh3rmyqeuGq0HPqI5QLldccnDyzUY5xZ
         Os8xd3Ps+7tAydS7p90yPjgiK1k2yQKf39cD+R4M=
Date:   Mon, 4 Nov 2019 09:11:07 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH V2] clk: imx: imx8mq: fix sys3_pll_out_sels
Message-ID: <20191104011106.GD24620@dragon>
References: <1572231902-30230-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572231902-30230-1-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 03:08:34AM +0000, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> It is not correct that sys3_pll_out use sys2_pll1_ref_sel as parent.
> 
> According to the current imx_clk_sccg_pll design, it uses both
> bypass1/2, however set bypass2 as 1 is not correct, because it will
> make sys[x]_pll_out use wrong parent and might access wrong registers.
> 
> So correct bypass2 to 0 and fix sys3_pll_out_sels.
> 
> Fixes: e9dda4af685f ("clk: imx: Refactor entire sccg pll clk")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks.
