Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A677151654
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 08:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgBDHPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 02:15:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:55156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgBDHPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 02:15:51 -0500
Received: from localhost (unknown [167.98.85.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39F7621582;
        Tue,  4 Feb 2020 07:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580800550;
        bh=K79BsejKQ50ooIm4cS9/TH4bKCFwVULRlWaG1bw1O3g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MJ8LifNB43rUOT4G3OQdF9A7P8ClC6nqiWgyxcO+68PtUHKi0uaXE+On8By4kSPjH
         j7LPyxfEbj9xf5tjAgzsSvqpXGQQo9VlyvScilYKOG9JMjFMKVzTleteVTvcrj9rBI
         ZVJOsOebEvGU7vO7rXRVJ6zKPmEVxOgaQ+rAQ/MA=
Date:   Tue, 4 Feb 2020 07:15:48 +0000
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "ddaney.cavm@gmail.com" <ddaney.cavm@gmail.com>,
        "pundirsumit11@gmail.com" <pundirsumit11@gmail.com>,
        "aaro.koskinen@iki.fi" <aaro.koskinen@iki.fi>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nishkadg.linux@gmail.com" <nishkadg.linux@gmail.com>,
        "frank@generalsoftwareinc.com" <frank@generalsoftwareinc.com>,
        "laura.lazzati.15@gmail.com" <laura.lazzati.15@gmail.com>
Subject: Re: [PATCH 2/2] staging: octeon-usb: delete the octeon usb host
 controller driver
Message-ID: <20200204071548.GB966981@kroah.com>
References: <20191210091509.3546251-1-gregkh@linuxfoundation.org>
 <20191210091509.3546251-2-gregkh@linuxfoundation.org>
 <e97e28140b8c46cde93f40b93e2e0614943e96fc.camel@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e97e28140b8c46cde93f40b93e2e0614943e96fc.camel@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2020 at 04:06:51AM +0000, Chris Packham wrote:
> On Tue, 2019-12-10 at 10:15 +0100, Greg Kroah-Hartman wrote:
> > This driver was merged back in 2013 and shows no progress toward every
> > being merged into the "correct" part of the kernel.  The code doesn't
> > even build for anyone unless you have the specific hardware platform
> > selected, so odds are it doesn't even work anymore.
> > 
> > Remove it for now and is someone comes along that has the hardware and
> > is willing to fix it up, it can be reverted.
> > 
> > Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> > Cc: David Daney <ddaney.cavm@gmail.com>
> > Cc: Nishka Dasgupta <nishkadg.linux@gmail.com>
> > Cc: Himadri Pandya <himadri18.07@gmail.com>
> > Cc: "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>
> > Cc: Sumit Pundir <pundirsumit11@gmail.com>
> > Cc: Laura Lazzati <laura.lazzati.15@gmail.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> 
> Similarly we'd really like to keep this too.

Great, same thing here!

thanks,

greg k-h
