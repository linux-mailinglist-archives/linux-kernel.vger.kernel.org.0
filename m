Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED1D9AA50
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 10:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392726AbfHWI2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 04:28:04 -0400
Received: from 8bytes.org ([81.169.241.247]:51038 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390104AbfHWI2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 04:28:04 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 196BE20E; Fri, 23 Aug 2019 10:28:03 +0200 (CEST)
Date:   Fri, 23 Aug 2019 10:27:57 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iommu/amd: Override wrong IVRS IOAPIC on Raven Ridge
 systems
Message-ID: <20190823082757.GA24194@8bytes.org>
References: <20190817063502.27311-1-kai.hen.fen@canonical.com>
 <20190821051004.2367-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821051004.2367-1-kai.heng.feng@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 01:10:04PM +0800, Kai-Heng Feng wrote:
>  drivers/iommu/Makefile           |  2 +-
>  drivers/iommu/amd_iommu.h        | 14 +++++
>  drivers/iommu/amd_iommu_init.c   |  5 +-
>  drivers/iommu/amd_iommu_quirks.c | 92 ++++++++++++++++++++++++++++++++
>  4 files changed, 111 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/iommu/amd_iommu.h
>  create mode 100644 drivers/iommu/amd_iommu_quirks.c

Applied, thanks.
