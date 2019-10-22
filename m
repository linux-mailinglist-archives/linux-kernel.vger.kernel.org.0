Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71FD0E0881
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 18:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389325AbfJVQQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 12:16:56 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43837 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387575AbfJVQQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:16:55 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1iMwq5-0000qx-Sz; Tue, 22 Oct 2019 18:16:53 +0200
Message-ID: <0925a763d31cf8055184247f272ea29af866c0ea.camel@pengutronix.de>
Subject: Re: [PATCH] MAINTAINERS: add reset controller framework keywords
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Cc:     kernel@pengutronix.de
Date:   Tue, 22 Oct 2019 18:16:53 +0200
In-Reply-To: <5db6c53e5c87ca2999c577333d9c6df678b36994.camel@perches.com>
References: <20191022123823.4854-1-p.zabel@pengutronix.de>
         <5db6c53e5c87ca2999c577333d9c6df678b36994.camel@perches.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-10-22 at 09:03 -0700, Joe Perches wrote:
> On Tue, 2019-10-22 at 14:38 +0200, Philipp Zabel wrote:
> > Add a regex that matches users of the reset controller API.
> []
> > diff --git a/MAINTAINERS b/MAINTAINERS
> []
> > @@ -13851,6 +13851,7 @@ F:	include/dt-bindings/reset/
> >  F:	include/linux/reset.h
> >  F:	include/linux/reset/
> >  F:	include/linux/reset-controller.h
> > +K:	\b(devm_|of_)?reset_control(ler_[a-z]+|_[a-z_]+)?\b
> 
> Please add ?: to each group so no capture is done.
> It's a little faster.
> 
> K:	\b(?:devm_|of_)?reset_control(?:ler_[a-z]+|_[a-z_]+)?\b

Thank you, fixed in v2.

regards
Philipp

