Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B71B9A45C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 02:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732178AbfHWAmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 20:42:22 -0400
Received: from gate.crashing.org ([63.228.1.57]:59248 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732116AbfHWAmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 20:42:22 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x7N0fnv4022896;
        Thu, 22 Aug 2019 19:41:51 -0500
Message-ID: <fb5aa2db6b54edab69a8abad254b346dd3d7b205.camel@kernel.crashing.org>
Subject: Re: [PATCH v4 2/4] nvme-pci: Add support for variable IO SQ element
 size
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-kernel@vger.kernel.org, Paul Pawlowski <paul@mrarm.io>
Date:   Fri, 23 Aug 2019 10:41:49 +1000
In-Reply-To: <4fc11568-73fe-c8b5-ac29-d49daee9abad@grimberg.me>
References: <20190807075122.6247-1-benh@kernel.crashing.org>
         <20190807075122.6247-3-benh@kernel.crashing.org>
         <20190822002818.GA10391@lst.de>
         <87e1fea1c297ef98f989175b3041c69e8b7de020.camel@kernel.crashing.org>
         <4fc11568-73fe-c8b5-ac29-d49daee9abad@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-22 at 11:02 -0700, Sagi Grimberg wrote:
> > > 
> I'll fix it. Note that I'm going to take it out of the tree soon
> because it will have conflicts with Jens for-5.4/block, so we
> will send it to Jens after the initial merge window, after he
> rebases off of Linus.

Conflicts too hard to fixup at merge time ? Otherwise I could just
rebase on top of Jens and put in a topic branch...

Whatever works for you.

Cheers,
Ben.


