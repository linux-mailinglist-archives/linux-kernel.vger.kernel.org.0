Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A365117F0C6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 07:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgCJGza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 02:55:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:60100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbgCJGza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 02:55:30 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AAE724673;
        Tue, 10 Mar 2020 06:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583823329;
        bh=ZRCNkTGQgwAEDE8s853tkWNNHFMgO9nid8aMskpYkP8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YDBbac6jQ5YBSWONwFuddRv8bO3Yf7NBJGFTJ4fwRnb+KMhEYL8hLp9tKMD9NXcuv
         95UizvXqQuT/PSxN9pQWxeSwiVl/has3oLUDdQvJJWA2XlHcZ95/UR9ZZCSB0kyMzs
         HhVcM4Z69pfcBMln107gs7CbzcWYyIPjbqFXglMg=
Date:   Tue, 10 Mar 2020 14:55:22 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     peng.fan@nxp.com
Cc:     s.hauer@pengutronix.de, festevam@gmail.com, kernel@pengutronix.de,
        linux-imx@nxp.com, olof@lixom.net, aisheng.dong@nxp.com,
        leonard.crestez@nxp.com, abel.vesa@nxp.com, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 0/2] soc: imx: increase build coverage for imx8 soc
 driver
Message-ID: <20200310065521.GA17772@dragon>
References: <1582252339-15733-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582252339-15733-1-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 10:32:17AM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> V5:
>  Add missed "static inline" in misc.h
> 
> V4:
>  Add dummy functions to fix build issue when soc-imx-scu.c built in,
>  but drivers/firmware/imx/imx-scu.c not built in.
>  No change to Patch 2/2.
> 
> V3:
>  Per Arnd's suggestions, merged Patch 2/3/4/5 into one patch
>  Dropped the defconfig change with a default Kconfig
> 
>  Leonard, I dropped you R-b in V3 since the change.
> 
> V2:
>  Include Leonard's patch to fix build break after enable compile test
>  Add Leonard's R-b tag
> 
> Rename soc-imx8.c to soc-imx8m.c which is for i.MX8M family
> Add SOC_IMX8M for build gate soc-imx8m.c
> Increase build coverage for i.MX SoC driver
> 
> Peng Fan (2):
>   firmware: imx: add dummy functions
>   soc: imx: increase build coverage for imx8m soc driver

Applied both, thanks.
