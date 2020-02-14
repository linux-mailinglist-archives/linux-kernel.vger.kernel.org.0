Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5D1115D0A3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 04:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgBNDid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 22:38:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:49988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728052AbgBNDic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 22:38:32 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F5CB206ED;
        Fri, 14 Feb 2020 03:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581651512;
        bh=Rg5Rt8jNj529mTf1TnuXEn0bBhlKddB9sYivI+PM5mo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zCtDGbSk9HRyairt+nbcqRD0NKe9eeeiHxpuPFOzIQMR6XuXfvsgOUCZEJwrazkqk
         Pso5aSiVgJpQsvGTTJbfq1V6beXTMV+/RbGesZYI39stszfO9lBACJbK7xRHWo+2dV
         TZjdXsjrtepiy53un+rh9FUv9LBNf/rTnRb5HLtk=
Date:   Fri, 14 Feb 2020 11:38:25 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Stefan Agner <stefan@agner.ch>
Cc:     s.hauer@pengutronix.de, linux@armlinux.org.uk,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        arnd@arndb.de, Anson.Huang@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan.agner@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Subject: Re: [PATCH v2] ARM: imx: limit errata selection to Cortex-A9 based
 designs
Message-ID: <20200214033824.GQ22842@dragon>
References: <20200205224214.253098-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205224214.253098-1-stefan@agner.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 11:42:14PM +0100, Stefan Agner wrote:
> From: Stefan Agner <stefan.agner@toradex.com>
> 
> The two erratas 754322 and 775420 are Cortex-A9 specific. The i.MX 6UL
> SoCs include a Cortex-A7 CPU and hence do not need this erratas enabeld.
> This patch moves the errata selection from the family Kconfig symbol to
> the SoC specifc Kconfig symbols where a Cortex-A9 is used.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Reviewed-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Applied, thanks.
