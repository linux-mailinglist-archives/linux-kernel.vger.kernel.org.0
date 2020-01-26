Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43719149A91
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jan 2020 13:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387431AbgAZMsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jan 2020 07:48:38 -0500
Received: from bmailout2.hostsharing.net ([83.223.78.240]:54833 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387398AbgAZMsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 07:48:37 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id A0D572800BB69;
        Sun, 26 Jan 2020 13:48:34 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 6BC3042A3A; Sun, 26 Jan 2020 13:48:34 +0100 (CET)
Date:   Sun, 26 Jan 2020 13:48:34 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Matthew Whitehead <tedheadster@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vt: Fix non-blinking cursor regression
Message-ID: <20200126124834.ea7uxyprz2uaek5x@wunner.de>
References: <575cb82102aa59a7a8e34248821b78e1dd844777.1579701673.git.lukas@wunner.de>
 <nycvar.YSQ.7.76.2001221032210.1655@knanqh.ubzr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.76.2001221032210.1655@knanqh.ubzr>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 11:40:38AM -0500, Nicolas Pitre wrote:
> On Wed, 22 Jan 2020, Lukas Wunner wrote:
> > Since commit a6dbe4427559 ("vt: perform safe console erase in the right
> > order"), when userspace clears both the scrollback buffer and the screen
> > by writing "\e[3J" to an fbdev virtual console, the cursor stops blinking
> > if that virtual console is not in the foreground.  I'm witnessing this
> > on every boot of Raspbian since updating to v4.19.37+ because agetty
> > writes the sequence to /dev/tty6 while the console is still switched to
> > /dev/tty1.  Switching consoles once makes the cursor blink again.
> > 
> > The commit added an invocation of ->con_switch() to flush_scrollback().
> > Normally this is only invoked from switch_screen() to switch consoles.
> > switch_screen() updates *vc->vc_display_fg to the new console and
> > fbcon_switch() updates ops->currcon.  Because the commit only invokes
> > fbcon_switch() but doesn't update *vc->vc_display_fg, it performs an
> > incomplete console switch.
> > 
> > When fb_flashcursor() subsequently blinks the cursor, it retrieves the
> > foreground console from ops->currcon.  Because *vc->vc_display_fg wasn't
> > updated, con_is_visible() incorrectly returns false and as a result,
> > fb_flashcursor() bails out without blinking the cursor.
> > 
> > The invocation of ->con_switch() appears to have been erroneous.  After
> > all, why should a console switch be performed when clearing the screen?
> > The commit message doesn't provide a rationale either.  So delete it.
> 
> The problem here is that only vgacon provides a con_flush_scrollback 
> method. When not provided, the only way to flush the scrollback buffer 
> is to invoke the switch method. If you remove it the scrollback buffer 
> of the foreground console won't be flushed in the fb case and possibly 
> others.

Okay.  I guess it's somewhat counter-intuitive that ->con_switch()
is called only because it has the side effect of flushing scrollback.
In particular, this approach doesn't work for nonvisible consoles.

So the proper solution might be to amend the fb_con struct with a
->con_flush_scrollback() hook.  Which portions of fbcon_switch()
would have to be duplicated in that hook?  The softback code at the
top of the function would seem like an obvious candidate.  What about
the invocation of fb_set_var() (which in turn calls fb_pan_display())?
Anything else?

FWIW, even without any call to ->con_switch, writing "\e[3J" does
flush scrollback.  Works both on the foreground console as well as
nonvisible consoles.  I've tested this with bcm2708_fb which isn't
upstream yet, it's in the Raspberry Pi Foundation's downstream tree:

https://github.com/raspberrypi/linux/blob/rpi-4.19.y/drivers/video/fbdev/bcm2708_fb.c


> @@ -936,10 +936,13 @@ static void flush_scrollback(struct vc_data *vc)
>  	WARN_CONSOLE_UNLOCKED();
>  
>  	set_origin(vc);
> -	if (vc->vc_sw->con_flush_scrollback)
> +	if (vc->vc_sw->con_flush_scrollback) {
>  		vc->vc_sw->con_flush_scrollback(vc);
> -	else
> +	} else if (con_is_visible(vc)) {
> +		hide_cursor(vc);
>  		vc->vc_sw->con_switch(vc);
> +		set_cursor(vc);
> +	}

A dumb question perhaps, but why is it necessary to hide the cursor?

Thanks,

Lukas
