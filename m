Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C34F45FAF2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2019 17:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbfGDPfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jul 2019 11:35:54 -0400
Received: from 8bytes.org ([81.169.241.247]:34128 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727585AbfGDPfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 11:35:53 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 460884F1; Thu,  4 Jul 2019 17:35:52 +0200 (CEST)
Date:   Thu, 4 Jul 2019 17:35:52 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] omap-iommu: no need to check return value of
 debugfs_create functions
Message-ID: <20190704153551.GG3310@8bytes.org>
References: <20190704143649.GA11697@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704143649.GA11697@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 04:36:49PM +0200, Greg Kroah-Hartman wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: iommu@lists.linux-foundation.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> Warning, not even test-built, but "should" work :)

It almost did :)

> +	debugfs_create_file("regs", 0400, d, obj, &attrregs_fops);
> +	debugfs_create_file("tlb", 0400, d, obj, &attrtlb_fops);
> +	debugfs_create_file("pagetable", 0400, d, obj, &attrpagetable_fops);

The _fops were named without the 'attr' prefix, changed that and it
compiled. Patch is now applied.

Thanks,

	Joerg
