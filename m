Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 278EAED6A1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 01:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbfKDAbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Nov 2019 19:31:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:47892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727689AbfKDAbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 19:31:47 -0500
Received: from dragon (li1038-30.members.linode.com [45.33.96.30])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1592F217F5;
        Mon,  4 Nov 2019 00:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572827506;
        bh=CldERrCzQwiiIbuXrc0z7jHVBE+pqa/CxcUwR1ejtr4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tiu8kmWcTaFT3aHiUWtuePlXcjY/VFpKj886+myYPNiw3l8g5bhWfKLoXitKcs8Uf
         gFo4GQXWvKrKqsAXTNclf23W6KzSeUj72BjG102yt0PTHtfChffKRTKA/7iZruZYxs
         iegnWaQMNsf5muw9gzytng+YUhqlMJjEfMPD1GYE=
Date:   Mon, 4 Nov 2019 08:31:22 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Stefan Agner <stefan@agner.ch>
Cc:     s.hauer@pengutronix.de, linux@armlinux.org.uk,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: imx: use generic function to exit coherency
Message-ID: <20191104003121.GA24620@dragon>
References: <3f58c55e48c28f41e92883e81c675b8478af6a5e.1554937960.git.stefan@agner.ch>
 <20190416042337.GA4690@X250.skyworth_vap>
 <a99b439b8c8deb247f7ba2e6b598e808@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a99b439b8c8deb247f7ba2e6b598e808@agner.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2019 at 10:40:46PM +0100, Stefan Agner wrote:
> Hi Shawn,
> 
> On 2019-04-16 07:46, Shawn Guo wrote:
> > On Thu, Apr 11, 2019 at 01:14:12AM +0200, Stefan Agner wrote:
> >> The common ARM architecture code provides a generic function to exit
> >> coherency called v7_exit_coherency_flush(). Replace the machine
> >> specific implementation using the generic function.
> >>
> >> Tested on a i.MX 6Dual by hotplugging the secondary CPU under load
> >> through sysfs several 1000 times.
> >>
> >> Tested-by: Stefan Agner <stefan@agner.ch>
> >> Signed-off-by: Stefan Agner <stefan@agner.ch>
> > 
> > Applied, thanks.
> 
> It seems like this patch never made it upstream. Any specific reason?

It got lost due to some accident on my side.  I'm sorry for that.  I
will send it for the coming merge window.

Shawn
