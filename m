Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A333419719
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2019 05:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfEJD3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 May 2019 23:29:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:38348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726806AbfEJD3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 23:29:43 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A3D52084A;
        Fri, 10 May 2019 03:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557458982;
        bh=ubGfRjTtDMEutzD5VqoWgK8VhK2vlpDqI8+UnRha5SI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lfEVBJIPxj5OqTJIYVykGxHqfqsiW4IffIXD4X/iesRS7gg14kkT95ElXmWpLuJrE
         dKBQEeUCE4PLO/t8hgW942KJ0TQeAbyyYp4faHLc2BZiECtanuh9GS9nnrqpqa3nGa
         flImr4Vb4LVaOoa8LfdsNx98mHJWMCdp4NwWuVFg=
Date:   Fri, 10 May 2019 11:29:18 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] ARM: imx_v6_v7_defconfig: Enable
 CONFIG_THERMAL_STATISTICS
Message-ID: <20190510032917.GG15856@dragon>
References: <1556076113-4593-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556076113-4593-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 03:27:13AM +0000, Anson Huang wrote:
> Enable CONFIG_THERMAL_STATISTICS to extend the sysfs interface
> for thermal cooling devices and expose some useful statistics.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

I don't apply patch using base64 encoding.

Shawn
