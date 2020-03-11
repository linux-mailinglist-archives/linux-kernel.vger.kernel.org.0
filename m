Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8585C1811D8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 08:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbgCKHYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 03:24:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:42300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbgCKHYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 03:24:08 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7ABA208C3;
        Wed, 11 Mar 2020 07:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583911447;
        bh=lkHFqC8ZRxcaRyz81dQuxwKyc4A2eZOBdv49+6zS01U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nXxqV/XvdKdQWF4XEvvj5qSJf57txtG5qyntln99BixWw4NmBLZby/01hqjekRDpO
         yN+E4s5SqWTfbdCc1D4QrTaeW4OGWNTeYRbZtt6vUIAXrorSlX2H52CedH6RwjJTdm
         Yh1roX2DAhcTpgIlJN1TkNapnwXE5XL2PD2kINmU=
Date:   Wed, 11 Mar 2020 15:24:01 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     p.zabel@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH 3/4] arm64: dts: imx8mp: Add src node
Message-ID: <20200311072359.GO29269@dragon>
References: <1582708431-14161-1-git-send-email-Anson.Huang@nxp.com>
 <1582708431-14161-3-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582708431-14161-3-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 05:13:50PM +0800, Anson Huang wrote:
> Add src node to support i.MX8MP reset controller.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
