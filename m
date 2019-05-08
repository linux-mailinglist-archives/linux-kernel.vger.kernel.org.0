Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAE8180E3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 22:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfEHUOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 16:14:41 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:51640 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbfEHUOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 16:14:41 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d8])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 19A8A12B05D2B;
        Wed,  8 May 2019 13:14:41 -0700 (PDT)
Date:   Wed, 08 May 2019 13:14:40 -0700 (PDT)
Message-Id: <20190508.131440.579353613998007502.davem@davemloft.net>
To:     axboe@kernel.dk
Cc:     hch@lst.de, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ide: officially deprecated the legacy IDE driver
From:   David Miller <davem@davemloft.net>
In-Reply-To: <c0332901-27ac-7d8c-7bee-a1d7616627f8@kernel.dk>
References: <20190508180140.12364-1-hch@lst.de>
        <c0332901-27ac-7d8c-7bee-a1d7616627f8@kernel.dk>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 08 May 2019 13:14:41 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>
Date: Wed, 8 May 2019 12:08:49 -0600

> On 5/8/19 12:01 PM, Christoph Hellwig wrote:
>> After a recent chat with Dave we agreed to try to finally kill off the
>> legacy IDE code base.  Set a two year grace period in which we try
>> to move everyone over.  There are a few pieces of hardware not
>> supported by libata yet, but for many of them we aren't even sure
>> if there are any users.  For those that have users we have usually
>> found a volunteer to add libata support.
> 
> I fully support this.
> 
> Acked-by: Jens Axboe <axboe@kernel.dk>

Yeah I totally support this too, I'll apply.
