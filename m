Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC42164145
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 11:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgBSKQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 05:16:16 -0500
Received: from 8bytes.org ([81.169.241.247]:54864 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbgBSKQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 05:16:15 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 1661936A; Wed, 19 Feb 2020 11:16:14 +0100 (CET)
Date:   Wed, 19 Feb 2020 11:16:12 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, gustavo@embeddedor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: Use C99 flexible array in fwspec
Message-ID: <20200219101612.GC1961@8bytes.org>
References: <7364595699c37d2ef53636c8af6dcefa6602529b.1581601149.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7364595699c37d2ef53636c8af6dcefa6602529b.1581601149.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 02:00:21PM +0000, Robin Murphy wrote:
> Although the 1-element array was a typical pre-C99 way to implement
> variable-length structures, and indeed is a fundamental construct in the
> APIs of certain other popular platforms, there's no good reason for it
> here (and in particular the sizeof() trick is far too "clever" for its
> own good). We can just as easily implement iommu_fwspec's preallocation
> behaviour using a standard flexible array member, so let's make it look
> the way most readers would expect.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> Before the Coccinelle police catch up with me... :)

Applied, thanks. You should be safe now :)
