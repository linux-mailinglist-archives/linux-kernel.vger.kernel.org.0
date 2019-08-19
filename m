Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F34C94FD6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 23:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbfHSVXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 17:23:50 -0400
Received: from mga11.intel.com ([192.55.52.93]:18400 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728463AbfHSVXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 17:23:49 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 14:23:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,406,1559545200"; 
   d="scan'208";a="168876419"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga007.jf.intel.com with ESMTP; 19 Aug 2019 14:23:48 -0700
Date:   Mon, 19 Aug 2019 15:21:45 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Marta Rybczynska <mrybczyn@kalray.eu>,
        Christoph Hellwig <hch@lst.de>, axboe <axboe@fb.com>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Samuel Jones <sjones@kalray.eu>,
        Guillaume Missonnier <gmissonnier@kalray.eu>
Subject: Re: [PATCH v2] nvme: allow 64-bit results in passthru commands
Message-ID: <20190819212145.GB11202@localhost.localdomain>
References: <89520652.56920183.1565948841909.JavaMail.zimbra@kalray.eu>
 <20190816131606.GA26191@lst.de>
 <469829119.56970464.1566198383932.JavaMail.zimbra@kalray.eu>
 <20190819144922.GC6883@localhost.localdomain>
 <1d7819a9-9504-2dc6-fca4-fbde4f99d92c@grimberg.me>
 <20190819185749.GA11202@localhost.localdomain>
 <e639f7ce-5f1a-d4a5-f80e-9bf3bc1ff638@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e639f7ce-5f1a-d4a5-f80e-9bf3bc1ff638@grimberg.me>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 02:17:44PM -0700, Sagi Grimberg wrote:
> 
> >>>> ----- On 16 Aug, 2019, at 15:16, Christoph Hellwig hch@lst.de wrote:
> >>>>> Sorry for not replying to the earlier version, and thanks for doing
> >>>>> this work.
> >>>>>
> >>>>> I wonder if instead of using our own structure we'd just use
> >>>>> a full nvme SQE for the input and CQE for that output.  Even if we
> >>>>> reserve a few fields that means we are ready for any newly used
> >>>>> field (at least until the SQE/CQE sizes are expanded..).
> >>>>
> >>>> We could do that, nvme_command and nvme_completion are already UAPI.
> >>>> On the other hand that would mean not filling out certain fields like
> >>>> command_id. Can do an approach like this.
> >>>
> >>> Well, we need to pass user space addresses and lengths, which isn't
> >>> captured in struct nvme_command.
> >>
> >> Isn't simply having a 64 variant simpler?
> > 
> > Could you provide more details on what you mean by this?
> 
> Why would we need to pass addresses and lengths if userspace is
> sending the 64 variant when it is expecting a 64 result?
> 
> Or maybe I'm missing something...

The recommendation was to have user space provide an SQE, i.e. 'struct
nvme_command', as input to the driver and receive 'struct nvme_completion'
in response. I am only pointing out that 'struct nvme_command' is
inappropriate for user space.
