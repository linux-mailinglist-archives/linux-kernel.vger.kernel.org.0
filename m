Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4151D196F4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2019 05:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfEJDFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 May 2019 23:05:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:33782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726842AbfEJDFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 23:05:48 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 372002182B;
        Fri, 10 May 2019 03:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557457547;
        bh=mkQ3abg+2JtJLueEBsJfOfdiHSoy46DAguszRpEAgAg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kgyjEjafqRceisaxV6npqASBMVD/V60tt4LtTqspH3YkOtoKSCXufoBbf/h4MA3ja
         Rhz81s8okglcQipl3VeLT0vvrpLHtxaPXrTxvtoX6PxmtodoOHiIgvP2uEoh/jkL/O
         FcdQ/4QfQRj0x/59Phig4C8BfdaV96xp1cfwz2m0=
Date:   Fri, 10 May 2019 11:05:26 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Grant Likely <grant.likely@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: defconfig: Enable FSL_EDMA driver
Message-ID: <20190510030525.GC15856@dragon>
References: <20190422183056.16375-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190422183056.16375-1-leoyang.li@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 01:30:56PM -0500, Li Yang wrote:
> Enables the FSL EDMA driver by default.  This also works around an issue
> that imx-i2c driver keeps deferring the probe because of the DMA is not
> ready.  And currently the DMA engine framework can not correctly tell
> if the DMA channels will truly become available later (it will never be
> available if the DMA driver is not enabled).
> 
> This will cause indefinite messages like below:
> [    3.335829] imx-i2c 2180000.i2c: can't get pinctrl, bus recovery not supported
> [    3.344455] ina2xx 0-0040: power monitor ina220 (Rshunt = 1000 uOhm)
> [    3.350917] lm90 0-004c: 0-004c supply vcc not found, using dummy regulator
> [    3.362089] imx-i2c 2180000.i2c: can't get pinctrl, bus recovery not supported
> [    3.370741] ina2xx 0-0040: power monitor ina220 (Rshunt = 1000 uOhm)
> [    3.377205] lm90 0-004c: 0-004c supply vcc not found, using dummy regulator
> [    3.388455] imx-i2c 2180000.i2c: can't get pinctrl, bus recovery not supported
> ..... 
> 
> Signed-off-by: Li Yang <leoyang.li@nxp.com>

Applied, thanks.
