Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C791D7F64
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 20:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbfJOSxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 14:53:48 -0400
Received: from gloria.sntech.de ([185.11.138.130]:38782 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727947AbfJOSxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 14:53:47 -0400
Received: from remote.shanghaihotelholland.com ([46.44.148.63] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iKRx0-0007gB-1p; Tue, 15 Oct 2019 20:53:42 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH] iommu: rockchip: Free domain on .domain_free
Date:   Tue, 15 Oct 2019 20:53:36 +0200
Message-ID: <2628046.Yh23E8A2S3@phil>
In-Reply-To: <20191002172923.22430-1-ezequiel@collabora.com>
References: <20191002172923.22430-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 2. Oktober 2019, 19:29:23 CEST schrieb Ezequiel Garcia:
> IOMMU domain resource life is well-defined, managed
> by .domain_alloc and .domain_free.
> 
> Therefore, domain-specific resources shouldn't be tied to
> the device life, but instead to its domain.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>

Acked-by: Heiko Stuebner <heiko@sntech.de>



