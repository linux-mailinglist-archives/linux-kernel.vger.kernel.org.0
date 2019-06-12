Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5BE42F63
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 20:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfFLSzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 14:55:51 -0400
Received: from mga09.intel.com ([134.134.136.24]:22517 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbfFLSzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 14:55:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2019 11:55:50 -0700
X-ExtLoop1: 1
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by fmsmga008.fm.intel.com with ESMTP; 12 Jun 2019 11:55:49 -0700
Date:   Wed, 12 Jun 2019 11:58:58 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
        "robdclark@gmail.com" <robdclark@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Robin Murphy <Robin.Murphy@arm.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 0/4] iommu: Add device fault reporting API
Message-ID: <20190612115858.733edacc@jacob-builder>
In-Reply-To: <20190612131143.GF21613@8bytes.org>
References: <20190603145749.46347-1-jean-philippe.brucker@arm.com>
        <20190612081944.GB17505@8bytes.org>
        <0f21e1b2-837f-87ba-6cf3-f6490d9e2a57@arm.com>
        <20190612131143.GF21613@8bytes.org>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jun 2019 15:11:43 +0200
Joerg Roedel <joro@8bytes.org> wrote:

> On Wed, Jun 12, 2019 at 12:54:51PM +0100, Jean-Philippe Brucker wrote:
> > Thanks! As discussed I think we need to add padding into the
> > iommu_fault structure before this reaches mainline, to make the
> > UAPI easier to extend in the future. It's already possible to
> > extend but requires introducing a new ABI version number and
> > support two structures. Adding some padding would only require
> > introducing new flags. If there is no objection I'll send a
> > one-line patch bumping the structure size to 64 bytes (currently
> > 48)  
> 
> Sounds good, please submit the patch.
> 
Could you also add padding to page response per our discussion here?
https://lkml.org/lkml/2019/6/12/1131

> Regards,
> 
> 	Joerg

[Jacob Pan]
