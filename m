Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E42E3B3752
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 11:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732008AbfIPJmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 05:42:14 -0400
Received: from mga18.intel.com ([134.134.136.126]:23005 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729713AbfIPJmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 05:42:13 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 02:42:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,512,1559545200"; 
   d="scan'208";a="201566288"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 16 Sep 2019 02:42:09 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 16 Sep 2019 12:42:08 +0300
Date:   Mon, 16 Sep 2019 12:42:08 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Jethro Beekman <jethro@fortanix.com>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] mtd: spi-nor: intel-spi: support chips without
 software sequencer
Message-ID: <20190916094208.GU28281@lahna.fi.intel.com>
References: <69f4a8e8-7889-8b00-0adc-7faaef6b42e4@fortanix.com>
 <32ab6570-c3b7-4eec-7a0b-69bc2f7f76dc@fortanix.com>
 <20190916091157.GR28281@lahna.fi.intel.com>
 <e284a2a8-1d4c-2b57-642c-c91f39a5ee99@fortanix.com>
 <20190916091920.GS28281@lahna.fi.intel.com>
 <f7708f65-1450-ce5a-7dfb-70d7ca4b9df1@fortanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7708f65-1450-ce5a-7dfb-70d7ca4b9df1@fortanix.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 09:22:04AM +0000, Jethro Beekman wrote:
> On 2019-09-16 11:19, Mika Westerberg wrote:
> > On Mon, Sep 16, 2019 at 09:12:50AM +0000, Jethro Beekman wrote:
> >> On 2019-09-16 11:11, Mika Westerberg wrote:
> >>> Hi,
> >>>
> >>> On Sun, Sep 15, 2019 at 08:41:55PM +0000, Jethro Beekman wrote:
> >>>> Could someone please review this?
> >>>>
> >>>> On 2019-09-04 03:15, Jethro Beekman wrote:
> >>>>> Some flash controllers don't have a software sequencer. Avoid
> >>>>> configuring the register addresses for it, and double check
> >>>>> everywhere that its not accidentally trying to be used.
> >>>
> >>> All the supported types in intel_spi_init() set ->sregs so I don't see
> >>> how we could end up calling functions with that not set properly. Which
> >>> controller we are talking about here? CNL?
> >>>
> >>
> >> Yes, see 2/2.
> > 
> > OK, thanks. Please mention that in the commit log as well.
> 
> It seems obvious to me that the need for a patch may be further
> explained by the next patch in the patch set.

Yes, that's fine but then you should make sure the intended reviewers
get to see all the patches in the series. For me I got only Cc'd on this
1/2 yesterday. I think I reviewed 2/2 some time ago.
