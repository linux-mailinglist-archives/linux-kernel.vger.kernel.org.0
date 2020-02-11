Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 890C4158BCE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 10:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgBKJXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 04:23:17 -0500
Received: from mga03.intel.com ([134.134.136.65]:26356 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727121AbgBKJXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 04:23:16 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 01:23:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="380377287"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.106])
  by orsmga004.jf.intel.com with ESMTP; 11 Feb 2020 01:23:13 -0800
Date:   Tue, 11 Feb 2020 16:05:41 +0000
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Zha Bin <zhabin@linux.alibaba.com>, linux-kernel@vger.kernel.org,
        jasowang@redhat.com, slp@redhat.com,
        virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org,
        gerry@linux.alibaba.com, jing2.liu@linux.intel.com
Subject: Re: [PATCH v2 0/5] virtio mmio specification enhancement
Message-ID: <20200211160541.GA37446@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <20200210062938-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210062938-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 06:44:50AM -0500, Michael S. Tsirkin wrote:
> On Mon, Feb 10, 2020 at 05:05:16PM +0800, Zha Bin wrote:
> > We have compared the number of files and the lines of code between
> > virtio-mmio and virio-pci.
> > 
> > 				Virtio-PCI	    Virtio-MMIO	
> > 	number of files(Linux)	    161			1
> > 	lines of code(Linux)	    78237		538
> 
> 
> 
> Something's very wrong here. virtio PCI is 161 files?
> Are you counting the whole PCI subsystem?

Right, that is just a rough statistics. Surely enough, some drivers will
never get enabled in a typcial config.

> Sure enough:
> 
> $ find drivers/pci -name '*c' |wc -l
> 150

and plus:
$ find arch/x86/pci/ -name '*c' |wc -l
22

> 
> That's not reasonable, this includes a bunch of drivers that
> never run on a typical hypervisor.
> 
> MMIO is also not as small as you are trying to show:
> 
> $ cloc drivers/virtio/virtio_mmio.c include/uapi/linux/virtio_mmio.h
>        2 text files.
>        2 unique files.                              
>        0 files ignored.
> 
> github.com/AlDanial/cloc v 1.82  T=0.01 s (230.7 files/s, 106126.5 lines/s)
> -------------------------------------------------------------------------------
> Language                     files          blank        comment           code
> -------------------------------------------------------------------------------
> C                                1            144            100            535
> C/C++ Header                     1             39             66             36
> -------------------------------------------------------------------------------
> SUM:                             2            183            166            571
> -------------------------------------------------------------------------------
> 
> 
> I don't doubt MMIO is smaller than PCI. Of course that's because it has
> no features to speak of - just this patch already doubles it's size. If
> we keep doing that because we want the features then they will reach
> the same size in about 4 iterations.

Since current virtio-mmio size is small enough, so adding any notable
feature would easily double it. I have no objection that it may one day
reach the same level of PCI, but in this patch some are actually
generic changes and for MSI specific code we provide the option to
confige away.

Thanks,
Chao

> 
> 
> -- 
> MST
