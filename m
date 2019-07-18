Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 637BA6C92B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 08:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfGRGPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 02:15:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:38946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726376AbfGRGPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 02:15:47 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8EFA21019;
        Thu, 18 Jul 2019 06:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563430546;
        bh=RdebAFINFwGRd3fswkfBur49ClSa/w8Ovi61pshm760=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ljYbDYhJ4xVqrCpTFJY/3ishKDOVoQHHBW2ZDakxhOFV94K9Tu0lc5iewNEo4Ch8S
         2gtRRThD7GNxs9XpLHD7c0hqVRT9LZsNhUoop53dJgoZqPJUA49FyMbwUYOQELe2AH
         fed0iMZuQCFKEmqik+7Gsty3wvmLcTLEj+EaNZkc=
Date:   Thu, 18 Jul 2019 14:15:30 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: imx8mm: Init rates and parents configs
 for clocks
Message-ID: <20190718061529.GH3738@dragon>
References: <1562155702-29809-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562155702-29809-1-git-send-email-abel.vesa@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 03:08:22PM +0300, Abel Vesa wrote:
> Add the initial configuration for clocks that need default parent and rate
> setting. This is based on the vendor tree clock provider parents and rates
> configuration except this is doing the setup in dts rather than using clock
> consumer API in a clock provider driver.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

Applied, thanks.
