Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3EC138547
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jan 2020 07:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732293AbgALGYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jan 2020 01:24:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:57738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732246AbgALGYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 01:24:20 -0500
Received: from T480 (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2484720842;
        Sun, 12 Jan 2020 06:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578810259;
        bh=dA7Y+M1xkDoiyTBWHECvmy971XxNXYZ+AlF7WdltObY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ff5qBEpTpO4/M1KGlt2oOdQbkiMcOTVxyuE4Uawg5KmaJoNkrpkUirg/dOvcx87e/
         oULdsE6v98K2CWAUvaeUx4vSk/4xwG4VaJbnbIeOz/bu6kGX+E0fIC6Wq7qNObrH7j
         Gj16/tr489q4V1cL513W7T3AFs3+HPqzdNttvBuc=
Date:   Sun, 12 Jan 2020 14:24:09 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Robert Jones <rjones@gateworks.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 0/5] ARM: dts: imx: Add GW59xx Gateworks specials
Message-ID: <20200112062407.GB27570@T480>
References: <20200108154424.15736-1-rjones@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108154424.15736-1-rjones@gateworks.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 07:44:19AM -0800, Robert Jones wrote:
> Robert Jones (4):
>   dt-bindings: arm: fsl: Add Gateworks Ventana i.MX6DL/Q compatibles
>   ARM: dts: imx: Add GW5907 board support
>   ARM: dts: imx: Add GW5913 board support
>   ARM: dts: imx: Add GW5912 board support
> 
> Tim Harvey (1):
>   ARM: dts: imx: Add GW5910 board support

Applied all, thanks.
