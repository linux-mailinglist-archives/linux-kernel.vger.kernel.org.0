Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3F080541
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2019 10:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387661AbfHCITd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Aug 2019 04:19:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:59254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387532AbfHCITd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 04:19:33 -0400
Received: from X250.getinternet.no (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69E3321726;
        Sat,  3 Aug 2019 08:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564820372;
        bh=Gtho0y2y4kcYJkq5zuuB2XKU3XBkmN3WkgaKpIxlFnI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lFmVX0W1bekQgqkuGJ+9uXCtMYsUKgvpdq6J+YeNsLRYGUAoW+KaOdsoI6P63x5s/
         Vdyt+8XtxjU/giM2x71AXfEgczT2yJlCv+Ecs7Y4fO5cUnmMhlxWRVgO2oFkjgwvH3
         fJk4HeiL45H0EJKFBJUeBLPgUlOG+vwLJq0MYhVg=
Date:   Sat, 3 Aug 2019 10:19:25 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] bus: imx-weim: optionally enable burst clock mode
Message-ID: <20190803081924.GE8870@X250.getinternet.no>
References: <20190712204316.16783-1-TheSven73@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712204316.16783-1-TheSven73@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 04:43:15PM -0400, Sven Van Asbroeck wrote:
> To enable burst clock mode, add the fsl,burst-clk-enable
> property to the weim bus's devicetree node.
> 
> Example:
> weim: weim@21b8000 {
> 	compatible = "fsl,imx6q-weim";
> 	reg = <0x021b8000 0x4000>;
> 	clocks = <&clks 196>;
> 	#address-cells = <2>;
> 	#size-cells = <1>;
> 	ranges = <0 0 0x08000000 0x08000000>;
> 	fsl,weim-cs-gpr = <&gpr>;
> 	fsl,burst-clk-enable;
> 
> 	client-device@0,0 {
> 		compatible = "something";
> 		reg = <0 0 0x02000000>;
> 		#address-cells = <1>;
> 		#size-cells = <1>;
> 		bank-width = <2>;
> 		fsl,weim-cs-timing = <0x00620081 0x00000001 0x1c022000
> 				0x0000c000 0x1404a38e 0x00000000>;
> 	};
> };
> 
> Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>

Applied both, thanks.
