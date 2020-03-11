Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 305E0181C41
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 16:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729899AbgCKPY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 11:24:56 -0400
Received: from verein.lst.de ([213.95.11.211]:59977 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729473AbgCKPYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 11:24:55 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7EEF568C65; Wed, 11 Mar 2020 16:24:53 +0100 (CET)
Date:   Wed, 11 Mar 2020 16:24:53 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        iommu@lists.linux-foundation.org, aros@gmx.com
Subject: Re: [Bug 206175] Fedora >= 5.4 kernels instantly freeze on boot
 without producing any display output
Message-ID: <20200311152453.GB23704@lst.de>
References: <bug-206175-5873@https.bugzilla.kernel.org/> <bug-206175-5873-S6PaNNClEr@https.bugzilla.kernel.org/> <CAHk-=wi4GS05j67V0D_cRXRQ=_Jh-NT0OuNpF-JFsDFj7jZK9A@mail.gmail.com> <20200310162342.GA4483@lst.de> <CAHk-=wgB2YMM6kw8W0wq=7efxsRERL14OHMOLU=Nd1OaR+sXvw@mail.gmail.com> <20200310182546.GA9268@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310182546.GA9268@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As you seem to have a mfd based usb card reader per bugzilla, can you
try the patch form Robin below?  This ensures mfd doesn't mess with the
dma mask and thus entangling it with the parent.  And please try to
reply to the actual mail.  I found some updates in bugzilla when
I checked it after I haven't seen any reply for a while, but that isn't
a very efficient way to communicate.

--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -138,7 +138,7 @@ static int mfd_add_device(struct device *parent, int id,

  	pdev->dev.parent = parent;
  	pdev->dev.type = &mfd_dev_type;
-	pdev->dev.dma_mask = parent->dma_mask;
+	pdev->dma_mask = parent->dma_mask ? *parent->dma_mask : 0;
  	pdev->dev.dma_parms = parent->dma_parms;
  	pdev->dev.coherent_dma_mask = parent->coherent_dma_mask;
