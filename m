Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE2D132785
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jan 2020 14:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbgAGNZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jan 2020 08:25:33 -0500
Received: from 8bytes.org ([81.169.241.247]:59200 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727806AbgAGNZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 08:25:33 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id AB6472AA; Tue,  7 Jan 2020 14:25:31 +0100 (CET)
Date:   Tue, 7 Jan 2020 14:25:30 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     robdclark@gmail.com, bjorn.andersson@linaro.org, agross@kernel.org,
        iommu@lists.linux-foundation.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/qcom: fix NULL pointer dereference during probe
 deferral
Message-ID: <20200107132530.GC30750@8bytes.org>
References: <20200101033949.755-1-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200101033949.755-1-masneyb@onstation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 31, 2019 at 10:39:49PM -0500, Brian Masney wrote:
>  drivers/iommu/qcom_iommu.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

Shortened commit-message a bit and applied for v5.5, thanks.

