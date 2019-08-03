Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEDA806D8
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2019 16:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfHCO4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Aug 2019 10:56:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:59014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfHCO4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 10:56:53 -0400
Received: from X250.getinternet.no (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69D49206C1;
        Sat,  3 Aug 2019 14:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564844212;
        bh=Un3lXCixRMwp1nYc0wJmK5BTO4HJ7DqaPwgspkZjIvI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wYxnaqUjohc/m81AGe1GVHAGECDZu8ownqOJvpQYHKh6SRlc6T6inVZ4AIf/zyfL0
         bcWKVUXnaKrlIQbUP+rgFDnnLlZhCUa2c6aVvxU2SFK/4U4DUL2mBtRZoSpGR6beyv
         ZIztYSYaVALiADVYxnFLZgjVoot8Lxl1kO8aV0eI=
Date:   Sat, 3 Aug 2019 16:56:45 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     s.hauer@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        l.stach@pengutronix.de, ccaione@baylibre.com, abel.vesa@nxp.com,
        baruch@tkos.co.il, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, shengjiu.wang@nxp.com, angus@akkea.ca
Subject: Re: [PATCH] arm64: dts: imx8mq-evk: Unbypass audio_pll1
Message-ID: <20190803145644.GO8870@X250.getinternet.no>
References: <20190728140817.12509-1-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190728140817.12509-1-daniel.baluta@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 05:08:17PM +0300, Daniel Baluta wrote:
> Making audio_pll1 parent of audio_pll1_bypass, will allow
> setting rates multiple of 8000 for children.
> 
> After unbypass clk hierarchy looks like this:
>  * osc_25m
>    * audio_pll1
>      * audio_pll1_bypass
>        * audio_pll1_out
>          * sai2
>            * sai2_root_clk
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Applied, thanks.
