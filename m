Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9846156295
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 08:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfFZGtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 02:49:10 -0400
Received: from verein.lst.de ([213.95.11.211]:40589 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbfFZGtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 02:49:10 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 0462268B05; Wed, 26 Jun 2019 08:48:38 +0200 (CEST)
Date:   Wed, 26 Jun 2019 08:48:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mark Greer <mgreer@animalcreek.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Dale Farnsworth <dale@farnsworth.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: DMA coherency in drivers/tty/serial/mpsc.c
Message-ID: <20190626064837.GA24531@lst.de>
References: <20190625122641.GA4421@lst.de> <20190625163722.GA18626@animalcreek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190625163722.GA18626@animalcreek.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 09:37:22AM -0700, Mark Greer wrote:
> Yeah, the mpsc driver had lots of ugly cache related hacks because of
> cache coherency bugs in the early version of the MV64x60 bridge chips
> that it was embedded in.  That chip is pretty much dead now and I've
> removed core support for it from the powerpc tree.  Removing the mpsc
> driver is on my todo list but I've been busy and lazy.  So, to sum it
> up, don't spend any more time worrying about it as it should be removed.
> 
> I'll post a patch to do that tonight and I'm sorry for any time you've
> spent looking at it so far.

No problem.  And if future such broken chips show up we now have
support for per-device DMA coherency settings and could actually
handle it in a reaѕonably clean way.
