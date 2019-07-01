Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3341F41D1E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 09:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407794AbfFLHBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 03:01:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50494 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404851AbfFLHBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 03:01:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=U7CBgI/BlOH8mCpak6QJYkxnxyBdoEy/BPSE3vs157A=; b=Bzb3btvII+xO775JFm+/k4qqn
        eHS/t3brEGYdMoJtVpIGT5EN2xaM3k7I71ALJsbbc+0vNmy8E6uGvgXyQb2ZqWuEQyPxy2lL/TD3s
        uMzXPuNdC+uyOv3QLqxtZjr8Jjdtu3o3eUUIx3Odo483jPATMKUouu0blV4M0xTAkF80OunW1Z7jF
        LBBOFvv+p2bswnZmudxhQwgVJUYeAJZYogoM/0PEtY6Al28wR3Z4Vx7kZQiirCPrJws0g+8seZO/f
        e7jBGxpuGd5dCTGNxlOOHGOrTTq6GAsoeq9Y0FUPBC8IR1BqktaTs9S5schf5x3nbgz3iU4CAiqDE
        YCgQ3nYWA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1haxFu-0005GR-Tc; Wed, 12 Jun 2019 07:01:10 +0000
Date:   Wed, 12 Jun 2019 00:01:10 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     John Dorminy <jdorminy@redhat.com>
Cc:     Mike Snitzer <snitzer@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        NeilBrown <neilb@suse.com>, linux-block@vger.kernel.org,
        device-mapper development <dm-devel@redhat.com>,
        Milan Broz <gmazyland@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: block: be more careful about status in __bio_chain_endio
Message-ID: <20190612070110.GA11707@infradead.org>
References: <70cda2a3-f246-d45b-f600-1f9d15ba22ff@gmail.com>
 <87eflmpqkb.fsf@notabene.neil.brown.name>
 <20190222211006.GA10987@redhat.com>
 <7f0aeb7b-fdaa-0625-f785-05c342047550@kernel.dk>
 <20190222235459.GA11726@redhat.com>
 <CAMeeMh-2ANOr_Sb66EyA_HULkVRudD7fyOZsDbpRpDrshwnR2w@mail.gmail.com>
 <20190223024402.GA12407@redhat.com>
 <CAMeeMh9qLkTByWJewPR4o844wPkA-g5Hnm7aGjszuPopPAe8vA@mail.gmail.com>
 <CAMeeMh-6KMLgriX_7KT52ynjBMyT9yDWSMKv6YXW+yDpvv0=wA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMeeMh-6KMLgriX_7KT52ynjBMyT9yDWSMKv6YXW+yDpvv0=wA@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 10:56:42PM -0400, John Dorminy wrote:
> I believe the second of these might, but is not guaranteed to,
> preserve the first error observed in a child; I believe if you want to
> definitely save the first error you need an atomic.

Is there any reason not to simply use a cmpxchg?  Yes, it is a
relatively expensive operation, but once we are chaining bios we are out
of the super hot path anyway.  We do something similar in xfs and iomap
already.
