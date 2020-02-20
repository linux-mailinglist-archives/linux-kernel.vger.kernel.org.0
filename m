Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3804165992
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 09:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgBTIp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 03:45:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:47662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726799AbgBTIp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 03:45:57 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBBD9207FD;
        Thu, 20 Feb 2020 08:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582188357;
        bh=M6GGXuQ/D6jiRe6KPYbT3GWIqkyMWWqU9w9MfTEu9pc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lI95RFO8JMLFC9bEmf1jbUprqiB7R/md/sR6FxYDha9JFtReCPlJ8MzUa8NB4H7yn
         elIzgxmFyp4jHkujurvO69MXlPwSkJHAxULUB0mTK8rEzCAJqLKDq/eGxbqzbVYOX1
         75GGZ4a4pc3c6KF0Jp8wmYBF1HTwpHWB98LbtTNU=
Date:   Thu, 20 Feb 2020 08:45:52 +0000
From:   Will Deacon <will@kernel.org>
To:     isaacm@codeaurora.org
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@infradead.org>, pratikp@codeaurora.org,
        linux-kernel@vger.kernel.org, Liam Mark <lmark@codeaurora.org>,
        iommu@lists.linux-foundation.org, kernel-team@android.com
Subject: Re: [RFC PATCH] iommu/dma: Allow drivers to reserve an iova range
Message-ID: <20200220084552.GB11827@willie-the-truck>
References: <1581721096-16235-1-git-send-email-isaacm@codeaurora.org>
 <20200217080138.GB10342@infradead.org>
 <c58fd502-52a4-cb0f-6e7f-e9cc00627313@arm.com>
 <fc6e1b6689bca7a00e6b12d2bc877d20@codeaurora.org>
 <20200219111501.GA19400@willie-the-truck>
 <d8b70a579f07c688b264e83a0ec0b6d6@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8b70a579f07c688b264e83a0ec0b6d6@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 12:06:28PM -0800, isaacm@codeaurora.org wrote:
> On 2020-02-19 03:15, Will Deacon wrote:
> > On Tue, Feb 18, 2020 at 05:57:18PM -0800, isaacm@codeaurora.org wrote:
> > > Does this mean that the driver should be managing the IOVA space and
> > > mappings for this device using the IOMMU API? If so, is the
> > > rationale for
> > > this because the device driver can have the information of what IOVA
> > > ranges
> > > can and cannot be used? Shouldn't there be a generic way of
> > > informing an
> > > IOMMU driver about these reserved ranges? Perhaps through a device
> > > tree
> > > property, instead of deferring this type of management to the driver?
> > 
> > Before we dive into designing that, can you please clarify whether the
> > reserved IOVA range applies to all DMA masters mastering through a
> > particular SMMU, or whether it's just about one specific master? I was
> > assuming the former, but wanted to be sure.
> > 
> This situation currently applies to one master.

Interesting. Is it problematic if the range is reserved for all masters
sharing that SMMU?

Will
