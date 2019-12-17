Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42909122DEF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 15:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbfLQOFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 09:05:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:49840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728546AbfLQOFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 09:05:08 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CFE12072D;
        Tue, 17 Dec 2019 14:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576591508;
        bh=C8BgYT65KP1euTX67Gol+mm6YX0OWA84EmlCkC+xxTw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ghaJEtR9mZWoLMAQJGYZqGTpf7VBflZJlnjo/KcPR3vAqiBKwMl53Q3EnOUMEEx52
         51uDkpL1ZFFsKLgzP/qZmw+GY9ym09r+6AtYXOLgtu8thn3nBaNT6/5eCDDa0viDim
         zzuR8h7YNRi3la7wgBYaMqlIdu19FyAs9MmF3RSU=
Date:   Tue, 17 Dec 2019 15:05:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Kim, David" <david.kim@ncipher.com>
Cc:     "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Magee, Tim" <tim.magee@ncipher.com>
Subject: Re: [PATCH 1/1] drivers: misc: Add support for nCipher HSM devices
Message-ID: <20191217140505.GB3489463@kroah.com>
References: <20191217132244.14768-1-david.kim@ncipher.com>
 <20191217132244.14768-2-david.kim@ncipher.com>
 <20191217133234.GB3362771@kroah.com>
 <823cb0c0263c441aaaf256169de5a816@exukdagfar01.INTERNAL.ROOT.TES>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <823cb0c0263c441aaaf256169de5a816@exukdagfar01.INTERNAL.ROOT.TES>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 01:53:06PM +0000, Kim, David wrote:
> Hi Greg,
> 
> Thanks for the speedy replies. Yes, I will add more background
> information and make the quick formatting changes for a v2. We'll
> reply to your other email comments and get those resolved as well. I
> was trying to be terse but looks like I was too terse. I thought the
> changelog text should be brief and the cover letter would be more
> verbose?

cover letters do not end up in the kernel changelog.

And there's no need for a cover letter for a 1 patch series.  Only for
multiple patches if it's not obvious what is going on here.

thanks,

greg k-h
