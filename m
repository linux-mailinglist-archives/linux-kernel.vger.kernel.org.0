Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44F7C4C77B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 08:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfFTG2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 02:28:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbfFTG2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 02:28:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B046C208CB;
        Thu, 20 Jun 2019 06:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561012104;
        bh=G6fzKkxKaBuBBRGdRCWmcE1NwVFNNv3wkwUTRPXsdxE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UdoCx5fcVqqo8jDUuKNUQLf06KJ+DpmFbMN0cG56VsogNo6yh/u20r3++yJAClvX/
         ZDmAEjYIAFAXL8kQO0Taa9hwPR60mkCcCbRfPZWLeIey4cWwP/ZrHSE+7Rb0AuHf50
         ThPx7IKXijX8ErZt8dwVabPjXYT8+IoR8+nyOsjc=
Date:   Thu, 20 Jun 2019 08:28:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/3] Automatically choose a bigger font for high
 resolution screens
Message-ID: <20190620062821.GA20578@kroah.com>
References: <20190618203425.10723-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618203425.10723-1-tiwai@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 10:34:22PM +0200, Takashi Iwai wrote:
> Hi,
> 
> this is an RFC patch for automatically selecting a bigger font for
> high resolution monitors if available.  Although we recently got a
> 16x32 sized font support in the kernel, using it still requires some
> extra kernel option.  This patch reduces this and the kernel will pick
> up a bigger font.
> 
> The logic is simply checking the text screen size.  If it's over a
> threshold, the penalty is given to the function that chooses the
> default font.
> 
> The threshold was chosen so that the normal display up to Full HD
> won't be affected.
> 
> There are two preliminary patches and they are merely cleanups.  They
> can be applied no matter whether to take the last patch or not.

I applied the first two patches, as they seem sane.

I like the idea of the last one, and have no objections to it.  I can
apply it too if you want and we can see what happens :)

thanks,

greg k-h
