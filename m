Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDD1725F89
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 10:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbfEVIbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 04:31:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:50794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbfEVIbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 04:31:48 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB6D8204EC;
        Wed, 22 May 2019 08:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558513908;
        bh=X0k5MXY42CEagHu/uOyEPNYx16M6FMAqqRPgp6Ip9QA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BScxFANWt5ZSGlDKCgThFGvjUGYb8aaO84PMpbx0+i5yGSYt5qQG2EP9ywY855zXA
         uW0Z/YvXJI3oHmGwzOCtMR0sBqDORavDZukv7btep8j3UnQNqufucmqlTEgKPtv2Ci
         dXiArzPkprasiMpoBEkydLprzVKMmeY5f516vDNA=
Date:   Wed, 22 May 2019 16:30:52 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 1/4] MAINTAINERS: add an entry for for arm64 imx
 devicetrees
Message-ID: <20190522083051.GB9261@dragon>
References: <20190514132822.27023-1-angus@akkea.ca>
 <20190514132822.27023-2-angus@akkea.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514132822.27023-2-angus@akkea.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 06:28:19AM -0700, Angus Ainslie (Purism) wrote:
> Add an explicit reference to imx* devicetrees
> 
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7707c28628b9..9fc30f82ab81 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1624,6 +1624,7 @@ R:	NXP Linux Team <linux-imx@nxp.com>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
> +F:	arch/arm64/boot/dts/freescale/imx*

This is partially reverting commit da8b7f0fb02b ("MAINTAINERS: add all
files matching "imx" and "mxs" to the IMX entry").  I'm not sure that we
want it.

Shawn

>  N:	imx
>  N:	mxs
>  X:	drivers/media/i2c/
> -- 
> 2.17.1
> 
