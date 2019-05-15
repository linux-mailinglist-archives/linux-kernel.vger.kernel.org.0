Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1D331FC9B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 00:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfEOWmT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 15 May 2019 18:42:19 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:57004 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfEOWmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 18:42:18 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 62E226083269;
        Thu, 16 May 2019 00:42:16 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 29sXjIG9xhFg; Thu, 16 May 2019 00:42:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 293E9608326A;
        Thu, 16 May 2019 00:42:15 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PGqMw6b-hVq2; Thu, 16 May 2019 00:42:15 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id EDF4C6083269;
        Thu, 16 May 2019 00:42:14 +0200 (CEST)
Date:   Thu, 16 May 2019 00:42:14 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Joe Perches <joe@perches.com>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <494585403.60051.1557960134909.JavaMail.zimbra@nod.at>
In-Reply-To: <391f21cf5f04c61b75e739f67c8a308864b4e68c.camel@perches.com>
References: <20190515200423.17809-1-richard@nod.at> <391f21cf5f04c61b75e739f67c8a308864b4e68c.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: Update UBI/UBIFS git tree location
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.8_GA_3025 (ZimbraWebClient - FF60 (Linux)/8.8.8_GA_1703)
Thread-Topic: MAINTAINERS: Update UBI/UBIFS git tree location
Thread-Index: o5MYdfaQzQvdZiRYyG/tqbW6MDBO/A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Joe Perches" <joe@perches.com>
> An: "richard" <richard@nod.at>, "linux-mtd" <linux-mtd@lists.infradead.org>
> CC: "linux-kernel" <linux-kernel@vger.kernel.org>
> Gesendet: Donnerstag, 16. Mai 2019 00:29:48
> Betreff: Re: [PATCH] MAINTAINERS: Update UBI/UBIFS git tree location

> On Wed, 2019-05-15 at 22:04 +0200, Richard Weinberger wrote:
>> Linus asked to use kernel.org.
>> 
>> Signed-off-by: Richard Weinberger <richard@nod.at>
>> ---
>>  MAINTAINERS | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 5c38f21aee78..ba428cd613b8 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -15879,7 +15879,7 @@ M:	Richard Weinberger <richard@nod.at>
>>  M:	Artem Bityutskiy <dedekind1@gmail.com>
>>  M:	Adrian Hunter <adrian.hunter@intel.com>
>>  L:	linux-mtd@lists.infradead.org
>> -T:	git git://git.infradead.org/ubifs-2.6.git
>> +T:	git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git
> 
> Please keep the initial separate git
> 
> T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git

Will fix.

Thanks,
//richard
