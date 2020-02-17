Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF00160BB7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 08:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgBQHiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 02:38:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:34074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbgBQHiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 02:38:20 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D93D206D5;
        Mon, 17 Feb 2020 07:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581925099;
        bh=fmxK/uvyf7c74xfGqAVYRBOfvVEdNPJ790VJ9J3SDGU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PurvmfocWVvFbzfgSlQYJ4vlb5doeN65jW+JM13GOpjBYu/Cd0WGbsQtZI97zCc0S
         XQc+70DtwOZ5Qf4YFJ41CyowWIRnu3KK0OEjaAm1hrT22kFaY9A8rdewUql8ZMPajm
         p2nu5zu1sVxGXuCdNgR9lP9da64xCGsqxV7Bf6zI=
Date:   Mon, 17 Feb 2020 15:38:12 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     linux@armlinux.org.uk, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        kstewart@linuxfoundation.org, info@metux.net, allison@lohutok.net,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH] ARM: imx: Remove unused include of linux/of.h on
 mach-imx6sl.c
Message-ID: <20200217073811.GK7973@dragon>
References: <1581660711-1301-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581660711-1301-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 02:11:51PM +0800, Anson Huang wrote:
> linux/of.h is NOT used on mach-imx6sl.c, remove it.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
