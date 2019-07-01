Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 716F75BB52
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2019 14:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbfGAMQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jul 2019 08:16:50 -0400
Received: from 8bytes.org ([81.169.241.247]:33620 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727302AbfGAMQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 08:16:50 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 6B6A2229; Mon,  1 Jul 2019 14:16:49 +0200 (CEST)
Date:   Mon, 1 Jul 2019 14:16:48 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Tom Murphy <murphyt7@tcd.ie>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iommu/amd: Flush not present cache in iommu_map_page
Message-ID: <20190701121647.GC8166@8bytes.org>
References: <20190613220455.6599-1-murphyt7@tcd.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613220455.6599-1-murphyt7@tcd.ie>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 11:04:55PM +0100, Tom Murphy wrote:
>  drivers/iommu/amd_iommu.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)

Applied, thanks.
