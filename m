Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E03E86DB9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 01:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404707AbfHHXLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 19:11:01 -0400
Received: from mga03.intel.com ([134.134.136.65]:23089 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732375AbfHHXLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 19:11:00 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 16:11:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,363,1559545200"; 
   d="scan'208";a="169142712"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga008.jf.intel.com with ESMTP; 08 Aug 2019 16:10:59 -0700
Date:   Thu, 8 Aug 2019 17:08:35 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "hch@lst.de" <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] genirq/affinity: report extra vectors on uneven nodes
Message-ID: <20190808230835.GB27570@localhost.localdomain>
References: <20190807201051.32662-1-jonathan.derrick@intel.com>
 <alpine.DEB.2.21.1908080903360.2882@nanos.tec.linutronix.de>
 <20190808163224.GB27077@localhost.localdomain>
 <1a6ab898b8800c3e660054f77ac81bfc3921d45a.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a6ab898b8800c3e660054f77ac81bfc3921d45a.camel@intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 10:46:06PM +0000, Derrick, Jonathan wrote:
> On Thu, 2019-08-08 at 10:32 -0600, Keith Busch wrote:
> > 
> > I think the real problem is the spread's vecs_per_node doesn't account
> > which nodes contribute more CPUs than others. For example:
> > 
> >   Node 0 has 32 CPUs
> >   Node 1 has 8 CPUs
> >   Assign 32 vectors
> > 
> > The current algorithm assigns 16 vectors to node 0 because vecs_per_node
> > is calculated as 32 vectors / 2 nodes on the first iteration. The
> > subsequent iteration for node 1 gets 8 vectors because it has only 8
> > CPUs, leaving 8 vectors unassigned.
> > 
> > A more fair spread would give node 0 the remaining 8 vectors. This
> > optimization, however, is a bit more complex than the current algorithm,
> > which is probably why it wasn't done, so I think the warning should just
> > be removed.
> 
> It does get a bit complex for the rare scenario in this case
> Maybe just an informational warning rather than a stackdumping warning

I think the easiest way to ensure all vectors are assigned is iterate
the nodes in a sorted order from fewest CPUs to most. That should fix
the warning, though it may not have the best possible assignment ratio
(but better than what we're currently doing).

Unfortunately the kernel's sort() doesn't take a 'void *priv' for the
compare callback, so we wouldn't have all the information needed to weigh
each node, but maybe we can fix that if there's agreement to iterate
the nodes this way.
