Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 957E0AC294
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2019 00:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392448AbfIFWe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 18:34:57 -0400
Received: from mga01.intel.com ([192.55.52.88]:20193 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730705AbfIFWe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 18:34:57 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2019 15:34:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,474,1559545200"; 
   d="scan'208";a="190955919"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Sep 2019 15:34:55 -0700
Date:   Fri, 6 Sep 2019 16:25:55 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Long Li <longli@microsoft.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Keith Busch <keith.busch@intel.com>,
        Hannes Reinecke <hare@suse.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Garry <john.garry@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Jens Axboe <axboe@fb.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 1/4] softirq: implement IRQ flood detection mechanism
Message-ID: <20190906222555.GB4260@localhost.localdomain>
References: <20190903072848.GA22170@ming.t460p>
 <dd96def4-1121-afbe-2431-9e516a06850c@linaro.org>
 <6f3b6557-1767-8c80-f786-1ea667179b39@acm.org>
 <2a8bd278-5384-d82f-c09b-4fce236d2d95@linaro.org>
 <20190905090617.GB4432@ming.t460p>
 <6a36ccc7-24cd-1d92-fef1-2c5e0f798c36@linaro.org>
 <20190906014819.GB27116@ming.t460p>
 <20190906141858.GA3953@localhost.localdomain>
 <CY4PR21MB0741091795CEE3D4624977CFCEBA0@CY4PR21MB0741.namprd21.prod.outlook.com>
 <20190906221920.GA12290@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906221920.GA12290@ming.t460p>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 07, 2019 at 06:19:21AM +0800, Ming Lei wrote:
> On Fri, Sep 06, 2019 at 05:50:49PM +0000, Long Li wrote:
> > >Subject: Re: [PATCH 1/4] softirq: implement IRQ flood detection mechanism
> > >
> > >Why are all 8 nvmes sharing the same CPU for interrupt handling?
> > >Shouldn't matrix_find_best_cpu_managed() handle selecting the least used
> > >CPU from the cpumask for the effective interrupt handling?
> > 
> > The tests run on 10 NVMe disks on a system of 80 CPUs. Each NVMe disk has 32 hardware queues.
> 
> Then there are total 320 NVMe MSI/X vectors, and 80 CPUs, so irq matrix
> can't avoid effective CPUs overlapping at all.

Sure, but it's at most half, meanwhile the CPU that's dispatching requests
would naturally be throttled by the other half who's completions are
interrupting that CPU, no?
