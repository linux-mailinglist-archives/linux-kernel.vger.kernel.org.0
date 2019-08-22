Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B75FE99A9C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 19:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731908AbfHVRO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 13:14:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:35300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391105AbfHVROY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:14:24 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13B182089E;
        Thu, 22 Aug 2019 17:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494063;
        bh=vqE2N/zi1fzhDJw+o9xdlWk9123wTSi4CKCbyRiWtHc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gTshqoq99M9s6kEqnvExZ9y43tJZ5RG6H7DJicnyp4xB0EEyG3E8dxsEeD+mtCaSN
         tPOnriBlWjBj6t3b/aXGqSnI7for4nxNhTc101nzXmKDqt5n+5VHe7Jxkot9Q6CAmx
         WfjOx+T5BTnDWixtTIskYdTH9FZDyzwtT6bJ2aG0=
Date:   Thu, 22 Aug 2019 18:14:16 +0100
From:   Will Deacon <will@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, youlin.pei@mediatek.com,
        devicetree@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        cui.zhang@mediatek.com, srv_heupstream@mediatek.com,
        chao.hao@mediatek.com, Joerg Roedel <joro@8bytes.org>,
        linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        ming-fan.chen@mediatek.com, anan.sun@mediatek.com,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v10 09/23] iommu/io-pgtable-arm-v7s: Extend to support
 PA[33:32] for MediaTek
Message-ID: <20190822171415.475yg7pmy6gfj35l@willie-the-truck>
References: <1566395606-7975-1-git-send-email-yong.wu@mediatek.com>
 <1566395606-7975-10-git-send-email-yong.wu@mediatek.com>
 <20190821152448.qmoqjh5zznfpdi6n@willie-the-truck>
 <1566464186.11621.7.camel@mhfsdcap03>
 <10d5122d-3375-161b-9356-2ddfc1c835bd@arm.com>
 <20190822101749.3kwzd5lb7zinsord@willie-the-truck>
 <e6652176-763d-5298-9e10-8c1fbe1b3c0d@arm.com>
 <20190822112836.efodtwu3souq3uwa@willie-the-truck>
 <1566475533.11621.18.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566475533.11621.18.camel@mhfsdcap03>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 08:05:33PM +0800, Yong Wu wrote:
> On Thu, 2019-08-22 at 12:28 +0100, Will Deacon wrote:
> > Ok, great. Yong Wu -- are you ok respinning with the above + missing
> > brackets?
> 
> Of course I can.
> 
> NearlyAll the interface in this file is prefixed with "arm_v7s_", so
> does the new interface also need it?, like arm_v7s_is_mtk_enabled. And
> keep the iopte_to_paddr and paddr_to_iopte symmetrical.
> 
> 
> Then the final patch would looks like below, is it ok?

Looks good to me:

Acked-by: Will Deacon <will@kernel.org>

Will
