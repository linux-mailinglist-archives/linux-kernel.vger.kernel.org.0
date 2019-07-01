Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83C8C427CC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 15:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731948AbfFLNin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 09:38:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:57256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbfFLNim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 09:38:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8092208CA;
        Wed, 12 Jun 2019 13:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560346722;
        bh=zTTjXk6HPFKtrXGF56kPymN9VxXefIYOXj73DCi/m64=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BX9y7BKHsJp8BM8+tDxmPbBtpXd/P6njt64f1QZYq2tv//bttARdhDk/n0n1uNXQ0
         yPme7uNodBGe7RnUNUO8iKHVTmgcZNJDU4uUyAOOAMuo3jktacyzIhJprKiP4oftae
         b4F9yv4nF1UinRGsle9GoTXcj1a6b9Vf4zONYrrg=
Date:   Wed, 12 Jun 2019 15:38:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gen Zhang <blackgod016574@gmail.com>
Cc:     nico@fluxnic.net, kilobyte@angband.pl, textshell@uchuujin.de,
        mpatocka@redhat.com, daniel.vetter@ffwll.ch,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] vt: fix a missing-check bug in con_init()
Message-ID: <20190612133838.GA7748@kroah.com>
References: <20190612131506.GA3526@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612131506.GA3526@zhanggen-UX430UQ>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 09:15:06PM +0800, Gen Zhang wrote:
> In function con_init(), the pointer variable vc_cons[currcons].d, vc and 
> vc->vc_screenbuf is allocated by kzalloc(). However, kzalloc() returns 
> NULL when fails. Therefore, we should check the return value and handle 
> the error.
> 
> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> ---

What changed from v1, v2, and v3?

That always goes below the --- line.

v5 please.

thanks,

greg k-h
