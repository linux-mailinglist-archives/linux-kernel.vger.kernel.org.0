Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C65E8CE54
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 10:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfHNIY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 04:24:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:37652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbfHNIY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 04:24:26 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF69120843;
        Wed, 14 Aug 2019 08:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565771065;
        bh=dOIAznLWxzP0u+OSBAYPKB0yVmhsjJLY8I+qEiU4L9U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RG1qK+Pt18ss2tHX2RNIruXp2UeFxF2bDhRkagJoZReWFhDZXfEow8U4TKl/u2GxN
         FENR3KwZzH+xJs6V8b8E+Ohi9E8ucLSz+ossd+rc+oGgpJmG4CckHXL9yVuGjvDcgq
         xabdFyMBFyhejTyori5x2p9Mwh+6uhFGWeunN1hU=
Date:   Wed, 14 Aug 2019 09:24:20 +0100
From:   Will Deacon <will@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        Matthias Kaehlcke <mka@chromium.org>, cui.zhang@mediatek.com,
        chao.hao@mediatek.com, ming-fan.chen@mediatek.com
Subject: Re: [PATCH v9 00/21] MT8183 IOMMU SUPPORT
Message-ID: <20190814082419.tppi3o4x27qotkn6@willie-the-truck>
References: <1565423901-17008-1-git-send-email-yong.wu@mediatek.com>
 <20190814081825.GA22669@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814081825.GA22669@8bytes.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 10:18:25AM +0200, Joerg Roedel wrote:
> On Sat, Aug 10, 2019 at 03:58:00PM +0800, Yong Wu wrote:
> > Change notes:
> > v9:
> >    1) rebase on v5.3-rc1.
> >    2) In v7s, Use oas to implement MTK 4GB mode. It nearly reconstruct the
> >       patch, so I don't keep the R-b.
> 
> Okay, this looks close to being ready, just the io-pgtable patches still
> need review.

On my list for today :) (Today is SMMU day for me. Send coffee.)

Will
