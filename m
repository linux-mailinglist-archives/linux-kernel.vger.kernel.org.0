Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C039823088
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 11:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732311AbfETJjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 05:39:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:45788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727720AbfETJjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 05:39:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4115120675;
        Mon, 20 May 2019 09:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558345172;
        bh=97paCbirTPgcKhtTTI/XOi6yayJCD3/LphHtO7Xr+hQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZiQFGhkoJenionVU7dyo8z7aa0F/TpMUd3iogH6YyeMF2fGbt7yDaNkB6B+AhVqqu
         PbUXOpqQiTfGvaPzrKY/UcA2IuGEdeslZEgIIj8m/aiFJD3ZXWEJvzqH0D2ydARwNA
         DASFVwJbjox8QsLee1RuqNFLLoewSTTl2v6h7ItQ=
Date:   Mon, 20 May 2019 11:39:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] firmware: Add support for loading compressed files
Message-ID: <20190520093929.GB15326@kroah.com>
References: <20190520092647.8622-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520092647.8622-1-tiwai@suse.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 11:26:42AM +0200, Takashi Iwai wrote:
> Hi,
> 
> this is a patch set to add the support for loading compressed firmware
> files.
> 
> The primary motivation is to reduce the storage size; e.g. currently
> the amount of /lib/firmware on my machine counts up to 419MB, and this
> can be reduced to 130MB file compression.  No bad deal.
> 
> The feature adds only fallback to the compressed file, so it should
> work as it was as long as the normal firmware file is present.  The
> f/w loader decompresses the content, so that there is no change needed
> in the caller side.
> 
> Currently only XZ format is supported.  A caveat is that the kernel XZ
> helper code supports only CRC32 (or none) integrity check type, so
> you'll have to compress the files via xz -C crc32 option.
> 
> The patch set begins with a few other improvements and refactoring,
> followed by the compression support.
> 
> In addition to this, dracut needs a small fix to deal with the *.xz
> files.
> 
> Also, the latest patchset is found in topic/fw-decompress branch of my
> sound.git tree:
>   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git

After a quick review, these all look good to me, nice job.

One recommendation, can we add support for testing this to the
tools/testing/selftests/firmware/ tests?  And you did run those
regression tests to verify that you didn't get any of the config options
messed up, right? :)

thanks,

greg k-h
