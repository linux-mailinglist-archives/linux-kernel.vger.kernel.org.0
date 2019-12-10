Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36964119A05
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 22:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbfLJVs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 16:48:56 -0500
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:52986 "EHLO
        emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbfLJVsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:48:53 -0500
Received: from darkstar.musicnaut.iki.fi (85-76-143-83-nat.elisa-mobile.fi [85.76.143.83])
        by emh03.mail.saunalahti.fi (Postfix) with ESMTP id 4E14440021;
        Tue, 10 Dec 2019 23:48:49 +0200 (EET)
Date:   Tue, 10 Dec 2019 23:48:49 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     devel@driverdev.osuosl.org,
        Branden Bonaby <brandonbonaby94@gmail.com>,
        Florian Westphal <fw@strlen.de>,
        Paul Burton <paulburton@kernel.org>,
        Giovanni Gherdovich <bobdc9664@seznam.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Sandro Volery <sandro@volery.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Valery Ivanov <ivalery111@gmail.com>,
        Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>,
        "David S. Miller" <davem@davemloft.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Wambui Karuga <wambui.karugax@gmail.com>
Subject: Re: [PATCH 1/2] staging: octeon: delete driver
Message-ID: <20191210214848.GA5834@darkstar.musicnaut.iki.fi>
References: <20191210091509.3546251-1-gregkh@linuxfoundation.org>
 <EFBFCF4B-745B-4B1B-A176-08CE8CADBFEA@volery.com>
 <20191210120120.GA3779155@kroah.com>
 <20191210194659.GC18225@darkstar.musicnaut.iki.fi>
 <20191210201515.GA16912@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210201515.GA16912@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 12:15:15PM -0800, Guenter Roeck wrote:
> On Tue, Dec 10, 2019 at 09:46:59PM +0200, Aaro Koskinen wrote:
> > On Tue, Dec 10, 2019 at 01:01:20PM +0100, Greg Kroah-Hartman wrote:
> > > I have no idea :(
> > 
> > It's stated in the TODO file you are deleting (visible in your
> > patch): "This driver is functional and supports Ethernet on
> > OCTEON+/OCTEON2/OCTEON3 chips at least up to CN7030."
> > 
> > This includes e.g. some D-Link routers and Uniquiti EdgeRouters. You
> > can check from /proc/cpuinfo if you are running on this MIPS SoC.
> 
> It also results in "mips:allmodconfig" build failures in mainline
> and is for that reason being marked as BROKEN. Unfortunately,
> misguided attempts to clean it up had the opposite effect.

This was because of stubs hack added by someone - people who do not run
or care about the hardware can now break it for others with their
silly x86 "compile test"s.

A.
