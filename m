Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE0C169BD5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 02:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbgBXBhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Feb 2020 20:37:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:48168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727158AbgBXBhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 20:37:54 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2058A20675;
        Mon, 24 Feb 2020 01:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582508274;
        bh=IdDSEAIzy3G0SIWaiqO3m3tqDARAEbyEt3M+fp9xexg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pQ3CtsLrBAT7E30CMOvs5ttEyX9lFqWs8JQmih5EGRn3YFR/ZF9JkKDPxA38BFwql
         drppabMqQYG2BUiDTKZQS9qb8YKvk8okp2aov7c+RLrDzc04/6lD4ym8P9OJFMX2y4
         rjdgNTGSyqIzP6YZGHvv4gR8Jw9ZE8vRcSd80Utg=
Date:   Mon, 24 Feb 2020 09:37:49 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Alifer Moraes <alifer.wsdm@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        peng.fan@nxp.com, leonard.crestez@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: imx8mm-evk: add phy-reset-gpios for fec1
Message-ID: <20200224013748.GA27688@dragon>
References: <20200214192750.20845-1-alifer.wsdm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214192750.20845-1-alifer.wsdm@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 04:27:49PM -0300, Alifer Moraes wrote:
> imx8mm-evk has a GPIO connected to AR8031 Ethernet PHY's reset pin.
> 
> Describe it in the device tree, following phy's datasheet reset duration of 10ms.
> 
> Tested booting via NFS.
> 
> Signed-off-by: Alifer Moraes <alifer.wsdm@gmail.com>

Applied both, thanks.
