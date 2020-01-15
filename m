Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97E2213CACD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 18:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbgAORVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 12:21:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:49032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727016AbgAORVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 12:21:10 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8840C207FF;
        Wed, 15 Jan 2020 17:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579108870;
        bh=dUOS7Sbd/0yMtiwpyUyOXAg054W2R7jVPYgksxRkGAc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EC8bKknXcmw+4ysBdgdqSuUlqY6Man3IhZCLgHBbZUT/MfA28EPsoq1XUDymjZNDB
         0MzUg3fNBDTHYrbJAlV4XfzQVgShuujpjJ8ETKhkso4zKT4X3XHgA6jmF9B91xGzdZ
         PknufLsPoKRSmRd6VblqBsy8cFg3c6pDCHfK6iFE=
Date:   Wed, 15 Jan 2020 18:21:06 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] tty: baudrate: Synchronise baud_table[] and
 baud_bits[]
Message-ID: <20200115172106.GA4127163@kroah.com>
References: <20200114170917.36947-1-andriy.shevchenko@linux.intel.com>
 <20200114172756.GA2052011@kroah.com>
 <20200115163327.GF32742@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115163327.GF32742@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 06:33:27PM +0200, Andy Shevchenko wrote:
> On Tue, Jan 14, 2020 at 06:27:56PM +0100, Greg Kroah-Hartman wrote:
> > On Tue, Jan 14, 2020 at 07:09:17PM +0200, Andy Shevchenko wrote:
> > > Synchronize baud rate tables for better readability.
> > 
> > "Synchronize"?  With what?
> 
> Between each other. This SPARC thingy makes it's harder to follow.

Ok, be more specific please, a better changelog is key here.

> > Why?  I'm all for cleaning up code, but this
> > just seems totally gratuitous.
> 
> Btw, while doing it I found that SPARC actually supports more baud rates than
> defined in those arrays. Without this patch I would not (easily) notice that.
> Should I also attach another patch and resend?

Yes, that might justify this patch's acceptance :)

thanks,

greg k-h
