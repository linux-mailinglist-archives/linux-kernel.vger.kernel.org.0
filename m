Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0390A3933
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 16:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbfH3O0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 10:26:49 -0400
Received: from 8bytes.org ([81.169.241.247]:52532 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727751AbfH3O0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 10:26:49 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id D2F94246; Fri, 30 Aug 2019 16:26:47 +0200 (CEST)
Date:   Fri, 30 Aug 2019 16:26:46 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Stijn Tintel <stijn@linux-ipv6.be>,
        Petr Vandrovec <petr@vandrovec.name>
Subject: Re: [PATCH 1/1] Revert "iommu/vt-d: Avoid duplicated pci dma alias
 consideration"
Message-ID: <20190830142646.GD11578@8bytes.org>
References: <20190826085056.32484-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826085056.32484-1-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 04:50:56PM +0800, Lu Baolu wrote:
>  drivers/iommu/intel-iommu.c | 55 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 53 insertions(+), 2 deletions(-)

Applied to fixes branch, thanks.
