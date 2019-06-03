Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D08DC32D43
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 11:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfFCJ6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 05:58:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:51448 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726708AbfFCJ6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:58:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F19B4AFA9;
        Mon,  3 Jun 2019 09:58:49 +0000 (UTC)
Date:   Mon, 3 Jun 2019 11:58:48 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Qian Cai <cai@lca.pw>
Cc:     jamessewart@arista.com, baolu.lu@linux.intel.com,
        dwmw2@infradead.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] intel-iommu: fix a variable set but not used
Message-ID: <20190603095848.GD8151@suse.de>
References: <1559333762-2436-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559333762-2436-1-git-send-email-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 04:16:02PM -0400, Qian Cai wrote:
> The commit "iommu/vt-d: Delegate the dma domain to upper layer" left an
> unused variable,
> 
> drivers/iommu/intel-iommu.c: In function 'disable_dmar_iommu':
> drivers/iommu/intel-iommu.c:1652:23: warning: variable 'domain' set but
> not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  drivers/iommu/intel-iommu.c | 4 ----
>  1 file changed, 4 deletions(-)

Applied, thanks.
