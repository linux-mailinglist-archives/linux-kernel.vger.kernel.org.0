Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA5FB6E07D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2019 07:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfGSFPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jul 2019 01:15:31 -0400
Received: from gate.crashing.org ([63.228.1.57]:33994 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbfGSFPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 01:15:31 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x6J5FFnH000351;
        Fri, 19 Jul 2019 00:15:16 -0500
Message-ID: <448cfd6b3e798dfbef45fa72e0819b1cb39cf68d.camel@kernel.crashing.org>
Subject: Re: [PATCH v2] nvme-pci: Support shared tags across queues for
 Apple 2018 controllers
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Pawlowski <paul@mrarm.io>, Jens Axboe <axboe@fb.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Date:   Fri, 19 Jul 2019 15:15:14 +1000
In-Reply-To: <BYAPR04MB58166CED3126757BEC56D3A8E7CB0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <f19ac710b4dc28fb3b59ef11bd06d341bc939f3d.camel@kernel.crashing.org>
         <BYAPR04MB58168C42A68712287F734242E7CB0@BYAPR04MB5816.namprd04.prod.outlook.com>
         <bc856389e6b09f7c545144be0f370f7ad3b05784.camel@kernel.crashing.org>
         <BYAPR04MB58166CED3126757BEC56D3A8E7CB0@BYAPR04MB5816.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-07-19 at 05:01 +0000, Damien Le Moal wrote:
> > I suppose that would work and be simpler. I honestly don't know much
> > about the block layer and tag allocation so I stayed away from it :-)
> > 
> > I'll dig, but a hint would be welcome :)
> 
> Uuuh.. Never played with the tag management code directly myself either. A quick
> look seem to indicate that blk_mq_get/put_tag() is what you should be using. But
> further looking, struct blk_mq_tags has the field nr_reserved_tags which is used
> as an offset start point for searching free tags, which is exactly what you
> would need.

Yup. I was getting there, it's just that we use the tagset mess which I
had to untangle a bit first :-)

Cheers,
Ben.

