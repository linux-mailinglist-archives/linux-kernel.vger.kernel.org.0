Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 232CA22C14
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 08:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730304AbfETG2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 02:28:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:33724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbfETG2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 02:28:53 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA53C206B6;
        Mon, 20 May 2019 06:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558333733;
        bh=Ui9uYmuCZCzF+3IjrsAp5TGAHEIpxCDWfcmShxLDVVs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=unf+dZGw5Ovy8YsjD047mOy9G0FONojvb30WZF+p48mVLup09wvY6+RwlSsjlbxsG
         /aMhdh+PBzxmRpNooEgYocdIhDh/a3DH5gasEwjUR+iL2m+fWe44y89zrfTXDEtfCJ
         Pxi+N6yBq+BEq0fXqlX7Qv6w++6+OhJDbCSGaV6E=
Date:   Mon, 20 May 2019 14:27:57 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "tiny.windzz@gmail.com" <tiny.windzz@gmail.com>,
        "pp@emlix.com" <pp@emlix.com>,
        "colin.didier@devialet.com" <colin.didier@devialet.com>,
        "robh@kernel.org" <robh@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "hofrat@osadl.org" <hofrat@osadl.org>,
        "michael@amarulasolutions.com" <michael@amarulasolutions.com>,
        "stefan@agner.ch" <stefan@agner.ch>, Abel Vesa <abel.vesa@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH RESEND 1/2] clk: imx: Add common API for masking MMDC
 handshake
Message-ID: <20190520062756.GP15856@dragon>
References: <1557656348-13040-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557656348-13040-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 12, 2019 at 10:24:12AM +0000, Anson Huang wrote:
> All i.MX6 SoCs need to mask unused MMDC channel's handshake
> for low power modes, this patch provides common API for masking
> the MMDC channel passed from caller.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

Applied both, thanks.
