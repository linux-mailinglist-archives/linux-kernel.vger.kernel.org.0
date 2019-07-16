Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 412EF6A8A9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 14:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732246AbfGPMZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 08:25:11 -0400
Received: from verein.lst.de ([213.95.11.211]:41320 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbfGPMZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 08:25:11 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 58470227A81; Tue, 16 Jul 2019 14:25:08 +0200 (CEST)
Date:   Tue, 16 Jul 2019 14:25:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        Keith Busch <kbusch@kernel.org>, Paul Pawlowski <paul@mrarm.io>
Subject: Re: [PATCH 2/3] nvme: Retrieve the required IO queue entry size
 from the controller
Message-ID: <20190716122508.GA3304@lst.de>
References: <20190716004649.17799-1-benh@kernel.crashing.org> <20190716004649.17799-2-benh@kernel.crashing.org> <20190716060430.GB29414@lst.de> <ad18ff8d004225e102076f8e1fb617916617f337.camel@kernel.crashing.org> <20190716093301.GA32562@lst.de> <bfbc7352951d1adc714f699acb49e298c24fe7e3.camel@kernel.crashing.org> <20190716120547.GA2388@lst.de> <cca6fd560aa1688ca94fc270310a91ccda9aed06.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cca6fd560aa1688ca94fc270310a91ccda9aed06.camel@kernel.crashing.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 10:17:56PM +1000, Benjamin Herrenschmidt wrote:
> If we're going to do that, then I can move it back to pci.c and leave
> core.c alone then I suppose. Up to you. I'm just doing that for fun, no
> beef in that game :-) let me know how you want it.

Sounds safest to me.
