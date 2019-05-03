Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7736C13126
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 17:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbfECP2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 11:28:11 -0400
Received: from 8bytes.org ([81.169.241.247]:39278 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbfECP2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 11:28:11 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id A6D78580; Fri,  3 May 2019 17:28:10 +0200 (CEST)
Date:   Fri, 3 May 2019 17:28:09 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Tom Murphy <tmurphy@arista.com>
Cc:     iommu@lists.linux-foundation.org, murphyt7@tcd.ie,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/amd: flush not present cache in iommu_map_page
Message-ID: <20190503152809.GB11605@8bytes.org>
References: <20190428234703.13697-1-tmurphy@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190428234703.13697-1-tmurphy@arista.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 12:47:02AM +0100, Tom Murphy wrote:
> check if there is a not-present cache present and flush it if there is.
> 
> Signed-off-by: Tom Murphy <tmurphy@arista.com>
> ---
>  drivers/iommu/amd_iommu.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)

Applied, thanks.

