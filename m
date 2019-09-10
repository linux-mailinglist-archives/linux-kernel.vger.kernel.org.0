Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8411EAE53C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 10:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405068AbfIJIRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 04:17:20 -0400
Received: from 8bytes.org ([81.169.241.247]:53740 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730510AbfIJIRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 04:17:19 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 8BBE34D9; Tue, 10 Sep 2019 10:17:18 +0200 (CEST)
Date:   Tue, 10 Sep 2019 10:17:16 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Adam Zerella <adam.zerella@gmail.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Fix sparse warnings
Message-ID: <20190910081716.GD3247@8bytes.org>
References: <20190907065812.19505-1-adam.zerella@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190907065812.19505-1-adam.zerella@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 07, 2019 at 04:58:12PM +1000, Adam Zerella wrote:
>  drivers/iommu/amd_iommu.c      |  4 ++--
>  drivers/iommu/amd_iommu_init.c | 12 ++++++------
>  2 files changed, 8 insertions(+), 8 deletions(-)

Applied, thanks.
