Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F79417F5A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 19:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfEHRwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 13:52:40 -0400
Received: from verein.lst.de ([213.95.11.211]:41044 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbfEHRwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 13:52:40 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id C491667358; Wed,  8 May 2019 19:52:19 +0200 (CEST)
Date:   Wed, 8 May 2019 19:52:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jon Mason <jdmason@kudzu.us>
Cc:     Christoph Hellwig <hch@lst.de>, Muli Ben-Yehuda <mulix@mulix.org>,
        x86@kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: status of the calgary iommu driver
Message-ID: <20190508175219.GA32030@lst.de>
References: <20190409140347.GA11524@lst.de> <CAPoiz9wwMCRkzM5FWm18kecC1=kt+5qPNHmQ7eUFhH=3ZNAqYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPoiz9wwMCRkzM5FWm18kecC1=kt+5qPNHmQ7eUFhH=3ZNAqYw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 06:42:39PM +0100, Jon Mason wrote:
> These systems were plentiful for 2-4 years after the original series
> made it in.  After that, the Intel and AMD IOMMUs should were shipped
> and were superior to this chip.  So, even in systems where these might
> be present, the AMD/Intel ones should be used (unknown if they were
> shipped on the same ones, as both Muli and I have left IBM).
> 
> You thinking about removing the code?

I'm wondering if we could remove it.  I've been done lots of
maintainance on various dma mapping and iommu drivers, and the calgary
one seems like it didn't get a whole lot of love, and I've not seen
any recent users, so I mostly wonder if I should bother at all.
