Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA3E55E987
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 18:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfGCQtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 12:49:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:52362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbfGCQtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 12:49:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C26812189E;
        Wed,  3 Jul 2019 16:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562172558;
        bh=5UXTFi0CEbz1XX+6Y/PdYUimmpk0z24ddtoROGBbQKs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vaRDZUAwNmHSWDt4obB6GGp8LjUm+cGa7RLT1qOKsMH3TnW3FNAM8VpppmjSqByd/
         7m+gtgDpafiA6gaAmTusuVDBVglEj//TnmYlCzQfR2PhD0TfVV6IAwuAOacUvsCMgt
         Z7jbpA+nIsOvoBWIi0N/clp0lA4rSgFtnEg2vjR8=
Date:   Wed, 3 Jul 2019 18:49:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [GIT PULL 5/9] intel_th: msu: Introduce buffer driver interface
Message-ID: <20190703164915.GA2240@kroah.com>
References: <20190627125152.54905-1-alexander.shishkin@linux.intel.com>
 <20190627125152.54905-6-alexander.shishkin@linux.intel.com>
 <20190703155547.GA32438@kroah.com>
 <87h883t6vd.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h883t6vd.fsf@ashishki-desk.ger.corp.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 07:33:58PM +0300, Alexander Shishkin wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> >> +	/*
> >> +	 * ->assign() called when buffer 'mode' is set to this driver
> >> +	 *   (aka mode_store())
> >> +	 * @device:	struct device * of the msc
> >> +	 * @mode:	allows the driver to set HW mode (see the enum above)
> >> +	 * Returns:	a pointer to a private structure associated with this
> >> +	 *		msc or NULL in case of error. This private structure
> >> +	 *		will then be passed into all other callbacks.
> >> +	 */
> >> +	void	*(*assign)(struct device *dev, int *mode);
> >> +	/* ->unassign():	some other mode is selected, clean up */
> >> +	void	(*unassign)(void *priv);
> >> +	/*
> >> +	 * ->alloc_window(): allocate memory for the window of a given
> >> +	 *		size
> >> +	 * @sgt:	pointer to sg_table, can be overridden by the buffer
> >> +	 *		driver, or kept intact
> >> +	 * Returns:	number of sg table entries <= number of pages;
> >> +	 *		0 is treated as an allocation failure.
> >> +	 */
> >> +	int	(*alloc_window)(void *priv, struct sg_table **sgt,
> >> +				size_t size);
> >> +	void	(*free_window)(void *priv, struct sg_table *sgt);
> >> +	/* ->activate():	trace has started */
> >> +	void	(*activate)(void *priv);
> >> +	/* ->deactivate():	trace is about to stop */
> >> +	void	(*deactivate)(void *priv);
> >> +	/*
> >> +	 * ->ready():	window @sgt is filled up to the last block OR
> >> +	 *		tracing is stopped by the user; this window contains
> >> +	 *		@bytes data. The window in question transitions into
> >> +	 *		the "LOCKED" state, indicating that it can't be used
> >> +	 *		by hardware. To clear this state and make the window
> >> +	 *		available to the hardware again, call
> >> +	 *		intel_th_msc_window_unlock().
> >> +	 */
> >> +	int	(*ready)(void *priv, struct sg_table *sgt, size_t bytes);
> >> +};
> >
> > Why isn't this based off of 'struct driver'?
> 
> It's not a real driver, in a sense that there's no underlying
> device. None of the usual driver stuff applies.

Then do not call it a "driver", as in the kernel we have a very
well-defined and known definition of a driver.  Call it something else
please.  Yes, naming is hard, but don't try to overload onto an already
existing name.

> It's still a set of callbacks, though. Should this be an elaborate
> comment, should I replace the word "driver" with something else?

Yes.

> I'd really like to avoid shoehorning the whole 'struct device' +
> 'struct driver' here.

Why not?  If you have a driver, just make it a real one.  It not take
all that much boiler-plate code to do so and then you get all of the
things you will want in the end anyway (sysfs representation,
attributes, auto-loading of modules, etc.)

Try doing it "for real" and see what happens.

thanks,

greg k-h
