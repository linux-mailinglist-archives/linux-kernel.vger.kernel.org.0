Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7AC28A07E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 16:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbfHLOQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 10:16:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:43968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbfHLOQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 10:16:25 -0400
Received: from X250 (37.80-203-192.nextgentel.com [80.203.192.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1BCC20679;
        Mon, 12 Aug 2019 14:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565619384;
        bh=Z71CRfrqFcWUNSp2uxgfxbY+qKDDqxbG0/qNWSzb678=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SN3tN9owjAVMrj3guehbcdfyKXwFfF0j7L49FjewsGpTTFil0j3dhMyhNhQcrMvnH
         pDb7mTvpQUOfL7S1CqG8PMuZ3q+si0aM9M9bZC93UeXmLYyAEs3OLIqctRiZjxjHjR
         LqDbwpkrsJ++C4fJV0h2SmaLuelf8gu5SRxPQh6k=
Date:   Mon, 12 Aug 2019 16:16:13 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson.Huang@nxp.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, abel.vesa@nxp.com,
        peng.fan@nxp.com, leonard.crestez@nxp.com, ping.bai@nxp.com,
        jun.li@nxp.com, chen.fang@nxp.com, agx@sigxcpu.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH 1/2] clk: imx8mm: Unregister clks when
 of_clk_add_provider failed
Message-ID: <20190812141611.GI27041@X250>
References: <20190806064614.20294-1-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806064614.20294-1-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 02:46:13PM +0800, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> When of_clk_add_provider failed, all clks should be unregistered.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied both, thanks.
