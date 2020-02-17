Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2227A160A94
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 07:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgBQGgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 01:36:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:40078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbgBQGgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 01:36:23 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1729B20702;
        Mon, 17 Feb 2020 06:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581921383;
        bh=BMMe9is2DgAIgri+7WZ9a4B8Sjfj9h9YXhUEhAstKsg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RTmpKC/hl12WkzSFTmeztlSc0NpSAbIB5OnqD67xudkgJeHI41q9afz61Ah05tBxK
         4P1SSZKEIknhn63/MKcLnB8RzdcjwrNYu+M6UkOLeXdpjjxqzRuWeo1Wa9KpnEt8F3
         +2KkkLItfPTZtk4oZrUyKiqA9VpMXgNjFh+bprlA=
Date:   Mon, 17 Feb 2020 14:36:17 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: Re: [PATCH] ARM: dts: imx6dl-colibri-eval-v3: fix sram compatible
 properties
Message-ID: <20200217063616.GC6952@dragon>
References: <20200212104629.20272-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212104629.20272-1-johan@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 11:46:29AM +0100, Johan Hovold wrote:
> The sram-node compatible properties have mistakingly combined the
> model-specific string with the generic "mtd-ram" string.
> 
> Note that neither "cy7c1019dv33-10zsxi, mtd-ram" or
> "cy7c1019dv33-10zsxi" are used by any in-kernel driver and they are
> not present in any binding.
> 
> The physmap driver will however bind to platform devices that specify
> "mtd-ram".
> 
> Fixes: fc48e76489fd ("ARM: dts: imx6: Add support for Toradex Colibri iMX6 module")
> Cc: Sanchayan Maity <maitysanchayan@gmail.com>
> Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Applied, thanks.
