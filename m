Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 692C4FEC77
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2019 14:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbfKPNhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Nov 2019 08:37:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:48582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727550AbfKPNhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 08:37:51 -0500
Received: from localhost (unknown [84.241.192.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 697C5206D4;
        Sat, 16 Nov 2019 13:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573911471;
        bh=4eG+yDvjMwuZM3qEKV2iKWsXoSWX+P56snK74/mDAc4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LWTHRGNmMnVg/xULDHUr9p7qtjDfA0IkjgDoFg41w4CoI7xn99sv8JvO3fPcvJCHf
         WWl990DZ+SE68hUCsk/ngO7lMwJ0nUqqWTnWSwu3NfczY98fEQq02BFYHuaT5gMYZE
         A4GDoTz3I7wA3yBaYcWoe550a2Zo9BavZfzoszFo=
Date:   Sat, 16 Nov 2019 14:37:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        colin.king@canonical.com, mmoese@suse.de, sashal@kernel.org
Subject: Re: 8250-men-mcb: fix signed/unsigned confusion
Message-ID: <20191116133748.GB454551@kroah.com>
References: <20191115125234.GC29996@duo.ucw.cz>
 <20191115150942.GA375649@kroah.com>
 <20191115211351.GB30273@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115211351.GB30273@duo.ucw.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 10:13:51PM +0100, Pavel Machek wrote:
> On Fri 2019-11-15 23:09:42, Greg KH wrote:
> > On Fri, Nov 15, 2019 at 01:52:34PM +0100, Pavel Machek wrote:
> > > Hi!
> > > 
> > > Commit 5210a3a722543fc25b8830d2236dcbe2c8178468 fixes part of
> > > signed/unsigned confusion, but not all of it.
> > > 
> > > 8250-men-mcb: fix error checking when get_num_ports returns -ENODEV
> > > Upstream commit f50b6805dbb993152025ec04dea094c40cc93a0c
> > > 
> > > Fix function returning -ENODEV to signed prototype, and make error
> > > check consistent between two functions.
> > > 
> > > Signed-off-by: Pavel Machek <pavel@denx.de>
> > > 
> > 
> > Hi,
> > 
> > This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> > a patch that has triggered this response.  He used to manually
> > respond
> 
> Not sure what is supposed to be friendly about this bot.

How was it not?  Did it not say exactly what was wrong with the patch
and how to change it to make it acceptable?

> Anyway, it would be nice if authors of
> 5210a3a722543fc25b8830d2236dcbe2c8178468 picked this up. I have no way
> to test it.

As the bot said, this patch is not acceptable as-is, sorry.  There's no
way it can be 'picked up' in this format.

thanks,

greg k-h
