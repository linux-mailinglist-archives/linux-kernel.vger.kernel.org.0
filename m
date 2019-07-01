Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C80917F71
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 20:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfEHSAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 14:00:05 -0400
Received: from verein.lst.de ([213.95.11.211]:41065 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727020AbfEHSAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 14:00:05 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id D6BED67358; Wed,  8 May 2019 19:59:44 +0200 (CEST)
Date:   Wed, 8 May 2019 19:59:44 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jon Mason <jdmason@kudzu.us>
Cc:     Christoph Hellwig <hch@lst.de>, Muli Ben-Yehuda <mulix@mulix.org>,
        x86@kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: status of the calgary iommu driver
Message-ID: <20190508175944.GA32128@lst.de>
References: <20190409140347.GA11524@lst.de> <CAPoiz9wwMCRkzM5FWm18kecC1=kt+5qPNHmQ7eUFhH=3ZNAqYw@mail.gmail.com> <20190508175219.GA32030@lst.de> <CAPoiz9zQuJ0-9wJBNo=Wvi9qquyid9vjmHODy=VJad_PE=cgdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPoiz9zQuJ0-9wJBNo=Wvi9qquyid9vjmHODy=VJad_PE=cgdA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 06:56:46PM +0100, Jon Mason wrote:
> I do have a system.  So, it could be tested.  However given the age of
> the HW, I would say it is not worth the effort to update and it would
> be best to remove it from the kernel.
> 
> I can send a patch to do this, unless you would prefer to do it (or
> already have something handy).

I don't have anything, and at least to me it is not urgent.  So feel
free to send it.
