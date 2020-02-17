Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B24F8160BAF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 08:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgBQHhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 02:37:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:33442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbgBQHhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 02:37:23 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBA7A206D5;
        Mon, 17 Feb 2020 07:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581925043;
        bh=VDY2oABTpanyt1tU6HxuLXGE/rCanNixHxyqOKN/yZw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NWVp358uLtUHii94+Xhi9n3eLqxGWpcPd99bMR6h7xU44nzYlwAnvrXHcgXf9sOIY
         GhWHkLZ4fD/UTq2mXk0v77vFvCAzwoD78QZ6ZYkZ4VFHqsDXfmDctck8sxfG0S/Q1d
         K1etdn9b+PqazrnxbX6dc8i2q7imq9QZOM7H3EQs=
Date:   Mon, 17 Feb 2020 15:37:16 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     linux@armlinux.org.uk, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, tglx@linutronix.de,
        rfontana@redhat.com, kstewart@linuxfoundation.org,
        allison@lohutok.net, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] ARM: imx: Remove unused include of
 linux/irqchip/arm-gic.h
Message-ID: <20200217073716.GI7973@dragon>
References: <1581649606-5118-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581649606-5118-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 11:06:46AM +0800, Anson Huang wrote:
> linux/irqchip/arm-gic.h is NOT used at all, no need to include it.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
