Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77442196724
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Mar 2020 16:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgC1Pqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Mar 2020 11:46:34 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:36214 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbgC1Pqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 11:46:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=wlJqkxRRXoHkvfGNC7ThSX8ifdNIpM+JFBZbKfXI4dc=; b=sfXpORxAfmX78jNpi5qBk5S0Jz
        xc+gnQyt0s1wSjsLKR06suBxTLvyFJI2ANEwdfB52etPYA4I6ccydXukQcQvBosKCDvkXDsec0s9a
        HdkC98I28duE+pXTu5tN3jtUTrBYfTWHDZYyLCVS0+KaRPJUuLZ1vZ7YGGkA8Yt1A7V8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jIDf7-0003ty-Lk; Sat, 28 Mar 2020 16:46:17 +0100
Date:   Sat, 28 Mar 2020 16:46:17 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Russell King <rmk+kernel@arm.linux.org.uk>,
        Jason Cooper <jason@lakedaemon.net>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: clarify maintenance of ARM Dove drivers
Message-ID: <20200328154617.GX3819@lunn.ch>
References: <20200328134304.7317-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200328134304.7317-1-lukas.bulwahn@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 28, 2020 at 02:43:04PM +0100, Lukas Bulwahn wrote:
> Commit 44e259ac909f ("ARM: dove: create a proper PMU driver for power
> domains, PMU IRQs and resets") introduced new drivers for the ARM Dove SOC,
> but did not add those drivers to the existing entry ARM/Marvell
> Dove/MV78xx0/Orion SOC support in MAINTAINERS. Hence, these drivers were
> considered to be part of "THE REST".
> 
> Clarify now that these drivers are maintained by the ARM/Marvell
> Dove/MV78xx0/Orion SOC support maintainers. Also order the T: entry to the
> place it belongs to, while at it.
> 
> This was identified with a small script that finds all files only belonging
> to "THE REST" according to the current MAINTAINERS file, and I acted upon
> its output.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
