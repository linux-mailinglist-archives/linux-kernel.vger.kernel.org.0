Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5554AFA8B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2019 12:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfIKKhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Sep 2019 06:37:31 -0400
Received: from 8bytes.org ([81.169.241.247]:54048 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbfIKKha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 06:37:30 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 0E3E9386; Wed, 11 Sep 2019 12:37:28 +0200 (CEST)
Date:   Wed, 11 Sep 2019 12:37:27 +0200
From:   "joro@8bytes.org" <joro@8bytes.org>
To:     "Mehta, Sohil" <sohil.mehta@intel.com>
Cc:     "Park, Kyung Min" <kyung.min.park@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Lu, Baolu" <baolu.lu@intel.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH] iommu/vt-d: Add Scalable Mode fault information
Message-ID: <20190911103726.GB21988@8bytes.org>
References: <1567793642-17063-1-git-send-email-kyung.min.park@intel.com>
 <20190910080823.GA3247@8bytes.org>
 <1568136807.58430.11.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1568136807.58430.11.camel@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 05:30:09PM +0000, Mehta, Sohil wrote:
> On Tue, 2019-09-10 at 10:08 +0200, Joerg Roedel wrote:
> > > +�����"Unknown", "Unknown", "Unknown", "Unknown", "Unknown",
> > "Unknown", "Unknown", /* 0x49-0x4F */
> > 
> > Maybe add the number (0x49-0x4f) to the respecting "Unknown" fields?
> > If
> > we can't give a reason we should give the number for easier debugging
> > in
> > the future. Same for the "Unknown" fields below.
> 
> I believe a fault number is always printed in�dmar_fault_do_one() even
> if the reason is unknown.
> 
> DMAR: [DMA Write] Request device [00:02.0] fault addr 108a000 [fault
> reason 23] Unknown

Right, applied the patch, thanks.
