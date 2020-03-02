Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 806F21758B3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 11:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbgCBKwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 05:52:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:39164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727027AbgCBKwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 05:52:11 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A0452166E;
        Mon,  2 Mar 2020 10:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583146330;
        bh=WsMtWJf8fHtIkltd+06wePwQrfCiklsvt06eqYB2nLk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UWBRIKqd6cs+yR1Un7N/DsDL34/9Nzu4ENAOKwza2+71/YwKex9wLJ2VV/hecGwzj
         HolYStWB5PBPMcj9SpxfKeMxdx8gLFvkHnQIbYz6ybQICOQ8WKNNCGXbg87a01amFP
         JlDyKS/7qMGC0pc2jTHtsD6CPJjmL4T62/24Q5nc=
Date:   Mon, 2 Mar 2020 11:52:07 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tobias Klauser <tklauser@distanz.ch>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] tty: define and set show_fdinfo only if procfs is
 enabled
Message-ID: <20200302105207.GB39968@kroah.com>
References: <20200302104954.2812-1-tklauser@distanz.ch>
 <20200302104954.2812-2-tklauser@distanz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302104954.2812-2-tklauser@distanz.ch>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 11:49:54AM +0100, Tobias Klauser wrote:
> Follow the pattern used with other *_show_fdinfo functions and only
> define and use tty_show_fdinfo if CONFIG_PROC_FS is set.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---
>  drivers/tty/tty_io.c | 4 ++++
>  1 file changed, 4 insertions(+)

Same comments here as I made on patch 1/2.

thanks,

greg k-h
