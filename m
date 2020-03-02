Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 128A61758B0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 11:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbgCBKv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 05:51:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:39056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727689AbgCBKv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 05:51:56 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BD6B22B48;
        Mon,  2 Mar 2020 10:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583146316;
        bh=QhrSpr4F/VHir8Gjk0KuUg34z4MvdyKSC/6orAOEeT8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CSJj0LAt/6zmv+NRxBy9coFYVpN96bhoJ+2Yd8MYlWYa6093en9efrbDhXwq228wX
         k8G5YKkALFqlkUK+sFLVMRsycZsvWifAFOLTLkAVhWyl/uashoPabfUMFzCptaj7XC
         82IK5hOm5BD2ha/Gd1M9+8DRjhOxVGLdehNZtQzo=
Date:   Mon, 2 Mar 2020 11:51:53 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tobias Klauser <tklauser@distanz.ch>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] pty: define and set show_fdinfo only if procfs is
 enabled
Message-ID: <20200302105153.GA39968@kroah.com>
References: <20200302104954.2812-1-tklauser@distanz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302104954.2812-1-tklauser@distanz.ch>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 11:49:53AM +0100, Tobias Klauser wrote:
> Follow the pattern used with other *_show_fdinfo functions and only
> define and use pty_show_fdinfo if CONFIG_PROC_FS is set.

if proc_fs is not set, it will not be used anyway, right?

I'd rather keep #ifdef out of the .c files than add this.  How much
memory does it save, and are you using a system without procfs that
needs this savings?

thanks,

greg k-h
