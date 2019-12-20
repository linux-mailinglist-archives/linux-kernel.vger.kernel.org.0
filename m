Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7062127EF1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 16:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfLTPDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Dec 2019 10:03:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:50444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727233AbfLTPDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 10:03:18 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B35D21655;
        Fri, 20 Dec 2019 15:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576854197;
        bh=CPY22g81OiRavk7/O94Lph0D5YCaRfHVDFMECFgqwe8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cY0BevEbdLDwsL1Ocs55xioO9NT9DJ4cSwjnN9hMVYH8rxx7hewQXPNFXvrgmGRHN
         HQWw3E8LZhoRR5snduR0sw8QBdkr2bSZQl9mAYCww3KXvlzpiGiUKVCtiDu1/1NQm9
         I0XBzXYS8VR8q5pJaAqX06moFepjoThNNAvQycaM=
Date:   Fri, 20 Dec 2019 09:03:15 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linuxfoundation.org, kernel-team@android.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        John Garry <john.garry@huawei.com>,
        Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Greg Kroah-Hartman <gregkh@google.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v4 03/16] PCI/ATS: Restore EXPORT_SYMBOL_GPL() for
 pci_{enable,disable}_ats()
Message-ID: <20191220150315.GA97598@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191220084303.GA9347@8bytes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 09:43:03AM +0100, Joerg Roedel wrote:
> Hi Bjorn,
> 
> On Thu, Dec 19, 2019 at 12:03:39PM +0000, Will Deacon wrote:
> > From: Greg Kroah-Hartman <gregkh@google.com>
> > 
> > Commit d355bb209783 ("PCI/ATS: Remove unnecessary EXPORT_SYMBOL_GPL()")
> > unexported a bunch of symbols from the PCI core since the only external
> > users were non-modular IOMMU drivers. Although most of those symbols
> > can remain private for now, 'pci_{enable,disable_ats()' is required for
> > the ARM SMMUv3 driver to build as a module, otherwise we get a build
> > failure as follows:
> > 
> >   | ERROR: "pci_enable_ats" [drivers/iommu/arm-smmu-v3.ko] undefined!
> >   | ERROR: "pci_disable_ats" [drivers/iommu/arm-smmu-v3.ko] undefined!
> > 
> > Re-export these two functions so that the ARM SMMUv3 driver can be build
> > as a module.
> > 
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Joerg Roedel <jroedel@suse.de>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@google.com>
> > [will: rewrote commit message]
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> >  drivers/pci/ats.c | 2 ++
> >  1 file changed, 2 insertions(+)
> 
> Are you fine with this change? I would apply this series to my tree
> then.

Yep, thanks!  You can add my

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

