Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E55D0AC00A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 21:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405270AbfIFTBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 15:01:13 -0400
Received: from mga06.intel.com ([134.134.136.31]:16332 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405197AbfIFTBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 15:01:12 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2019 12:01:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,474,1559545200"; 
   d="scan'208";a="190907127"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Sep 2019 12:01:11 -0700
Date:   Fri, 6 Sep 2019 12:52:11 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Long Li <longli@microsoft.com>,
        John Garry <john.garry@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/4] softirq: implement IRQ flood detection mechanism
Message-ID: <20190906185210.GA4260@localhost.localdomain>
References: <6b88719c-782a-4a63-db9f-bf62734a7874@linaro.org>
 <20190903072848.GA22170@ming.t460p>
 <dd96def4-1121-afbe-2431-9e516a06850c@linaro.org>
 <6f3b6557-1767-8c80-f786-1ea667179b39@acm.org>
 <2a8bd278-5384-d82f-c09b-4fce236d2d95@linaro.org>
 <20190905090617.GB4432@ming.t460p>
 <6a36ccc7-24cd-1d92-fef1-2c5e0f798c36@linaro.org>
 <20190906014819.GB27116@ming.t460p>
 <ffefcfa0-09b6-9af5-f94e-8e7ddd2eef16@linaro.org>
 <6eb2a745-7b92-73ce-46f5-cc6a5ef08abc@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6eb2a745-7b92-73ce-46f5-cc6a5ef08abc@grimberg.me>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 11:30:57AM -0700, Sagi Grimberg wrote:
> 
> > 
> > Ok, so the real problem is per-cpu bounded tasks.
> > 
> > I share Thomas opinion about a NAPI like approach.
> 
> We already have that, its irq_poll, but it seems that for this
> use-case, we get lower performance for some reason. I'm not
> entirely sure why that is, maybe its because we need to mask interrupts
> because we don't have an "arm" register in nvme like network devices
> have?

For MSI, that's the INTMS/INTMC NVMe registers. MSI-x, though, has to
disarm it in its table entry, and the Linux implementation will do a
posted read in that path, which is a bit too expensive.
