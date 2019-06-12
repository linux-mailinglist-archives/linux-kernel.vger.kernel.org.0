Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44D5B4271C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 15:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439386AbfFLNLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 09:11:45 -0400
Received: from 8bytes.org ([81.169.241.247]:43616 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439360AbfFLNLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 09:11:45 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 9C2EF64D; Wed, 12 Jun 2019 15:11:43 +0200 (CEST)
Date:   Wed, 12 Jun 2019 15:11:43 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
        "robdclark@gmail.com" <robdclark@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Robin Murphy <Robin.Murphy@arm.com>
Subject: Re: [PATCH v2 0/4] iommu: Add device fault reporting API
Message-ID: <20190612131143.GF21613@8bytes.org>
References: <20190603145749.46347-1-jean-philippe.brucker@arm.com>
 <20190612081944.GB17505@8bytes.org>
 <0f21e1b2-837f-87ba-6cf3-f6490d9e2a57@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f21e1b2-837f-87ba-6cf3-f6490d9e2a57@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 12:54:51PM +0100, Jean-Philippe Brucker wrote:
> Thanks! As discussed I think we need to add padding into the iommu_fault
> structure before this reaches mainline, to make the UAPI easier to
> extend in the future. It's already possible to extend but requires
> introducing a new ABI version number and support two structures. Adding
> some padding would only require introducing new flags. If there is no
> objection I'll send a one-line patch bumping the structure size to 64
> bytes (currently 48)

Sounds good, please submit the patch.

Regards,

	Joerg
