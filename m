Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E71E232DA7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 12:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbfFCKSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 06:18:41 -0400
Received: from 8bytes.org ([81.169.241.247]:41022 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726547AbfFCKSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 06:18:41 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 147B436B; Mon,  3 Jun 2019 12:18:40 +0200 (CEST)
Date:   Mon, 3 Jun 2019 12:18:37 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Magnus Damm <damm+renesas@opensource.se>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        iommu@lists.linux-foundation.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] iommu/ipmmu-vmsa: Suspend/resume support and
 assorted cleanups
Message-ID: <20190603101836.GI12745@8bytes.org>
References: <20190527115253.2114-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527115253.2114-1-geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 01:52:47PM +0200, Geert Uytterhoeven wrote:
> Geert Uytterhoeven (6):
>   iommu/ipmmu-vmsa: Link IOMMUs and devices in sysfs
>   iommu/ipmmu-vmsa: Prepare to handle 40-bit error addresses
>   iommu/ipmmu-vmsa: Make IPMMU_CTX_MAX unsigned
>   iommu/ipmmu-vmsa: Move num_utlbs to SoC-specific features
>   iommu/ipmmu-vmsa: Extract hardware context initialization
>   iommu/ipmmu-vmsa: Add suspend/resume support

Applied, thanks Geert.
