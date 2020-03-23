Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C25C18EFE0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 07:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbgCWGjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 02:39:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:47662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbgCWGjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 02:39:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C864206F8;
        Mon, 23 Mar 2020 06:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584945553;
        bh=z5fSvYP4ouXGOFsdEDEip3PczkCR4am1DJGyw4qKsyQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DW+yW3ax98cblVAISFyoEZLJBhDgezJos/DtLXhMPVaTfRUnTlcNymGwe0QEnbvKY
         cZDPtOuD3vh1odqV0AKFcG85IWMxR3F99OOuVt9koYwzlt4/0CggwHAez0nTmGSIpp
         LwPTx1MgRMbFkPoHZcBIb4hadSqoSE3H1ZALxDm8=
Date:   Mon, 23 Mar 2020 07:39:09 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kyungtae Kim <kt0755@gmail.com>
Cc:     laurentiu.tudor@nxp.com, noring@nocrew.org,
        chunfeng.yun@mediatek.com, felipe.balbi@linux.intel.com,
        tweek@google.com, tony@atomide.com, rrangel@chromium.org,
        m.szyprowski@samsung.com, Dave Tian <dave.jing.tian@gmail.com>,
        linux-usb@vger.kernel.og, syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: BUG: KASAN: use-after-free in usb_hcd_unlink_urb+0x5f/0x170
 drivers/usb/core/hcd.c
Message-ID: <20200323063909.GA129571@kroah.com>
References: <CAEAjamtb2Kbn0He5O++=d_HCG1eQvLnGGbcVUOQ76+NfDiNybQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEAjamtb2Kbn0He5O++=d_HCG1eQvLnGGbcVUOQ76+NfDiNybQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 02:16:43AM -0400, Kyungtae Kim wrote:
> We report a bug (in linux-5.5.11) found by FuzzUSB (a modified version
> of syzkaller)
> 
> In function usb_hcd_unlink_urb (driver/usb/core/hcd.c:1607), it tries to
> read "urb->use_count". But it seems the instance "urb" was
> already freed (right after urb->dev at line 1597) by the function "urb_destroy"
> in a different thread, which caused memory access violation.
> To solve, it may need to check if urb is valid before urb->use_count,
> to avoid such freed memory access.

Can you send a patch for this?  Do you have a reproducer?

thanks,

greg k-h
