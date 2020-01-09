Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBBE1353E3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 08:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbgAIHwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 02:52:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:56382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728184AbgAIHwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 02:52:49 -0500
Received: from T480 (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DC84206ED;
        Thu,  9 Jan 2020 07:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578556369;
        bh=qJ73lHGBY5+mUbmxJ+Wm95EZIzgEZEVAiXIja75jIB4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fDTK/dBKA/QpBD/ga1bHfAPUl2jLxcrVaTb6p8PaWV2k3UbsX4k1r46Mt9Jm+dqLg
         3k6It8V8wT0Hoj0XTpLYVbATPJkeClLK3422ZzjrqbIMCxUYCnslGekLIOsltEm6wy
         VCBYT67PfGHqlUB/k220CL6XqHY0Zn6utWFpikPw=
Date:   Thu, 9 Jan 2020 15:52:41 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        leonard.crestez@nxp.com, abel.vesa@nxp.com, l.stach@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH] soc: imx: Add i.MX8MP SoC driver support
Message-ID: <20200109075239.GF4456@T480>
References: <1577342402-12329-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577342402-12329-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 26, 2019 at 02:40:02PM +0800, Anson Huang wrote:
> Add i.MX8MP SoC driver support:
> 
> root@imx8mpevk:~# cat /sys/devices/soc0/family
> Freescale i.MX
> 
> root@imx8mpevk:~# cat /sys/devices/soc0/machine
> FSL i.MX8MP EVK
> 
> root@imx8mpevk:~# cat /sys/devices/soc0/soc_id
> i.MX8MP
> 
> root@imx8mpevk:~# cat /sys/devices/soc0/revision
> 1.0
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
