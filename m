Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1504D7DD77
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 16:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731778AbfHAOJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 10:09:16 -0400
Received: from verein.lst.de ([213.95.11.211]:43803 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731377AbfHAOJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 10:09:16 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id EEECA68AFE; Thu,  1 Aug 2019 16:09:13 +0200 (CEST)
Date:   Thu, 1 Aug 2019 16:09:13 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 1/3] iommu/vt-d: Refactor find_domain() helper
Message-ID: <20190801140913.GD23435@lst.de>
References: <20190801060156.8564-1-baolu.lu@linux.intel.com> <20190801060156.8564-2-baolu.lu@linux.intel.com> <20190801061021.GA14955@lst.de> <40f3a736-0a96-0491-61ad-0ddf03612d91@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40f3a736-0a96-0491-61ad-0ddf03612d91@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 02:20:07PM +0800, Lu Baolu wrote:
> Hi Christoph,
>
> On 8/1/19 2:10 PM, Christoph Hellwig wrote:
>> On Thu, Aug 01, 2019 at 02:01:54PM +0800, Lu Baolu wrote:
>>> +	/* No lock here, assumes no domain exit in normal case */
>>
>> s/exit/exists/ ?
>
> This comment is just moved from one place to another in this patch.
>
> "no domain exit" means "the domain isn't freed". (my understand)

Maybe we'll get that refconfirmed and can fix up the comment?

>
>>
>>> +	info = dev->archdata.iommu;
>>> +	if (likely(info))
>>> +		return info->domain;
>>
>> But then again the likely would be odd.
>>
>
> Normally there's a domain for a device (default domain or isolation
> domain for assignment cases).

Makes sense, I just mean to say that the likely was contrary to my
understanding of the above comment.
