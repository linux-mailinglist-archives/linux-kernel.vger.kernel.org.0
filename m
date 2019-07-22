Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E06570C26
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 23:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731445AbfGVVzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 17:55:12 -0400
Received: from gate.crashing.org ([63.228.1.57]:51075 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726519AbfGVVzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 17:55:11 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x6MLsoj3012638;
        Mon, 22 Jul 2019 16:54:51 -0500
Message-ID: <00f7a7e127467c0de98b114f2fe38f836601eef8.camel@kernel.crashing.org>
Subject: Re: [PATCH v3] nvme-pci: Support shared tags across queues for
 Apple 2018 controllers
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Pawlowski <paul@mrarm.io>, Jens Axboe <axboe@fb.com>,
        Keith Busch <kbusch@kernel.org>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Date:   Tue, 23 Jul 2019 07:54:49 +1000
In-Reply-To: <91ef44522140bf83720f6c377648b307964d34e4.camel@kernel.crashing.org>
References: <b1f9bdf0294b8d87d292de3c7462c8e99551b02d.camel@kernel.crashing.org>
         <20190719122859.GA30193@lst.de>
         <91ef44522140bf83720f6c377648b307964d34e4.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-07-19 at 23:51 +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2019-07-19 at 14:28 +0200, Christoph Hellwig wrote:
> > Yikes, that things looks worse and worse.  I think at this point
> > we'll
> > have to defer the support to 5.4 unfortunately as it is getting more
> > and more involved..
> 
> Well, at least v3 of that patch, thanks to Damien's idea, isn't
> particularly invasive and I've hammered the SSD with it over night with
> a combination of IOs and smart commands, it's solid.
> 
> But if you prefer waiting for 5.4, no worries.

BTW. It's been solid for 3 days now, so I think that was the last of it
(famous last words...)

Cheers,
Ben.


