Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C035318B5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2019 02:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfFAAMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 20:12:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:58694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbfFAAMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 20:12:37 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 791E026963;
        Sat,  1 Jun 2019 00:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559347956;
        bh=GGD1oFdcIDlJ6FqkekMGdawRxHreTdZHjFVN9PCi6a8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XGllllyOcRfEtT/HKNL8h1qqwTaK0KHhm77p0FWVZvY/qXX3zttyq8+Ri08THHd8f
         Ts/pUuDYgYTJs/OHUORYCmAIkB9fAF6XKzzr7JKa8uERnCmThp41trzMld251Zv2c1
         e2XUUgIIuYj9l6AZCfwjQDZnLCb0agq9yt28NlkY=
Date:   Fri, 31 May 2019 17:12:35 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Vaneet Narang <v.narang@samsung.com>,
        Maninder Singh <maninder1.s@samsung.com>,
        "terrelln@fb.com" <terrelln@fb.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        AMIT SAHRAWAT <a.sahrawat@samsung.com>,
        PANKAJ MISHRA <pankaj.m@samsung.com>
Subject: Re: [PATCH 1/2] zstd: pass pointer rathen than structure to
 functions
Message-Id: <20190531171235.7c458cf1ac1b5dd299dbf6ec@linux-foundation.org>
In-Reply-To: <20190530133519.gdkxey5lv4hrrv7q@gondor.apana.org.au>
References: <1557468704-3014-1-git-send-email-maninder1.s@samsung.com>
        <CGME20190510061311epcas5p19e9bf3d08319ac99890e03e0bd59e478@epcms5p1>
        <20190530091327epcms5p11a7725e9c01286b1a7c023737bf4e448@epcms5p1>
        <20190530133519.gdkxey5lv4hrrv7q@gondor.apana.org.au>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 May 2019 21:35:19 +0800 Herbert Xu <herbert@gondor.apana.org.au> wrote:

> On Thu, May 30, 2019 at 02:43:27PM +0530, Vaneet Narang wrote:
> > [Reminder] Any updates ?
> 
> I was assuming that Andrew was going to pick this up.  Andrew?
> 

I don't have a copy of these emails, sorry.  I wasn't cc'ed on the
originals and late in April I had a few hours of email bouncing
happening.  I got booted off all the vger lists, and it took over a
week for me to notice this due to travel :( These patches fell in that
window

Can we please have a resend, with any new acks and reviewed-by's added
on?

