Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0570135597
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 10:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbgAIJUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 04:20:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:45080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729297AbgAIJUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 04:20:37 -0500
Received: from T480 (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DBFB20673;
        Thu,  9 Jan 2020 09:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578561636;
        bh=17pCcLe4ROvs5zpvE5tGEghbWDf2T6LpIyRxzdcAFxY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h5rB+Vf2Kojy9XKlrdumZkTsg8vxTXuUuPzgQMFP/gOCZ3m73NWpCbbQhSQgpqajU
         Y7DfPLfSEIYdEdfnkm/FGnv/sN7ZXPHmJ2mLVmbkybl73MPLiaWVxuIVp9a2BhuU/M
         wnDbr3K5sW6e10LsnqiY54tK7ZlgXNcb50zysGfs=
Date:   Thu, 9 Jan 2020 17:20:28 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: imx: Enable compile testing of IMX_SCU_SOC
Message-ID: <20200109092028.GM4456@T480>
References: <20200103220557.24812-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200103220557.24812-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 03, 2020 at 11:05:57PM +0100, Krzysztof Kozlowski wrote:
> IMX_SCU_SOC can be compile tested to increase build coverage.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied, thanks.
