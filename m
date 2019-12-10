Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAE4C1190EE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 20:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfLJTrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 14:47:04 -0500
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:46794 "EHLO
        emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfLJTrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 14:47:03 -0500
Received: from darkstar.musicnaut.iki.fi (85-76-143-83-nat.elisa-mobile.fi [85.76.143.83])
        by emh07.mail.saunalahti.fi (Postfix) with ESMTP id DDD7EB00AE;
        Tue, 10 Dec 2019 21:46:59 +0200 (EET)
Date:   Tue, 10 Dec 2019 21:46:59 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sandro Volery <sandro@volery.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        "David S. Miller" <davem@davemloft.net>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Wambui Karuga <wambui.karugax@gmail.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Florian Westphal <fw@strlen.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Branden Bonaby <brandonbonaby94@gmail.com>,
        Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>,
        Paul Burton <paulburton@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Giovanni Gherdovich <bobdc9664@seznam.cz>,
        Valery Ivanov <ivalery111@gmail.com>
Subject: Re: [PATCH 1/2] staging: octeon: delete driver
Message-ID: <20191210194659.GC18225@darkstar.musicnaut.iki.fi>
References: <20191210091509.3546251-1-gregkh@linuxfoundation.org>
 <EFBFCF4B-745B-4B1B-A176-08CE8CADBFEA@volery.com>
 <20191210120120.GA3779155@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210120120.GA3779155@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 01:01:20PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Dec 10, 2019 at 12:40:54PM +0100, Sandro Volery wrote:
> > Doesn't octeon have drivers out of staging already?
> > What is this module for?
> 
> I have no idea :(

It's stated in the TODO file you are deleting (visible in your
patch): "This driver is functional and supports Ethernet on
OCTEON+/OCTEON2/OCTEON3 chips at least up to CN7030."

This includes e.g. some D-Link routers and Uniquiti EdgeRouters. You
can check from /proc/cpuinfo if you are running on this MIPS SoC.

A.
