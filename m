Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92892ED9DD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 08:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfKDH0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 02:26:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:44618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbfKDH0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 02:26:34 -0500
Received: from dragon (li1038-30.members.linode.com [45.33.96.30])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3BF3204EC;
        Mon,  4 Nov 2019 07:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572852393;
        bh=AVoiLB6IVvsYuC6vQPF0aZMrx18lotS/wxMPFiWsvok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x3C97sh/HCvE3dWBUhREoMCsTpKkvH8VdH1Kj7MQS7T3JWXvQv0XKDLV2x/47D2aH
         x8Mrt4WjdlL8hbZ7Nb4l7gj9yVXtNkqWKFFfDkn/dd/FbHaMNaeRuOfvWTIJ+wKg82
         U9NMb5jQvoeiOGAQamcC0oaTvsOZpPV8NKdOtlJQ=
Date:   Mon, 4 Nov 2019 15:26:08 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "mripard@kernel.org" <mripard@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH] arm64: defconfig: Change CONFIG_AT803X_PHY from m to y
Message-ID: <20191104072607.GP24620@dragon>
References: <1572848275-30941-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572848275-30941-1-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 06:19:30AM +0000, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> With phy-reset-gpios are enabled for i.MX8MM-EVK board, phy
> will be reset. Without CONFIG_AT803X_PHY as y, board will stop
> booting in NFS DHCP, because phy is not ready. So mark
> CONFIG_AT803X_PHY from m to y to make board boot when using nfs rootfs.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks.
