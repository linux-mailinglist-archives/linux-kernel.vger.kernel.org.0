Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 074DA1B77E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 15:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730001AbfEMNzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 09:55:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:32384 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729710AbfEMNzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 09:55:54 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 May 2019 06:55:53 -0700
X-ExtLoop1: 1
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga004.jf.intel.com with ESMTP; 13 May 2019 06:55:53 -0700
Date:   Mon, 13 May 2019 07:50:31 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        "Busch, Keith" <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        "Heitke, Kenneth" <kenneth.heitke@intel.com>
Subject: Re: [PATCH v3 5/7] nvme-pci: add device coredump infrastructure
Message-ID: <20190513135031.GC15318@localhost.localdomain>
References: <1557676457-4195-1-git-send-email-akinobu.mita@gmail.com>
 <1557676457-4195-6-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557676457-4195-6-git-send-email-akinobu.mita@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 12, 2019 at 08:54:15AM -0700, Akinobu Mita wrote:
> +static void nvme_coredump_logs(struct nvme_dev *dev)
> +{
> +	struct dev_coredumpm_bulk_data *bulk_data;
> +
> +	if (!dev->dumps)
> +		return;
> +
> +	bulk_data = nvme_coredump_alloc(dev, 1);
> +	if (!bulk_data)
> +		return;
> +
> +	if (nvme_coredump_telemetry_log(bulk_data, &dev->ctrl))
> +		dev->num_dumps--;
> +}

You'll need this function to return the same 'int' value from
nvme_coredump_telemetry_log. A negative value here means that the
device didn't produce a response, and that's important to check from
the reset work since you'll need to abort the reset if that happens.
