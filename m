Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF4F8E433E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 08:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394254AbfJYGJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 02:09:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:49072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394092AbfJYGJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 02:09:08 -0400
Received: from dragon (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA8DC20867;
        Fri, 25 Oct 2019 06:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571983747;
        bh=0H2daTsu9+8fCDGndaBTXY7rtrZfvAp3lOyQ9af0Uj4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DYcuUypg9cAHM05eqVIzahYb7H/9jsSkqHrbAroRIMT25qFyM9kPjFikA8gCJ/EwY
         AWFbt6Rdf7RYCNuEmd0OnArZR6Luc6yYr8o+kjIRFGxYcb7fCzxxetc6u5T4HuezX4
         eA2NxE0KeCqGyw3bX56cUT7Qygb70d2UoCIz5kL0=
Date:   Fri, 25 Oct 2019 14:08:49 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH 1/3] clk: imx: imx8mm: mark sys_pll1/2 as fixed clock
Message-ID: <20191025060847.GD3208@dragon>
References: <1570614940-17239-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570614940-17239-1-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 09:58:14AM +0000, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> According Architecture definition guide, SYS_PLL1 is fixed at
> 800MHz, SYS_PLL2 is fixed at 1000MHz, so let's use imx_clk_fixed
> to register the clocks and drop code that could change the rate.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied all, thanks.
