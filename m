Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1A58053B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2019 10:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387630AbfHCINw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Aug 2019 04:13:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:58060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387532AbfHCINw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 04:13:52 -0400
Received: from X250.getinternet.no (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CBC321726;
        Sat,  3 Aug 2019 08:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564820031;
        bh=xRf3PhzKfClVfWXbj3OVmFX6p7PLIiziHpTBekdtiCA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ss9AepiccoCuwp3jI5V+AvCYwJ22kCiRaDT5KOS6xQIatNXunmHVenhgXnMD80Qc7
         TqOSBRs+EXOFgBBij2U6aNxOn0caKeWWE6vXq6w/NSBgOCx27W/Ng3JVTPvTg/Eryz
         5i7jnRf79SbA0CzZKOO5R8mlymy/qdjEkCD2L+vU=
Date:   Sat, 3 Aug 2019 10:13:44 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] clk: imx8mm: Switch to platform driver
Message-ID: <20190803081344.GD8870@X250.getinternet.no>
References: <1562682003-20951-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562682003-20951-1-git-send-email-abel.vesa@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 05:20:03PM +0300, Abel Vesa wrote:
> There is no strong reason for this to use CLK_OF_DECLARE instead
> of being a platform driver. Plus, this will now be aligned with the
> other i.MX8M clock drivers which are platform drivers.
> 
> In order to make the clock provider a platform driver
> all the data and code needs to be outside of .init section.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

Applied, thanks.
