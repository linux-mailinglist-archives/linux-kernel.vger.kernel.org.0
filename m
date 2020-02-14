Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0D715CF8D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 02:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgBNBui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 20:50:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:50946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727988AbgBNBuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 20:50:37 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C02B2168B;
        Fri, 14 Feb 2020 01:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581645037;
        bh=8ouioEgqGIyjBE3bpjFG0WlAy2BoRVyptqr70rSvxTM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VpY3qo8BBbMz8+ZPB8mrJPuw/iNtnxy/l4pBWWozwgWoYMoV8TokSs/T1Hb6T9AAT
         6m2NCiQhMQZ4jIpBiDz7qIheLeN5LwuVYj4+tQWTyIhdXHhAToEgZ/a960Dsl5fZ/w
         l8laSD/T+t3dcEiPHcxfwujUo+D587AWUqGR5qAM=
Date:   Fri, 14 Feb 2020 09:50:30 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Subject: Re: [PATCH] clk: imx: imx8mp: add ocotp root clk
Message-ID: <20200214015029.GA22842@dragon>
References: <1579428498-10068-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579428498-10068-1-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 19, 2020 at 10:12:46AM +0000, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add ocotp root clk, then when using nvmem to read fuse, clk
> could be managed.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks.
