Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8B9BD43E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 23:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633528AbfIXV0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 17:26:04 -0400
Received: from verein.lst.de ([213.95.11.211]:52754 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441769AbfIXVZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 17:25:59 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3E12D68B05; Tue, 24 Sep 2019 23:25:55 +0200 (CEST)
Date:   Tue, 24 Sep 2019 23:25:54 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Sven Schnelle <svens@stackframe.org>,
        Christoph Hellwig <hch@lst.de>, Helge Deller <deller@gmx.de>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: allow larger than require DMA masks
Message-ID: <20190924212554.GA31357@lst.de>
References: <20190215144559.8777-1-hch@lst.de> <20190923211415.GA1875@stackframe.org> <1569286782.3657.29.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1569286782.3657.29.camel@HansenPartnership.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 08:59:42PM -0400, James Bottomley wrote:
> > 	if (mask > ~0U)
> > »     »       return 0;
> > 
> > Removing the if() makes the DMA mapping work. It's almost midnight
> > here, so i won't look into that any further today. Does anyone have
> > an opinion on this behaviour? Otherwise i will look a bit more into
> > this in the next days.
> 
> The reason for the if was to kick the device into 32 bit descriptors,
> which are usually more efficient, especially with older dual descriptor
> format cards like we have on parisc systems.

These days we use the dma_get_required_mask API to query for that.

Svens patch looks right for how we are now using the DMA mask setting
API.
