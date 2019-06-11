Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4426F3D0C2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 17:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390426AbfFKP07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 11:26:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:57472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387864AbfFKP06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 11:26:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E6252080A;
        Tue, 11 Jun 2019 15:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560266818;
        bh=1zBlTS3Nie+mVMEnxT8ngtbUEWBVODf4UqfieGxASKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R6z3c2Wfvs1aSYFX2p/bQ8TdbkA8+VWR6+YduaGWCiMIADIM2sRkbsl9+iTmO40/8
         0se38PEGyvAGb8TRdb4ph0aPgJ9chqojwEkY83ethTGWXuIeDWvW8gZ+wT3xrk47KY
         NzuGx81caV4zNIhtctzfiYZVsHOilPnq/uVdW9rI=
Date:   Tue, 11 Jun 2019 17:26:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@infradead.org>,
        Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/8] habanalabs: enable 64-bit DMA mask in POWER9
Message-ID: <20190611152655.GA3972@kroah.com>
References: <20190611092144.11194-1-oded.gabbay@gmail.com>
 <20190611095857.GB24058@kroah.com>
 <20190611151753.GA11404@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611151753.GA11404@infradead.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 08:17:53AM -0700, Christoph Hellwig wrote:
> On Tue, Jun 11, 2019 at 11:58:57AM +0200, Greg KH wrote:
> > That feels like a big hack.  ppc doesn't have any "what arch am I
> > running on?" runtime call?  Did you ask on the ppc64 mailing list?  I'm
> > ok to take this for now, but odds are you need a better fix for this
> > sometime...
> 
> That isn't the worst part of it.  The whole idea of checking what I'm
> running to set a dma mask just doesn't make any sense at all.

Oded, I thought I asked if there was a dma call you should be making to
keep this type of check from being needed.  What happened to that?  As
Christoph points out, none of this should be needed, which is what I
thought I originally said :)

thanks,

greg k-h
