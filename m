Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8F4713B3CE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 21:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbgANUtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 15:49:19 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34129 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728656AbgANUtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 15:49:18 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1irT7j-0005Fo-Vw; Tue, 14 Jan 2020 21:49:15 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1irT7j-0003jC-38; Tue, 14 Jan 2020 21:49:15 +0100
Date:   Tue, 14 Jan 2020 21:49:15 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thorsten Scherer <thorsten.scherer@eckelmann.de>,
        Nishad Kamdar <nishadkamdar@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] siox: Use the correct style for SPDX License
 Identifier
Message-ID: <20200114204914.o34qu2h7neoynpvs@pengutronix.de>
References: <20200101131418.GA3110@nishad>
 <20200107063250.GA30387@ws067.eckelmann.group>
 <20200107073204.k4t25kchrpczekfc@pengutronix.de>
 <20200114204734.GA2221856@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200114204734.GA2221856@kroah.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 09:47:34PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Jan 07, 2020 at 08:32:04AM +0100, Uwe Kleine-König wrote:
> > Hello,
> > 
> > On Tue, Jan 07, 2020 at 07:32:50AM +0100, Thorsten Scherer wrote:
> > > On Wed, Jan 01, 2020 at 06:44:23PM +0530, Nishad Kamdar wrote:
> > > > This patch corrects the SPDX License Identifier style in
> > > > header file related to Eckelmann SIOX driver.
> > > > For C header files Documentation/process/license-rules.rst
> > > > mandates C-like comments (opposed to C source files where
> > > > C++ style should be used).
> > > > 
> > > > Changes made by using a script provided by Joe Perches here:
> > > > https://lkml.org/lkml/2019/2/7/46.
> > > > 
> > > > Suggested-by: Joe Perches <joe@perches.com>
> > > > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > > > Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > 
> > > Acked-by: Thorsten Scherer <thorsten.scherer@eckelmann.de>
> > 
> > Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> Ah, this is why I had 2 acks, you acked it twice :)

Ah, didn't even notice that v2 came with my ack already.

..ooOO(Acked-intensively-by: ...)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
