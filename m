Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C562C168DE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 19:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfEGRNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 13:13:09 -0400
Received: from mga02.intel.com ([134.134.136.20]:47997 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbfEGRNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 13:13:09 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 May 2019 10:13:08 -0700
X-ExtLoop1: 1
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga006.jf.intel.com with ESMTP; 07 May 2019 10:13:08 -0700
Date:   Tue, 7 May 2019 11:07:34 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH v2 6/7] nvme-pci: add device coredump support
Message-ID: <20190507170733.GA6783@localhost.localdomain>
References: <1557248314-4238-1-git-send-email-akinobu.mita@gmail.com>
 <1557248314-4238-7-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557248314-4238-7-git-send-email-akinobu.mita@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 01:58:33AM +0900, Akinobu Mita wrote:
> +static void nvme_coredump(struct device *dev)
> +{
> +	struct nvme_dev *ndev = dev_get_drvdata(dev);
> +
> +	mutex_lock(&ndev->shutdown_lock);
> +
> +	nvme_coredump_prologue(ndev);
> +	nvme_coredump_epilogue(ndev);
> +
> +	mutex_unlock(&ndev->shutdown_lock);
> +}

This is a bit of a mine field. The shutdown_lock is held when reclaiming
requests that didn't see a response. If you're holding it here and your
telemetry log page times out, we're going to deadlock. And since the
controller is probably in a buggered state when you try to retrieve one,
I would guess an unrecoverable timeout is the most likely outcome.
