Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05202ED417
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2019 19:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfKCSEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Nov 2019 13:04:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:35164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726719AbfKCSEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 13:04:07 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD8FC214D8;
        Sun,  3 Nov 2019 18:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572804246;
        bh=D8lD4+Qag1uA3Dvg4dcv+BUinmTZttJfjIYpXWhc6ko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Flf3NvE7tmmWjg1FFgw1dreV+DXgiSCJHa6Tl9Bqc3i3B8PLCiV7cZdDHDnSfkmtx
         rI4fZRvQkWw5iWrBtvHOoRnGrcNBwmfpdhnxQn2s/Z4Yi6OQtTKiDjUs5jw48Sw4j4
         Cn01ygygKAK4igIq1niQ5tNFV/tKJn4bsXscC6UU=
Date:   Sun, 3 Nov 2019 19:04:03 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        ~sircmpwn/public-inbox@lists.sr.ht
Subject: Re: [PATCH] firmware loader: log path to loaded firmwares
Message-ID: <20191103180403.GA802745@kroah.com>
References: <20191103175011.GA751209@kroah.com>
 <BY6GDXDCFDBR.1R9QENSVRGR7L@homura>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY6GDXDCFDBR.1R9QENSVRGR7L@homura>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03, 2019 at 12:55:18PM -0500, Drew DeVault wrote:
> On Sun Nov 3, 2019 at 6:50 PM Greg Kroah-Hartman wrote:
> > And it's totally noisy :(
> > 
> > Please just make this a debug call, that way you can turn it on
> > dynamically if you really want to see what firmware is attempting to be
> > loaded.
> 
> The typical setup won't need more than say, 10-20 firmwares? On my
> system I need 13, and 12 of them are just for AMDGPU. In the 20 minutes
> since I rebooted to this kernel, it constitutes less than 1% of my dmesg
> volume, and will only get less so over time unless I start hotplugging
> stuff (in which case, their respective drivers are likely to make noise,
> too). In practice, I don't think it'll be especially noisy.
> 
> On the other hand, enabling debug logs just to get this information
> would generate heaps of noise for a little bit of signal. This use-case
> isn't the exceptional case for me, on my systems I only install the
> firmwares I need so this is something I would reach for every time I set
> up a new system.

A "normal" system should not have any messages printing to the kernel
log.  All of this "look ma, I'm now loaded!" doesn't help anyone.
Printing errors is the key, that way if you see a message, it means you
need to take care of it.

If a firmware file is NOT found that is asked for, then yes, a message
should be printed out.  Isn't that the case if you do not have the
correct firmware file present?

Please never print out "Here is what the code is doing now!" type
messages to the info log, that's just noise.

thanks,

greg k-h
