Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B54E85BFD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 09:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731504AbfHHHtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 03:49:02 -0400
Received: from verein.lst.de ([213.95.11.211]:44133 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbfHHHtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 03:49:02 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B117968B02; Thu,  8 Aug 2019 09:48:58 +0200 (CEST)
Date:   Thu, 8 Aug 2019 09:48:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: Regression due to d98849aff879 (dma-direct: handle
 DMA_ATTR_NO_KERNEL_MAPPING in common code)
Message-ID: <20190808074858.GA30308@lst.de>
References: <1565082809.2323.24.camel@pengutronix.de> <20190806113318.GA20215@lst.de> <41cc93b1-62b5-7fb6-060d-01982e68503b@amd.com> <20190806140408.GA22902@lst.de> <1565100418.2323.32.camel@pengutronix.de> <20190806154403.GA25050@lst.de> <1565191457.2323.41.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565191457.2323.41.camel@pengutronix.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 05:24:17PM +0200, Lucas Stach wrote:
> I would suggest to place this line above the comment, as the comment
> only really applies to the return value. Other than this nitpick, this
> matches my understanding of the required changes, so:
> 
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

Thanks, I've applied it with that fixed up.
