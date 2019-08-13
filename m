Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5778B439
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 11:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbfHMJea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 05:34:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:36650 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727305AbfHMJea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 05:34:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D1578ABD0;
        Tue, 13 Aug 2019 09:34:28 +0000 (UTC)
Subject: Re: [PATCH V3 3/3] genirq/affinity: Spread vectors on node according
 to nr_cpu ratio
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jon Derrick <jonathan.derrick@intel.com>
References: <20190813081447.1396-1-ming.lei@redhat.com>
 <20190813081447.1396-4-ming.lei@redhat.com>
From:   Daniel Wagner <dwagner@suse.de>
Message-ID: <7579c5b8-3992-e685-d559-98e9b0f7baad@suse.de>
Date:   Tue, 13 Aug 2019 11:34:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190813081447.1396-4-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/13/19 10:14 AM, Ming Lei wrote:
> Now __irq_build_affinity_masks() spreads vectors evenly per node, and
> all vectors may not be spread in case that each numa node has different
> CPU number, then the following warning in irq_build_affinity_masks() can
> be triggered:
> 
> 	if (nr_present < numvecs)
> 		WARN_ON(nr_present + nr_others < numvecs);

Is this the warning which is changed in patch #1?

Thanks,
Daniel
