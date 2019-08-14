Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 465EB8DEAA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 22:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbfHNUVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 16:21:15 -0400
Received: from mga18.intel.com ([134.134.136.126]:62596 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbfHNUVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 16:21:15 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2019 13:21:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,386,1559545200"; 
   d="scan'208";a="260610415"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga001.jf.intel.com with ESMTP; 14 Aug 2019 13:21:13 -0700
Date:   Wed, 14 Aug 2019 14:19:01 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Mario Limonciello <mario.limonciello@dell.com>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ryan Hong <Ryan.Hong@Dell.com>, Crag Wang <Crag.Wang@dell.com>,
        "sjg@google.com" <sjg@google.com>,
        Charles Hyde <charles.hyde@dellteam.com>,
        Jared Dominguez <jared.dominguez@dell.com>
Subject: Re: [PATCH v2] nvme: Add quirk for LiteON CL1 devices running FW
 22301111
Message-ID: <20190814201900.GA3511@localhost.localdomain>
References: <1565813304-16710-1-git-send-email-mario.limonciello@dell.com>
 <32f20898-b9af-eee0-97de-0a568de54b57@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32f20898-b9af-eee0-97de-0a568de54b57@grimberg.me>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 01:14:50PM -0700, Sagi Grimberg wrote:
> Mario,
> 
> Can you please respin a patch that applies cleanly on nvme-5.4?

This fixes a regression we introduced in 5.3, so it should go in
5.3-rc. For this to apply cleanly, though, we'll need to resync to Linus'
tree to get Rafael's PCIe ASPM check after he sends his linux-pm pull
request.
