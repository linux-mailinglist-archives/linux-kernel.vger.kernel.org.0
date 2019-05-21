Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20C3A2464A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 05:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfEUD0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 23:26:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54430 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfEUD0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 23:26:23 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5BCBF151420;
        Mon, 20 May 2019 23:26:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=LVuPGpXr80mFouDhZEE1IjAN6jw=; b=BgGP1F
        IVT8K9uI4GkRommMJwMDnWP59DaDWWqxkLFICYYswPxFLn7/Crtvb9zqliN73XtJ
        9xAX+GoPwBAT3+BnWd3jIYFy/rCH1F9bVohs7n9Mvj2g9JKOFpdfGAIFHYUM1xVL
        LjJHF5Y04W3qRYzkSyOR7K9uKKQkzx53mavhI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 536CD15141E;
        Mon, 20 May 2019 23:26:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=oVvGLlqFaKaJTDSYhHZSKXhIQqqadHQ/RfPlc0WJLwQ=; b=yZ/D4gWH/UsL7VX9SUehU1p/R22XTdy8vXXXqD7BOCzdXptKZN8knqLe3ncDo86uqCijZwdIVGTUToUwWmpSka1tTitpMIxiDD45cekeVWpNtRnReQbt/FDDwM9zHyIYB2A2ZtwYOu5yDWzNWTgepkoWlEOFJdGkUCicz3/Q59A=
Received: from yoda.home (unknown [70.82.130.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CAEAF15141C;
        Mon, 20 May 2019 23:26:21 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id E193C2DA01F4;
        Mon, 20 May 2019 23:26:20 -0400 (EDT)
Date:   Mon, 20 May 2019 23:26:20 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Gen Zhang <blackgod016574@gmail.com>
cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vt: Fix a missing-check bug in drivers/tty/vt/vt.c
In-Reply-To: <20190521030905.GB5263@zhanggen-UX430UQ>
Message-ID: <nycvar.YSQ.7.76.1905202323290.1558@knanqh.ubzr>
References: <20190521022940.GA4858@zhanggen-UX430UQ> <nycvar.YSQ.7.76.1905202242410.1558@knanqh.ubzr> <20190521030905.GB5263@zhanggen-UX430UQ>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 347E308E-7B78-11E9-B326-E828E74BB12D-78420484!pb-smtp2.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 May 2019, Gen Zhang wrote:

> On Mon, May 20, 2019 at 10:55:40PM -0400, Nicolas Pitre wrote:
> > On Tue, 21 May 2019, Gen Zhang wrote:
> > 
> > > In function con_init(), the pointer variable vc_cons[currcons].d, vc and
> > > vc->vc_screenbuf is allocated a memory space via kzalloc(). And they are
> > > used in the following codes.
> > > However, when there is a memory allocation error, kzalloc() can fail.
> > > Thus null pointer (vc_cons[currcons].d, vc and vc->vc_screenbuf)
> > > dereference may happen. And it will cause the kernel to crash. Therefore,
> > > we should check return value and handle the error.
> > > Further,the loop condition MIN_NR_CONSOLES is defined as 1 in
> > > include/uapi/linux/vt.h. So there is no need to unwind the loop.
> > 
> > But what if someone changes that define? It won't be obvious that some 
> > code did rely on it to be defined to 1.
> I re-examine the source code. MIN_NR_CONSOLES is only defined once and
> no other changes to it.

Yes, that is true today.  But if someone changes that in the future, how 
will that person know that you relied on it to be 1 for not needing to 
unwind the loop?


Nicolas
