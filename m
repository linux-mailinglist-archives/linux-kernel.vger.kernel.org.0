Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2E111214A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 03:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfLDCLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 21:11:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:59456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbfLDCLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 21:11:43 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A74392073B;
        Wed,  4 Dec 2019 02:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575425502;
        bh=qAy1hN6YKBjhMpGjB5AiKNMsv5Q5YjwTmEYFHrcRW0Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PHjT8SSfzvC09abV0WTQ/shpatoyLQpMGrbWV/o18FMjcM9Rdj0QIlX4hbCmFVOUv
         0Ph8w9m4TVX/nkU/2V0al9OuBXIephrzKxaVVhoxyEe+NRKVq1pY1n9olKS9veorJY
         6+c0xjDfMHR9YK+6EoGVeJPNuhgJWrll2fKzMuJM=
Date:   Wed, 4 Dec 2019 10:11:35 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, adam.ford@logicpd.com,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: imx_v6_v7_defconfig: Enable TOUCHSCREEN_ILI210X
Message-ID: <20191204021135.GM9767@dragon>
References: <20191105134245.22568-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105134245.22568-1-aford173@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2019 at 07:42:45AM -0600, Adam Ford wrote:
> The imx6q-logicpd board supports an LCD with an ili2117
> touchscreen controller.
> 
> This patch enables the TOUCHSCREEN_ILI210X which will support
> the ili2117.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied, thanks.
