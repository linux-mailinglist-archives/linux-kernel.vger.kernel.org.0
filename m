Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCCA112A0A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 12:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfLDLZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Dec 2019 06:25:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:38052 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727445AbfLDLZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 06:25:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D53B0B1C0;
        Wed,  4 Dec 2019 11:25:02 +0000 (UTC)
Subject: Re: [PATCH 1/6] dt-bindings: clock: add bindings for RTD1619 clocks
To:     James Tai <james.tai@realtek.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>,
        =?UTF-8?B?RWRnYXIgTGVlIFvmnY7mib/oq61d?= <cylee12@realtek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20191203074513.9416-1-james.tai@realtek.com>
 <20191203074513.9416-2-james.tai@realtek.com>
 <f069747b-7f10-f47c-684d-11138b8fd129@suse.de>
 <1130d9316ffb49c8a99b9b2c2d8fa90f@realtek.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <da35686d-2584-a13f-b56e-ba3ff9768113@suse.de>
Date:   Wed, 4 Dec 2019 12:25:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <1130d9316ffb49c8a99b9b2c2d8fa90f@realtek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

[fixing Palmer]

Am 04.12.19 um 05:11 schrieb James Tai:
>> Am 03.12.19 um 08:45 schrieb James Tai:
>>> From: cylee12 <cylee12@realtek.com>
>>
>> Please fix the author (git commit --amend --author="...") and use an
>> appropriate git config setting (and communication to your team) to avoid this
>> reoccurring for new commits - already pointed out to James.
>>
>> BTW I wonder why we have so many seemingly unrelated people in CC
>> (Mediatek, RISC-V) that the patches and responses keep hanging in mailing list
>> moderation?
> 
> I used the "get_maintainer.pl" to find the email address of maintainers. However, 
> I'm so sorry for mistakenly adding some unrelated people to this mail.

Here's my git-send-email cccmd config that I recommend:

$ git config sendemail.cccmd
scripts/get_maintainer.pl --nogit-fallback --norolestats

--nogit-fallback suppresses Git history to be checked for previous
contributors, saving time and avoiding unrelated or outdated people.

--norolestats suppresses extensive "(...)" comments for the email
addresses, which might wrap and break during transmission or when people
reply.

In addition you obviously need to configure sendemail.to, and you may
want to add multiple cc lines to [sendemail] in your .git/config to
ensure all mails including cover letters reach LKML and LAKML, too:

$ git config --get-all sendemail.to
linux-realtek-soc@lists.infradead.org
$ git config --get-all sendemail.cc
linux-arm-kernel@lists.infradead.org
linux-kernel@vger.kernel.org

Further, you need to ensure that you are sending from the right branch,
so that the latest MAINTAINERS file and scripts get used. As Paul
pointed out, Palmer's address is fixed in both linux-next and linux, so
it is really puzzling where you got that old address from...

Not understanding your setup, you'll have to debug on your own where
those addresses came from. Try git send-email --dry-run to review the CC
addresses before you send. You could also temporarily use --rolestats to
see the MAINTAINERS section they came from.

On the bright side, this time your patches arrived threaded correctly.

Regards,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
