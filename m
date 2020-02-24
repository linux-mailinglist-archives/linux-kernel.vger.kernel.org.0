Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76A76169F71
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 08:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbgBXHoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 02:44:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:51846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgBXHoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 02:44:06 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBA5720675;
        Mon, 24 Feb 2020 07:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582530245;
        bh=FyUoC2EifZIEI4JxqsRsk6ZT1rO+AmxwSvqCAZX42Lg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DsWSyFvB0vNVY83mGmNc/sDIEJVXk3RAeAA/wuazyh08bgYFT69P7dXU6BOte+NYM
         mq7YFlPRT9rvdYH4/qchKWSG7eDVKX6GVWofRSdkQu3i9t9/WKusmlKPKrTwh+r9LG
         5aqmStZV3AGISHuoMdlo8oYfSX9h6ysjR+D5CDtQ=
Date:   Mon, 24 Feb 2020 15:43:58 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, leonard.crestez@nxp.com,
        peng.fan@nxp.com, yuehaibing@huawei.com, ping.bai@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] clk: imx: pll14xx: Return error if pll type is invalid
Message-ID: <20200224074356.GY27688@dragon>
References: <1582266716-19821-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582266716-19821-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 02:31:56PM +0800, Anson Huang wrote:
> When pll type is invalid, ONLY output error message is NOT enough,
> should return error immediately.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
