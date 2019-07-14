Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3C486818E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2019 01:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbfGNXXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Jul 2019 19:23:55 -0400
Received: from ale.deltatee.com ([207.54.116.67]:44662 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728853AbfGNXXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 19:23:55 -0400
Received: from s0106602ad0811846.cg.shawcable.net ([68.147.191.165] helo=[192.168.0.12])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hmOMn-0000my-Rt; Sat, 13 Jul 2019 14:11:42 -0600
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
References: <20190712224207.22061-1-logang@deltatee.com>
 <20190713072603.GA17589@lst.de>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <1c94ac2c-a708-1e82-d11c-dd15f8a9229e@deltatee.com>
Date:   Sat, 13 Jul 2019 14:10:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190713072603.GA17589@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.191.165
X-SA-Exim-Rcpt-To: chaitanya.kulkarni@wdc.com, sagi@grimberg.me, linux-kernel@vger.kernel.org, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH] nvmet-file: fix nvmet_file_flush() always returning an
 error
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-07-13 1:26 a.m., Christoph Hellwig wrote:
> On Fri, Jul 12, 2019 at 04:42:07PM -0600, Logan Gunthorpe wrote:
>> errno_to_nvme_status() doesn't take into account the case
>> when errno=0, all other use cases only call it if there is actually
>> an error.
> 
> Might it make more sense to handle 0 in errno_to_nvme_status to avoid
> future problems like this one as well?  That would also match the
> similar blk_to_nvme_status function better.

Sure, I'll send a v2 with that approach next week.

I had assumed that it was done this way for performance reasons so I
followed the way it was done in the other call sites.

Logan
