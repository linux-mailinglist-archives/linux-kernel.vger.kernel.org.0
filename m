Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEAF186184
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Mar 2020 03:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbgCPC1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Mar 2020 22:27:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:35068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729329AbgCPC1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 22:27:51 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3442220674;
        Mon, 16 Mar 2020 02:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584325670;
        bh=BvqinQzwER3qvGVtAY/jOGwjYFoSdJdx/JoTyCey0Fs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W2BCYRPv+w/w/rPSriYges5+8PdjJB45otEpMOJcasHG8D0A2z8UdeJL2EbL/Nwb7
         MqC0eLo9/ipSMcSjKnxKIaN8TDFYSsTUSbvMaFY/9bhOwr+V6sS0nEgGgHPV8kXRBs
         ZXI1QhCZLrNCoDtpboPTDGGbaYCDbuooHU1UN/04=
Date:   Mon, 16 Mar 2020 10:27:44 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Igor Opaniuk <igor.opaniuk@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] ARM: dts: toradex: DTS license/copyright clean-up
Message-ID: <20200316022739.GV17221@dragon>
References: <20200312083830.18011-1-igor.opaniuk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312083830.18011-1-igor.opaniuk@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 10:38:27AM +0200, Igor Opaniuk wrote:
> 1. Replace boiler plate licenses texts with the SPDX license
> identifiers in Toradex Vybrid-based SoM device trees.
> 2. As X11 is identical to the MIT License, but with an extra sentence
> that prohibits using the copyright holders' names for advertising or
> promotional purposes without written permission, use MIT license instead
> of X11 ('s/X11/MIT/g').
> 3. Replace "Toradex AG" with "Toradex" in the Copyright notice.
> 4. Use GPL2.0+ instead of GPL2.0, as it's used now by default for all
> new DTS files.
> 
> v2:
> - Drop switching from GPL2.0+ to GPL2.0 [Marcel Ziswiler]
> - Replace "Toradex AG" with "Toradex" in the Copyright notice [Marcel Ziswiler]
> 
> Igor Opaniuk (3):
>   arm: dts: imx6: toradex: use SPDX-License-Identifier
>   arm: dts: imx7: toradex: use SPDX-License-Identifier
>   arm: dts: vf: toradex: SPDX tags and copyright cleanup

Change prefix to 'ARM: ...' and applied all, thanks.
