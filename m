Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82C3F5EB4D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 20:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfGCSNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 14:13:30 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35709 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbfGCSNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 14:13:30 -0400
Received: by mail-qk1-f194.google.com with SMTP id r21so3281471qke.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 11:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dIkgJeJBuw++uppqsU+TnGBul+EFF40cgrIXzTaEkqk=;
        b=BDcvXVU5S9Xe6RaZL1d/tzhqXI0ERzROC5Hwy70kI1UbibB5XGc2qktpp6KCRj2eJ8
         Cvf/ZQdisnA3SE13u0kPAYYcxD7/vjlMJCRXFqswT6wm7B/ZH66kJW3+LI/VOPZjovQN
         evL2O/4brhczby9X6zVffdg7OkrHAb/PwnzOSEYjUiLxJrWp9rpmHGHLGRdXBfZRWW4W
         JckFR0Y+fY+7lMoaMBwbiK+8lcXoBeP3tQ697oFwWt03yHVMREfyYMjvXlRNVt9JAfjh
         vs4ZSzvO0c/ohYv6r1U/r7F4radpVLs9xgn1pHEoMnI8AYroHgpDAIAg2e2jlz8s1P1X
         DWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dIkgJeJBuw++uppqsU+TnGBul+EFF40cgrIXzTaEkqk=;
        b=VZbzJw77BaULliVNBOw1QgaGUU4EukSjWGe+CxSeiOEA52UPK4g16S7ptrWOGWZKRG
         jQ0nn4JY2NPYZMbIWDrW44v+3jHsRhQzZ2N5w5+39j7zAvbVu2XTGNy61eK0sllxgjV0
         C4DSkWuIyGyXLmpXqrO/64GTZB0gA2eYl/dSqgb/fVZro4dmwV0r0Xo/D8ZfwWWrq1MD
         984WFYFcwQPC4e+aInVBOj2c12PmVXHZj4Q9mLB/y7vl4WvezgAD2gY2GiXGw0TpGeG+
         XI6UXDCj78xh1MaMmYYIdZugwpRkZsyh5hsVMPgWDBkswxvVDF1QkIPtaDG2VMI+Q5jv
         oUIg==
X-Gm-Message-State: APjAAAXbdkcx8P2SbAqB6DU1RKZPDzzQ6EMm0Fb2r9yCYx/a/9G1PHeC
        wQhcY0Sti+DB+mVs0rR7mRq1EA==
X-Google-Smtp-Source: APXvYqwJ/Yia/+35gou6qrRAmIkzXiI4t3koOKtXe3iAnV4Brg/bboybUghnJVCplNkmCRgecJA4HA==
X-Received: by 2002:a37:ad0:: with SMTP id 199mr2986016qkk.90.1562177609563;
        Wed, 03 Jul 2019 11:13:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id i17sm1533124qta.6.2019.07.03.11.13.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Jul 2019 11:13:29 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hijl2-0000Hu-Jr; Wed, 03 Jul 2019 15:13:28 -0300
Date:   Wed, 3 Jul 2019 15:13:28 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     AlexDeucher <alexander.deucher@amd.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 20/22] mm: move hmm_vma_fault to nouveau
Message-ID: <20190703181328.GC18673@ziepe.ca>
References: <20190701062020.19239-21-hch@lst.de>
 <20190703180356.GB18673@ziepe.ca>
 <20190703180525.GA13703@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703180525.GA13703@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 08:05:25PM +0200, Christoph Hellwig wrote:
> On Wed, Jul 03, 2019 at 03:03:56PM -0300, Jason Gunthorpe wrote:
> > I was thinking about doing exactly this too, but amdgpu started using
> > this already obsolete API in their latest driver :(
> > 
> > So, we now need to get both drivers to move to the modern API.
> 
> Actually the AMD folks fixed this up after we pointed it out to them,
> so even in linux-next it just is nouveau that needs fixing.

Oh, I looked at an older -next, my mistake. Lets do it then.

Jason
