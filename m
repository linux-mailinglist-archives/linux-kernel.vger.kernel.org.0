Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44A40160AA2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 07:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgBQGkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 01:40:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:41108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbgBQGkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 01:40:13 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60CFD20718;
        Mon, 17 Feb 2020 06:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581921613;
        bh=XFbjQAOOfnfE2Onndj27WEPC9SLmDo0RD9R/ZAv1n6s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LJkD00LqMFzKgk55zcNGVoXFPnVegA9h72nTYmRW2Q44M+Y4NJ8PTH70J6CrFIacj
         wXrgbN9WD2CbDfxc17MKYRmhLsQK1KW+JjPxmNRPM+QPEJy+zfhicWBmPZHXuhuwf+
         /i8/fNHrfBWBuOi3cpb4HkSZoJLmqzT4z2K49F6k=
Date:   Mon, 17 Feb 2020 14:40:08 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     peng.fan@nxp.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] ARM: dts: imx: use generic name bus
Message-ID: <20200217063959.GE6952@dragon>
References: <1581563878-26388-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581563878-26388-1-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 11:17:58AM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Per devicetree specification, generic names
> are recommended to be used, such as bus.
> 
> i.MX AIPS is a AHB - IP bridge bus, so
> we could use bus as node name.
> 
> Script:
> sed -i "s/\<aips@/bus@/" arch/arm/boot/dts/imx*.dtsi
> sed -i "s/\<aips@/bus@/" arch/arm/boot/dts/vf*.dtsi
> sed -i "s/\<aips-bus@/bus@/" arch/arm/boot/dts/imx*.dtsi
> sed -i "s/\<aips-bus@/bus@/" arch/arm/boot/dts/vf*.dtsi
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks.
