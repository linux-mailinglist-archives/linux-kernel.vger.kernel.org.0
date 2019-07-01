Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE53C3BAD6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2019 19:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbfFJRVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jun 2019 13:21:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbfFJRVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 13:21:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F6C0207E0;
        Mon, 10 Jun 2019 17:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560187292;
        bh=Lm5P1ceVLbTYoNroDvHEIRxfS8FyHNbcWWxeUeBhtcE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jYg/+tbHWAcMQf5Ibun/J5I53WSAWyTQiHowEJRVRTjQxQeys7V5lSFOOEtNliLuP
         1y9tGkGpsPT3aAtgOb8nhtKeSq/PKBdzP68ldDWOuhEDUnKNrZexoluxbU8+/bwGO/
         G58Cq4O01hTLul3ElmnoMXqk8rQ2MyAbatDnQkqM=
Date:   Mon, 10 Jun 2019 19:21:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] firmware: Add support for loading compressed files
Message-ID: <20190610172130.GA28902@kroah.com>
References: <20190520092647.8622-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520092647.8622-1-tiwai@suse.de>
User-Agent: Mutt/1.12.0 (2019-05-25)
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

I've applied the first 3 patches to my tree, as they were sane and good
cleanups.

I'll wait for a test-case and a resend of the second two before taking
them {hint} :)

thanks,

greg k-h
