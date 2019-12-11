Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2000611A31F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 04:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfLKDkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 22:40:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:37956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbfLKDkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 22:40:36 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 120C7206EC;
        Wed, 11 Dec 2019 03:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576035635;
        bh=7cmhNFa72+Abpr2QRYiJWiDvx2VS9NXXsn7cwvtgUAo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jZ8kiR42kraUQ4UyigWOsa4wQ/GI7/5G/OLOd4Y0lFhgAY84c67OgdxABygl9D5Up
         QhAMMCMIjCq929l2JNxhnrdthWzPmS5iNNYJfiC/AbUVl+9XwrchF0SLiRe616CctO
         BlRCt5rG2LX3RHzeGfnidgJcf1O/3pye48WTpOOE=
Date:   Wed, 11 Dec 2019 11:40:25 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     linux@armlinux.org.uk, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, tglx@linutronix.de,
        gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V2] ARM: imx: Enable ARM_ERRATA_814220 for i.MX6UL and
 i.MX7D
Message-ID: <20191211034024.GI15858@dragon>
References: <1576032816-23373-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576032816-23373-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 10:53:36AM +0800, Anson Huang wrote:
> ARM_ERRATA_814220 has below description:
> 
> The v7 ARM states that all cache and branch predictor maintenance
> operations that do not specify an address execute, relative to
> each other, in program order.
> However, because of this erratum, an L2 set/way cache maintenance
> operation can overtake an L1 set/way cache maintenance operation.
> This ERRATA only affected the Cortex-A7 and present in r0p2, r0p3,
> r0p4, r0p5.
> 
> i.MX6UL and i.MX7D have Cortex-A7 r0p5 inside, need to enable
> ARM_ERRATA_814220 for proper workaround.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
