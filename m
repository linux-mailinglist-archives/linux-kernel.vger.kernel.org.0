Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4B815507
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2019 22:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfEFUpO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 6 May 2019 16:45:14 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:35268 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfEFUpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 16:45:13 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7FAFB608A381;
        Mon,  6 May 2019 22:45:11 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id EhAWvIAbFOvO; Mon,  6 May 2019 22:45:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 1A54D6083257;
        Mon,  6 May 2019 22:45:11 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TLHLxcvIUYPR; Mon,  6 May 2019 22:45:11 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id D52836083241;
        Mon,  6 May 2019 22:45:10 +0200 (CEST)
Date:   Mon, 6 May 2019 22:45:10 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Message-ID: <1062675236.47533.1557175510785.JavaMail.zimbra@nod.at>
In-Reply-To: <20190507064008.1ecba58b@canb.auug.org.au>
References: <20190507064008.1ecba58b@canb.auug.org.au>
Subject: Re: linux-next: Fixes tags need some work in the mtd tree
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.8_GA_3025 (ZimbraWebClient - FF60 (Linux)/8.8.8_GA_1703)
Thread-Topic: linux-next: Fixes tags need some work in the mtd tree
Thread-Index: BpVQHcYW0b9Fd4Xem7ZvYI4wRFdP7g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen,

----- Ursprüngliche Mail -----
> In commit
> 
>  d41970097f10 ("mtd: maps: Allow MTD_PHYSMAP with MTD_RAM")
> 
> Fixes tag
> 
>  Fixes: commit 642b1e8dbed7 ("mtd: maps: Merge physmap_of.c into physmap-core.c")
> 
> has these problem(s):
> 
>  - leading word 'commit' unexpected
> 
> In commit
> 
>  64d14c6fe040 ("mtd: maps: physmap: Store gpio_values correctly")
> 
> Fixes tag
> 
>  Fixes: commit ba32ce95cbd9 ("mtd: maps: Merge gpio-addr-flash.c into
>  physmap-core.c")
> 
> has these problem(s):
> 
>  - leading word 'commit' unexpected

What is the suggest approach to fix that?
Rebase and force-push?

Thanks,
//richard
