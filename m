Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63DECD0B31
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 11:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbfJIJaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 05:30:07 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:55575 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfJIJaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 05:30:07 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iI8IA-00039Q-DI; Wed, 09 Oct 2019 11:29:58 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iI8I6-0000CY-DP; Wed, 09 Oct 2019 11:29:54 +0200
Date:   Wed, 9 Oct 2019 11:29:54 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Anson Huang <Anson.Huang@nxp.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <Linux-imx@nxp.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] tty: serial: imx: Only get second/third IRQ when there
 is more than one IRQ
Message-ID: <20191009092954.srlx5wjaqueps7nz@pengutronix.de>
References: <1570601911-9162-1-git-send-email-Anson.Huang@nxp.com>
 <20191009065315.wgdvmkv6skteyul4@pengutronix.de>
 <CAHp75VcWXT+j5cfVzxPL+3YdgR+3uhFSb0qEDRr4YL+WenVKUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VcWXT+j5cfVzxPL+3YdgR+3uhFSb0qEDRr4YL+WenVKUQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 11:12:20AM +0300, Andy Shevchenko wrote:
> On Wed, Oct 9, 2019 at 9:53 AM Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> 
> > The patch is fine given the changed behaviour of platform_get_irq. I
> > wonder if it is sensible to introduce a variant of platform_get_irq (say
> > platform_get_irq_nowarn) that behaves like __platform_get_irq does
> > today. Then the imx driver would just call platform_get_irq_nowarn
> > without having to check the number of available irqs first.
> 
> It's being discussed in parallel thread about
> platform_get_irq_optional() which won't issue a warning.

This is even already in 5.4-rc1 as
8973ea47901c81a1912bd05f1577bed9b5b52506.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
