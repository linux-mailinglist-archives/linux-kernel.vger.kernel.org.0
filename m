Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C90D175D9C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 15:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbgCBOxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 09:53:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:51834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727121AbgCBOxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 09:53:21 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72A2121775;
        Mon,  2 Mar 2020 14:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583160801;
        bh=/ujiqn0F0eKhpDPmiPeKaMj+WcKEVZBmjG4Jyn1nIVw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eWCPKmEpAbTbc0FD61hW+TSlsCou0lKiFUWG7L+waQ0j4qgJTBCsZRYL0Ch+MM4m8
         fap+mhyu7CPFkUF5zvXRXwucz1Hg46kWfCTuQeO1LIHOdsQAW0mqIUu0i2CyZb5U61
         zwfxVeEjgoDyS+9b5RuC8zgKauyn8rYnLfHUGEGI=
Date:   Mon, 2 Mar 2020 23:53:13 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: Check for readiness more quickly, to speed up boot
 time
Message-ID: <20200302145313.GA6773@redsun51.ssa.fujisawa.hgst.com>
References: <20200229025228.GA203607@localhost>
 <20200301183231.GA544682@dhcp-10-100-145-180.wdl.wdc.com>
 <20200301191501.GA235404@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200301191501.GA235404@localhost>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 01, 2020 at 11:15:01AM -0800, Josh Triplett wrote:
> On Sun, Mar 01, 2020 at 10:32:31AM -0800, Keith Busch wrote:
> > I doubt there's really an issue there, but thought it's worth considering
> > what happens at the other end of the specturm.
> > 
> > Anyway, the patch looks fine to me.
> > 
> > Reviewed-by: Keith Busch <kbusch@kernel.org>
> 
> Thank you!
> 
> Does this seem reasonable to enqueue for 5.7?

Yes, early enough for 5.7. Let's just give this a few more days to see if
nvme fabrics developers have any comments. Reading controller status for
those transports is more complicated than PCI. I don't see an issue
there either, but since this is common code, we should see if anyone
else want to weigh in.
