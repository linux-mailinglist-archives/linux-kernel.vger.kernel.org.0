Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3811B1000D9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 09:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfKRI7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 03:59:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:45804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbfKRI7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 03:59:37 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F28B20727;
        Mon, 18 Nov 2019 08:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574067577;
        bh=AaTzF3cJV8Sg3eBg3hJbaGH/Qs9golmuYlRDaHIVe1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bAKBqW11oMQS19BrtGVHxwBqbPE7uYwcEEy0g21zDgZPA9XwPysrQA20v0zDXI3C+
         wH2ekGVRYjXy2LH3ppBX/LUq1WfrS1CJcDyGBDLktil3JkGzjHQJxTJIBW5rctXBsZ
         yV1zIOtbU0QPfxf0u3lwNJrtByj6SbCPfNeYudV0=
Date:   Mon, 18 Nov 2019 09:59:33 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     patrick.rudolph@9elements.com
Cc:     linux-kernel@vger.kernel.org, coreboot@coreboot.org,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arthur Heymans <arthur@aheymans.xyz>
Subject: Re: [Patch v2 1/3] firmware: google: Release devices before
 unregistering the bus
Message-ID: <20191118085933.GA150384@kroah.com>
References: <20191118083903.19311-1-patrick.rudolph@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191118083903.19311-1-patrick.rudolph@9elements.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 09:38:58AM +0100, patrick.rudolph@9elements.com wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Fix a bug where the kernel module can't be loaded after it has been
> unloaded as the devices are still present and conflicting with the
> to be created coreboot devices.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> ---
>  drivers/firmware/google/coreboot_table.c | 7 +++++++
>  1 file changed, 7 insertions(+)

You forgot to document what changed from v1 of this patch and/or series
somewhere :(

Usually it just goes below the --- line on each patch.

Can you fix that up and send a v3 of this series?

thanks

greg k-h
