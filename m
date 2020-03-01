Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40CA4174EF8
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Mar 2020 19:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgCASce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Mar 2020 13:32:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:38254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbgCASce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 13:32:34 -0500
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72AA3246D4;
        Sun,  1 Mar 2020 18:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583087553;
        bh=GOHQ3umUBu5BEnrmOm6f0fS44zEn7yEiHI8nMTgJgTI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cUP/0V54kpu2sQ+h0/PxsiF63letvU+vcX8YvhJIhlLyFa44M9TTNaU0eSPy04KsB
         vOXG+adWcdipgEah2OrN6uIa9hkSGlim5iSEBGIlROsvEgtZ3Ic3ebBol9Hgw33WNg
         VsGjsZVBeKrIwLqE1QXLXo+7z8BpDrGlafKXZPkA=
Date:   Sun, 1 Mar 2020 10:32:31 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: Check for readiness more quickly, to speed up boot
 time
Message-ID: <20200301183231.GA544682@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200229025228.GA203607@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200229025228.GA203607@localhost>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 06:52:28PM -0800, Josh Triplett wrote:
> @@ -2074,7 +2074,7 @@ static int nvme_wait_ready(struct nvme_ctrl *ctrl, u64 cap, bool enabled)
>  		if ((csts & NVME_CSTS_RDY) == bit)
>  			break;
>  
> -		msleep(100);
> +		usleep_range(1000, 2000);
>  		if (fatal_signal_pending(current))
>  			return -EINTR;
>  		if (time_after(jiffies, timeout)) {

The key being this sleep schedules the task unlike udelay. It's neat
you can boot where 100ms is considered a long time.

This clearly helps when you've one nvme that becomes ready quickly, but
what happens with many nvme's that are slow to ready? This change will
end up polling the status of those 1000's of times, I wonder if there's
a point where this frequent sleep/wake cycle initializing a whole lot
of nvme devices in parallel may interfere with other init tasks.

I doubt there's really an issue there, but thought it's worth considering
what happens at the other end of the specturm.

Anyway, the patch looks fine to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>
