Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5F015D3D9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 09:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbgBNIcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 03:32:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:35348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbgBNIcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 03:32:42 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4668420873;
        Fri, 14 Feb 2020 08:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581669162;
        bh=Hw5z4C04dvgDdgjwZX9sbW+U/h9mRyaYkFTxfMoV9rI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rGuXm0DAYYdFvoXOA59Sy1pGJdtM2VWWJPQwq+ZXZhkqeJCSUmUiYnVxDG2bCv1h5
         9iiG9o48fbxLQPKTUZhrPryC3Xtz3JWednyhkYIITa2OpLJALHu8pMMqSL/6Rn2ueF
         LfiTPsMGnSgCD9GXsdn38883h+c52sPH58FIwlaY=
Date:   Fri, 14 Feb 2020 16:32:33 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Cc:     devicetree@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] ARM: dts: imx7-colibri: fix muxing of usbc_det pin
Message-ID: <20200214083232.GA25543@dragon>
References: <20200204111151.3426090-1-oleksandr.suvorov@toradex.com>
 <20200204111151.3426090-3-oleksandr.suvorov@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204111151.3426090-3-oleksandr.suvorov@toradex.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2020 at 01:11:47PM +0200, Oleksandr Suvorov wrote:
> USB_C_DET pin shouldn't be in ethernet group.
> 
> Creating a separate group allows one to use this pin
> as an USB ID pin.
> 
> Fixes: b326629f25b7 ("ARM: dts: imx7: add Toradex Colibri iMX7S/iMX7D suppor")
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>

Applied, thanks.
