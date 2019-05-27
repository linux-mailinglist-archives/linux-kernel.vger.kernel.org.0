Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A28102B1C6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 12:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfE0KDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 06:03:30 -0400
Received: from 8bytes.org ([81.169.241.247]:40236 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbfE0KDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 06:03:30 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id B37C72E2; Mon, 27 May 2019 12:03:28 +0200 (CEST)
Date:   Mon, 27 May 2019 12:03:27 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Colin King <colin.king@canonical.com>
Cc:     iommu@lists.linux-foundation.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: remove redundant assignment to variable npages
Message-ID: <20190527100327.GC8420@8bytes.org>
References: <20190511124135.3635-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190511124135.3635-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 11, 2019 at 01:41:35PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable npages is being initialized however this is never read and
> later it is being reassigned to a new value. The initialization is
> redundant and hence can be removed.
> 
> Addresses-Coverity: ("Unused Value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/iommu/amd_iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

