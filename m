Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E674B7BDF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2019 16:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732453AbfISONE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Sep 2019 10:13:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:49852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732299AbfISONE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 10:13:04 -0400
Received: from C02WT3WMHTD6 (unknown [8.36.226.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 329CD2067B;
        Thu, 19 Sep 2019 14:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568902383;
        bh=Fduf10OMcAOvnRZMP54/18uKfFU1Trz0JGIfeGeiB4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jN4dbbHT21aYx902Chc1XXK8Kdi9Df4rkc3LIUIfNdMNrCDpcMm/HGWxuJVKpj41j
         UqzqSFg+JVY61WyyiE6LgTiPPxrk3kXuwgSfcumAmWgylc/3arkAL47IZGS0bxVKeY
         +VVd/nu3WZlz/ol+YKw71u/gNP84D1k5TAXs8uDk=
Date:   Thu, 19 Sep 2019 08:13:01 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Bharat Kumar Gogada <bharatku@xilinx.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Keith Busch <keith.busch@linux.intel.com>,
        "keith.busch@intel.com" <keith.busch@intel.com>
Subject: Re: NVMe Poll CQ on timeout
Message-ID: <20190919141301.GA61660@C02WT3WMHTD6>
References: <MN2PR02MB633689DBBA6DE9DD7A34043FA5890@MN2PR02MB6336.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR02MB633689DBBA6DE9DD7A34043FA5890@MN2PR02MB6336.namprd02.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 01:47:50PM +0000, Bharat Kumar Gogada wrote:
> Hi All,
> 
> We are testing NVMe cards on ARM64 platform, the card uses MSI-X interrupts.
> We are hitting following case in drivers/nvme/host/pci.c
> /*
>          * Did we miss an interrupt?
>          */
>         if (__nvme_poll(nvmeq, req->tag)) {
>                 dev_warn(dev->ctrl.device,
>                          "I/O %d QID %d timeout, completion polled\n",
>                          req->tag, nvmeq->qid);
>                 return BLK_EH_DONE;
>         }
> 
> Can anyone tell when does nvme_timeout gets invoked ?

Timeout is invoked when the driver didn't see a completion to a
submitted command.

> In what cases we see this interrupt miss ?

That usually happens for one of two reasons:

 1. The device didn't send any MSIx message for a CQE

 2. The device sent the MSIx message before posting the CQE

I've also seen h/w errata where the MSIx and CQE are re-ordered, which
can also lead to this.

A hardware trace would provide the most detailed view of what's
happening. You might be able to infer if you carefully account for
commands sent, interrupts received, and spurious interrupts detected.

> We are seeing this issue only for reads with following fio command 
> fio --name=randwrite --ioengine=libaio --iodepth=1 --rw=randread --bs=128k --direct=0 \
> --size=128M --numjobs=3 --group_reporting --filename=/dev/nvme0n1
> 
> We are not seeing issue with --rw=randwrite for same size.
> 
> Please let us know what can cause this issue. 
