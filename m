Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEDEE1BD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 14:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbfD2MAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Apr 2019 08:00:38 -0400
Received: from verein.lst.de ([213.95.11.211]:38096 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727913AbfD2MAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 08:00:38 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 27F0068AFE; Mon, 29 Apr 2019 14:00:21 +0200 (CEST)
Date:   Mon, 29 Apr 2019 14:00:20 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Christoph Hellwig <hch@lst.de>, mpe@ellerman.id.au,
        aneesh.kumar@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: remove the __kernel_io_end export
Message-ID: <20190429120020.GA30669@lst.de>
References: <20190429115241.12621-1-hch@lst.de> <20190429115706.GO8599@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429115706.GO8599@gate.crashing.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 06:57:06AM -0500, Segher Boessenkool wrote:
> On Mon, Apr 29, 2019 at 06:52:41AM -0500, Christoph Hellwig wrote:
> > This export was added in this merge window, but without any actual
> > user, or justification for a modular user.
> 
> Hi Christoph,
> 
> > -unsigned long __kernel_io_end;
> >  EXPORT_SYMBOL(__kernel_io_end);
> 
> Does that work?  Don't you need to remove that second line, as well?

Actually just the second line.  That's what you get for hacking things
up on the plane just before falling asleep, sigh..
