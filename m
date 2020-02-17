Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5426C160A8C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 07:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgBQGd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 01:33:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:39766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbgBQGd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 01:33:58 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36A582072C;
        Mon, 17 Feb 2020 06:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581921237;
        bh=a7iT+Xd2qH1d2AgAUtQiwnF35749MAcOj1fuF4ST5zo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aqx0kYY4CK305vVZwVOYcUG5rzzHy/izY/p3oH+YF9jsZJVgo0EGvK5f3IWVvUMQo
         gvJw84LRXWA0kVSWekS7TM3SG4aCc/UIQw7eec/iGs7wlArHqMUualEk56xZyfclGS
         9FB2KWQC5ECuhIcF/zM6b9nStWKRhgKOqhnN7h4U=
Date:   Mon, 17 Feb 2020 14:33:51 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, abel.vesa@nxp.com,
        peng.fan@nxp.com, chen.fang@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH] clk: imx7ulp: Include clk-provider.h instead of clk.h
Message-ID: <20200217063351.GB6952@dragon>
References: <1581498584-14674-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581498584-14674-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 05:09:43PM +0800, Anson Huang wrote:
> The i.MX7ULP clock driver is provider, NOT consumer, so clk-provider.h
> should be used instead of clk.h.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
