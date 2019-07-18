Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E999C6C501
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 04:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732517AbfGRCmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 22:42:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:51824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727804AbfGRCmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 22:42:21 -0400
Received: from X250 (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C9DC205F4;
        Thu, 18 Jul 2019 02:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563417740;
        bh=sjxuin9zTS4szxUyX8Q0ubzRlgU41diTfn7okIvvlkc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VG1DrduHwFM0tp6ajZDSCEp8z6g7EYUN7s7GURoz8uJRNBkcG+NAAZmFK1LwEMPRc
         2m3BkuDyWpreNzFAMsl3h5phmzJwBmZNQCytg73gRL+FFTyK89BaxJrc8hM3NC1pgE
         vwUBb7KKisIxy+S0RzBIrL+puo53mfkq5pcthwmc=
Date:   Thu, 18 Jul 2019 10:42:08 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pavel Machek <pavel@ucw.cz>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Carlo Caione <ccaione@baylibre.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: dts: imx8mq: Add DT node for the Mixel MIPI
 D-PHY
Message-ID: <20190718024207.GB11324@X250>
References: <cover.1561451144.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1561451144.git.agx@sigxcpu.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 10:27:19AM +0200, Guido Günther wrote:
> Now that the driver is in linux-next as of 20190624 let's have a DT node
> for the i.MX8mq and enable it on the Librem 5 devkit.
> 
> Guido Günther (2):
>   arm64: dts: imx8mq: Add MIPI D-PHY
>   arm64: dts: imx8mq-librem5: Enable MIPI D-PHY

Applied both, thanks.
