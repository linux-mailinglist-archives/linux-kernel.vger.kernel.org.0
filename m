Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42565153C3D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Feb 2020 01:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbgBFAKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 19:10:24 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:60240 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbgBFAKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 19:10:24 -0500
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 6D6175C406B;
        Thu,  6 Feb 2020 01:10:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1580947822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=18oLXlafeIKEhZ+0cWGBZ+Cl0L84U2vqE062kcOq5w4=;
        b=Dt1LR+DIWVzNUXR6Q4UeVY1xExAPyRwNMVsY65WEKxArSBkobJKSkPREkzavr61ClTQydT
        RDe7/mMJUoWpgR9w43RlX3KZcC/En2vHX6HtHHIheOe5FfVFLzGPEsZuzGGu5i/JbUHZF5
        qTFANSa0c2PDvF+XpZQx4fD7Q9H2FXc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Thu, 06 Feb 2020 01:10:22 +0100
From:   Stefan Agner <stefan@agner.ch>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     arnd@arndb.de, linus.walleij@linaro.org, akpm@linux-foundation.org,
        nsekhar@ti.com, mchehab+samsung@kernel.org,
        bgolaszewski@baylibre.com, armlinux@m.disordat.com,
        benjamin.gaignard@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] arm: make kexec depend on MMU
In-Reply-To: <20200205235327.GV25745@shell.armlinux.org.uk>
References: <5b595d37283f043df78259221f2b7d18e0cb0ce5.1580942558.git.stefan@agner.ch>
 <20200205235327.GV25745@shell.armlinux.org.uk>
User-Agent: Roundcube Webmail/1.4.1
Message-ID: <1c36a14d742d4a0736de00d2c74d7137@agner.ch>
X-Sender: stefan@agner.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-06 00:53, Russell King - ARM Linux admin wrote:
> Does patch 8951/1, which has been merged into mainline, not fix this?

Yes, that should take care of it. 

I discussed end of last year with Michal about this, and back then that
patch wasn't around. Should have checked master before re-sending this
patch. Sorry for the noise.

--
Stefan


> On Wed, Feb 05, 2020 at 11:43:44PM +0100, Stefan Agner wrote:
>> From: Michal Hocko <mhocko@suse.com>
>>
>> arm nommu config with KEXEC enabled doesn't compile
>> arch/arm/kernel/setup.c: In function 'reserve_crashkernel':
>> arch/arm/kernel/setup.c:1005:25: error: 'SECTION_SIZE' undeclared (first
>> use in this function)
>>              crash_size, SECTION_SIZE);
>>
>> since 61603016e212 ("ARM: kexec: fix crashkernel= handling") which is
>> over one year without anybody noticing. I have only noticed beause of
>> my testing nommu config which somehow gained CONFIG_KEXEC without
>> an intention. This suggests that nobody is actually using KEXEC
>> on nommu ARM configs. It is even a question whether kexec works with
>> nommu.
>>
>> Make KEXEC depend on MMU to make this clear. If somebody wants to enable
>> there will be probably more things to take care.
>>
>> Signed-off-by: Michal Hocko <mhocko@suse.com>
>> Reviewed-by: Stefan Agner <stefan@agner.ch>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>>  arch/arm/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 96dab76da3b3..59ce8943151f 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -1906,6 +1906,7 @@ config KEXEC
>>  	bool "Kexec system call (EXPERIMENTAL)"
>>  	depends on (!SMP || PM_SLEEP_SMP)
>>  	depends on !CPU_V7M
>> +	depends on MMU
>>  	select KEXEC_CORE
>>  	help
>>  	  kexec is a system call that implements the ability to shutdown your
>> --
>> 2.25.0
>>
>>
