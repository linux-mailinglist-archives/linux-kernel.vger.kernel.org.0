Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1108B13147
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 17:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbfECPeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 11:34:46 -0400
Received: from 8bytes.org ([81.169.241.247]:39306 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726724AbfECPep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 11:34:45 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id A604B580; Fri,  3 May 2019 17:34:44 +0200 (CEST)
Date:   Fri, 3 May 2019 17:34:43 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     eric.auger.pro@gmail.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, dwmw2@infradead.org
Subject: Re: [PATCH] iommu/vt-d: Fix leak in intel_pasid_alloc_table on error
 path
Message-ID: <20190503153443.GD11605@8bytes.org>
References: <20190430073004.10528-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430073004.10528-1-eric.auger@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 09:30:04AM +0200, Eric Auger wrote:
> If alloc_pages_node() fails, pasid_table is leaked. Free it.
> 
> Fixes: cc580e41260db ("iommu/vt-d: Per PCI device pasid table interfaces")
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  drivers/iommu/intel-pasid.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied, thanks.

