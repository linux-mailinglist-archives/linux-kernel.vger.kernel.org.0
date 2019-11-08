Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 658F8F519E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 17:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfKHQxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 11:53:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:43090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbfKHQxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 11:53:12 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7F7C2178F;
        Fri,  8 Nov 2019 16:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573231992;
        bh=wCFPCJjeLp/mKUX4a3nBezjesoDUvdEgEo0knwJoKiw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nBYjcowddhlr9DrZa28wAXpkV7VCFVTL2XVfAtFdK1ft/AvMzEZQb63K4uLIQeVnT
         vXTNJEAmY7sU1jih6pNGaWPDkjpyRlPpWm0zNdR8y1xZ0iqxmp+ZBt3gLq92f+d8FJ
         w/PmfsLNGi7pRMtpMzy3kbAVqbxnsAoEYyprL6ZI=
Date:   Fri, 8 Nov 2019 17:53:09 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: most: Convert to the common vmalloc memalloc
Message-ID: <20191108165309.GA1168209@kroah.com>
References: <20191108164528.998-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108164528.998-1-tiwai@suse.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2019 at 05:45:28PM +0100, Takashi Iwai wrote:
> The recent change (*) in the ALSA memalloc core allows us to drop the
> special vmalloc-specific allocation and page handling.  This patch
> coverts to the common code.
> (*) 1fe7f397cfe2: ALSA: memalloc: Add vmalloc buffer allocation
>                   support
>     7e8edae39fd1: ALSA: pcm: Handle special page mapping in the
>                   default mmap handler
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> 
> ---
> 
> Since the prerequisite commits above are found only on for-next branch
> of sound git tree, please give ACK if the patch is OK; then I'll apply
> it on top of my branch.  Thanks!
> 
> 

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
