Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56163B1904
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2019 09:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbfIMHhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Sep 2019 03:37:55 -0400
Received: from 8bytes.org ([81.169.241.247]:54284 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728280AbfIMHhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 03:37:54 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id D82FF327; Fri, 13 Sep 2019 09:37:52 +0200 (CEST)
Date:   Fri, 13 Sep 2019 09:37:52 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org, kernel@pengutronix.de,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 1/2] iommu: pass cell_count = -1 to
 of_for_each_phandle with cells_name
Message-ID: <20190913073752.GA4520@8bytes.org>
References: <20190824132846.8589-1-u.kleine-koenig@pengutronix.de>
 <20190903125210.GB11530@8bytes.org>
 <20190912074353.wqohpfydjxueqade@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190912074353.wqohpfydjxueqade@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 09:43:53AM +0200, Uwe Kleine-König wrote:
> On Tue, Sep 03, 2019 at 02:52:10PM +0200, Joerg Roedel wrote:
> > Acked-by: Joerg Roedel <jroedel@suse.de>
> 
> Does this ack mean that Rob is expected to apply this together with
> patch 2?

"Expected" is a strong word. I'd more phrase it like I am fine with this
patch going through his tree.

Regards,

	Joerg
