Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47EC270232
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 16:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730624AbfGVOWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 10:22:42 -0400
Received: from 8bytes.org ([81.169.241.247]:44758 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730178AbfGVOWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 10:22:42 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 8CE321F2; Mon, 22 Jul 2019 16:22:40 +0200 (CEST)
Date:   Mon, 22 Jul 2019 16:22:38 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>, kevin.tian@intel.com,
        ashok.raj@intel.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, cai@lca.pw,
        jacob.jun.pan@intel.com
Subject: Re: [PATCH v2 7/7] iommu/vt-d: Consolidate domain_init() to avoid
 duplication
Message-ID: <20190722142238.GA12009@8bytes.org>
References: <20190612002851.17103-1-baolu.lu@linux.intel.com>
 <20190612002851.17103-8-baolu.lu@linux.intel.com>
 <20190718171615.2ed56280@x1.home>
 <f56599a6-77ac-e1ef-4843-51167b1284b3@linux.intel.com>
 <20190719091952.58255c47@x1.home>
 <13294960-c040-c501-c279-aa61d780d25e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13294960-c040-c501-c279-aa61d780d25e@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 20, 2019 at 09:15:58AM +0800, Lu Baolu wrote:
> Okay. I agree wit you. Let's revert this commit first.

Reverted the patch and queued it to my iommu/fixes branch.


Regards,

	Joerg
