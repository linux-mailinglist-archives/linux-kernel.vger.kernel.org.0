Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3E3129349
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Dec 2019 09:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfLWItB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Dec 2019 03:49:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:49246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbfLWItA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 03:49:00 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1BF9206B7;
        Mon, 23 Dec 2019 08:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577090940;
        bh=uvYiO42x44YwlznJ7gGjnpYImsGJkvZIZYZtUbyi6m8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bDjgnKiRH93jW3yw/feZhiXW0rZVZN9Op6eXsCKfvGN1nqcyPsWATnlOdHQv22q8O
         UcVpWK+RBuuzkSXcWFfFc4zJElIqCjJaui9QbLqjgypvfKWY6aRSYIYpszC4Ru958D
         Yx5bmSXgxYXRwf2V1cIywEoBXC9mXo3i8r5EJdSo=
Date:   Mon, 23 Dec 2019 16:48:35 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH V3 3/3] arm64: defconfig: Enable CRYPTO_DEV_FSL_CAAM
Message-ID: <20191223084834.GW11523@dragon>
References: <20191218130616.13860-1-aford173@gmail.com>
 <20191218130616.13860-3-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218130616.13860-3-aford173@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 07:06:16AM -0600, Adam Ford wrote:
> Both the i.MX8MQ and i.MX8M Mini support the CAAM driver, but it
> is currently not enabled by default.
> 
> This patch enables this as a module.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied, thanks.
