Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95C8BBD4B9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 23:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633595AbfIXV7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 17:59:31 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:45924 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387723AbfIXV7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 17:59:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id B3C5D8EE175;
        Tue, 24 Sep 2019 14:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1569362370;
        bh=uW9yHyVMd+iv3gWkWuuWS6RrXxoBB+KwpZEHrxJLrfU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=O8XMN3kdXIPTbxUwCC+yvDgCK6kxoQ1AVgYkJ3sHY0B5I/tYLPbKdY8Zk15WXAxpf
         nwOM1LWs7pDqIvECsh37FfhhcQF2MB6rU0bgRPJ88mgbZl+QozFGBn/85UNOQgEsRV
         GpZpqSAngHQDlDv5BxxAWcKCvDenp3nYP/wIPshs=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yKFYae1JZIO6; Tue, 24 Sep 2019 14:59:30 -0700 (PDT)
Received: from [192.168.101.242] (unknown [24.246.103.29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id E1F5E8EE12C;
        Tue, 24 Sep 2019 14:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1569362370;
        bh=uW9yHyVMd+iv3gWkWuuWS6RrXxoBB+KwpZEHrxJLrfU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=O8XMN3kdXIPTbxUwCC+yvDgCK6kxoQ1AVgYkJ3sHY0B5I/tYLPbKdY8Zk15WXAxpf
         nwOM1LWs7pDqIvECsh37FfhhcQF2MB6rU0bgRPJ88mgbZl+QozFGBn/85UNOQgEsRV
         GpZpqSAngHQDlDv5BxxAWcKCvDenp3nYP/wIPshs=
Message-ID: <1569362368.5364.19.camel@HansenPartnership.com>
Subject: Re: allow larger than require DMA masks
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sven Schnelle <svens@stackframe.org>, Helge Deller <deller@gmx.de>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 24 Sep 2019 17:59:28 -0400
In-Reply-To: <20190924212554.GA31357@lst.de>
References: <20190215144559.8777-1-hch@lst.de>
         <20190923211415.GA1875@stackframe.org>
         <1569286782.3657.29.camel@HansenPartnership.com>
         <20190924212554.GA31357@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-09-24 at 23:25 +0200, Christoph Hellwig wrote:
> On Mon, Sep 23, 2019 at 08:59:42PM -0400, James Bottomley wrote:
> > > 	if (mask > ~0U)
> > > »     »       return 0;
> > > 
> > > Removing the if() makes the DMA mapping work. It's almost
> > > midnight here, so i won't look into that any further today. Does
> > > anyone have an opinion on this behaviour? Otherwise i will look a
> > > bit more into this in the next days.
> > 
> > The reason for the if was to kick the device into 32 bit
> > descriptors, which are usually more efficient, especially with
> > older dual descriptor format cards like we have on parisc systems.
> 
> These days we use the dma_get_required_mask API to query for that.

It looks like sym53c8xx didn't get the memo.  On the other hand, I'm
fairly certain it should be compiled in addressing mode zero on all
parisc systems (since all the 64 bit ones have iommus), so I think we
can take care of this ourselves.

> Svens patch looks right for how we are now using the DMA mask setting
> API.

Agreed.

James

