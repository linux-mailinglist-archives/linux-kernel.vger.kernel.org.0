Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69A69136ABA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 11:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbgAJKOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 05:14:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:35088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727168AbgAJKOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 05:14:49 -0500
Received: from localhost (83-84-126-242.cable.dynamic.v4.ziggo.nl [83.84.126.242])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF968206ED;
        Fri, 10 Jan 2020 10:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578651288;
        bh=m3v2hiPkxyW8CXgNiJweXbctYxcfQ6knkoXa1CcVk7w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P2g697haUvgnnoNyU6+vBUNtB5ojLxHexJl3a1rYROGBzbSuEmG10g89+DMRnWwzf
         SmBDp5QEccClRXkOcJbm2W1bl/nDluLcEVVhol1LfiLB+jz2cuAJrtE7Lr1jDAWB+/
         DIa+xX7DWrXPRxZJSAg/1J35A/3JM+4Wvl4VYdUM=
Date:   Fri, 10 Jan 2020 11:14:46 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: always relink the port
Message-ID: <20200110101446.GA537059@kroah.com>
References: <20191227174434.12057-1-sudipm.mukherjee@gmail.com>
 <20200110100817.GA4273@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110100817.GA4273@localhost>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 11:08:17AM +0100, Johan Hovold wrote:
> On Fri, Dec 27, 2019 at 05:44:34PM +0000, Sudip Mukherjee wrote:
> > If the serial device is disconnected and reconnected, it re-enumerates
> > properly but does not link it. fwiw, linking means just saving the port
> > index, so allow it always as there is no harm in saving the same value
> > again even if it tries to relink with the same port.
> 
> This is a pretty vague description. Commit fb2b90014d78 ("tty: link tty
> and port before configuring it as console") completely broke usb-serial
> (and anything else hotpluggable) which obviously depends on being able
> to reuse a minor number when a new device is later plugged in after a
> disconnect.
> 
> Things are crashing left and right due to that stale port-pointer, and I
> just had to debug this only to find that this one is sitting in the
> tty-linus branch. I know, I know, Christmas and all, but would be nice
> to get it into -rc6. :)

Sorry, yes, my fault, will get to Linus either today or tomorrow.

> > Fixes: fb2b90014d78 ("tty: link tty and port before configuring it as console")
> 
> Also note that the offending commit had a stable tag unlike this one.

I'll pick it up properly, I have held off on adding the original to the
stable trees yet.

thanks,

greg k-h
