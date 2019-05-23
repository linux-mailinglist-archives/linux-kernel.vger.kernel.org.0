Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1C9279F5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 12:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729976AbfEWKCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 06:02:01 -0400
Received: from foss.arm.com ([217.140.101.70]:42050 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726846AbfEWKCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 06:02:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABE7E341;
        Thu, 23 May 2019 03:02:00 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5474C3F718;
        Thu, 23 May 2019 03:01:59 -0700 (PDT)
Date:   Thu, 23 May 2019 11:01:56 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: Bad virt_to_phys since commit 54c7a8916a887f35
Message-ID: <20190523100156.GE26646@fuggles.cambridge.arm.com>
References: <20190516133820.GA43059@lakrids.cambridge.arm.com>
 <20190516134105.GB43059@lakrids.cambridge.arm.com>
 <e70ead93-2fe9-faf9-9e77-9df15809bad6@arm.com>
 <20190516141640.GC43059@lakrids.cambridge.arm.com>
 <d265e5fe-c061-17a0-427d-0e6f31be17f3@arm.com>
 <20190523093138.GB26646@fuggles.cambridge.arm.com>
 <20190523095405.GE23850@rapoport-lnx>
 <f11fdcc0-ab77-378f-b1b8-341bdae36de1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f11fdcc0-ab77-378f-b1b8-341bdae36de1@arm.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 10:58:19AM +0100, Steven Price wrote:
> On 23/05/2019 10:54, Mike Rapoport wrote:
> > On Thu, May 23, 2019 at 10:31:38AM +0100, Will Deacon wrote:
> >> Hi Steven,
> >>
> >> On Thu, May 16, 2019 at 03:20:59PM +0100, Steven Price wrote:
> >>> I'll spin a real patch and add your Tested-by
> >>
> >> Did you send this out? I can't spot it in my inbox.
> >  
> > https://lore.kernel.org/lkml/20190516143125.48948-1-steven.price@arm.com
> > 
> > And Andrew already took it to the -mm tree.
> 
> And it's made its way to Linus' tree:
> commit 5d59aa8f9ce972b472201aed86e904bb75879ff0

Perfect, thanks. Sorry for the noise.

Will
