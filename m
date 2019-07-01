Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C41811FAF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 18:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfEBQD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 May 2019 12:03:29 -0400
Received: from mailgw2.fjfi.cvut.cz ([147.32.9.131]:56862 "EHLO
        mailgw2.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEBQD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 12:03:29 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailgw2.fjfi.cvut.cz (Postfix) with ESMTP id E6BA9A028C;
        Thu,  2 May 2019 18:03:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1556813006; i=@fjfi.cvut.cz;
        bh=2Ze/HvAXhuoo8WdLZh8zGvvHYRFvuAlI1idx06EoKYs=;
        h=Date:From:To:cc:Subject:In-Reply-To:References;
        b=im1U7FIJLWrHdHCEcXz6YTIex6F4oGahKzL0yTY/Q4FEsBI2hg8JWui9AX3HjQjIp
         yMm1ZI8ft3U01gwWNKyBJI1GpTFO2NI+h54UU8AFDZzYFDq9Bm1vopDNoZVZk4JlGo
         Axo2NJmLnx3/Pk437lKY/iHiQWk2JMmxMBo4WjSA=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw2.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw2.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id z1d07Ym63AVr; Thu,  2 May 2019 18:03:23 +0200 (CEST)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw2.fjfi.cvut.cz (Postfix) with ESMTPS id 73CFEA0264;
        Thu,  2 May 2019 18:03:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw2.fjfi.cvut.cz 73CFEA0264
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id 4123A6004D; Thu,  2 May 2019 18:03:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by linux.fjfi.cvut.cz (Postfix) with ESMTP id 1A15D6002A;
        Thu,  2 May 2019 18:03:23 +0200 (CEST)
Date:   Thu, 2 May 2019 18:03:23 +0200 (CEST)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
To:     Scott Bauer <sbauer@plzdonthack.me>
cc:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: Re: [PATCH 0/3] block: sed-opal: add support for shadow MBR done
 flag and write
In-Reply-To: <20190502123036.GA4657@hacktheplanet>
Message-ID: <alpine.LRH.2.21.1905021749060.929@linux.fjfi.cvut.cz>
References: <1556666459-17948-1-git-send-email-zub@linux.fjfi.cvut.cz> <20190502123036.GA4657@hacktheplanet>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 May 2019, Scott Bauer wrote:

> On Wed, May 01, 2019 at 01:20:56AM +0200, David Kozub wrote:
>>
>> Jonas Rabenstein (3):
>>   block: sed-opal: add ioctl for done-mark of shadow mbr
>>   block: sed-opal: ioctl for writing to shadow mbr
>>   block: sed-opal: check size of shadow mbr
>>
>>  block/opal_proto.h            |  16 ++++
>>  block/sed-opal.c              | 160 +++++++++++++++++++++++++++++++++-
>>  include/linux/sed-opal.h      |   2 +
>>  include/uapi/linux/sed-opal.h |  20 +++++
>>  4 files changed, 196 insertions(+), 2 deletions(-)
>>
>
> I'll review this over the weekend. Is this essentially the same thing
> we reviewed a month or two ago or are there little differences due to
> it be split across two different series?

The first patch (block: sed-opal: add ioctl for done-mark of shadow mbr) 
is a bit different because a new struct and enum were introduced. The rest 
is pretty much the same. That's also why I kept the reviewd-by tags.

Best regards,
David
