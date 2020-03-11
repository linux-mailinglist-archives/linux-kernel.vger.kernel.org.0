Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5BE41813BA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 09:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbgCKIyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 04:54:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:38218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728195AbgCKIyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 04:54:07 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2825020873;
        Wed, 11 Mar 2020 08:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583916847;
        bh=q9pX7RdIeHC12gIE7AwUqz4c8Oq1C8zcrGUI6VQx08k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j9tEh9CKAQvhblCfQ79VtTz2ZvM7u9zbEuZryIvvvwfaV/cQRcvprPihaPFOiqyQE
         KiouaIwbxFCoz9RdF9cBGIzKA149ljubVMfa2WzhlC8Z4mxlVdOEF/h5GxAe02urT6
         JpuyGXmzqN3xI1mKT/9xZspk9pOKGm5kmqLBkFIg=
Date:   Wed, 11 Mar 2020 16:53:58 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] ARM: dts: imx: use generic name for crypto node
Message-ID: <20200311085357.GG29269@dragon>
References: <20200305135909.8180-1-horia.geanta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200305135909.8180-1-horia.geanta@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 03:59:04PM +0200, Horia Geantă wrote:
> This patch set aligns / fixes the naming of the crypto node
> (and its child nodes) for sahara, dcp and caam crypto engines
> used in i.MX SoCs.
> 
> Horia Geantă (4):
>   dt-bindings: crypto: sahara: use generic node name
>   dt-bindings: crypto: dcp: use generic node name
>   dt-bindings: crypto: caam: use generic node name
>   ARM: dts: imx: align name for crypto node and child nodes
> 
> Silvano di Ninno (1):
>   arm64: dts: imx8mn: align name for crypto child nodes

Applied all, thanks.
