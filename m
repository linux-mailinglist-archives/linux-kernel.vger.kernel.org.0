Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9B6DAE3C5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 08:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393468AbfIJGdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 02:33:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42387 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729634AbfIJGdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 02:33:09 -0400
Received: from [192.168.4.140] (38.85.69.148.rev.vodafone.pt [148.69.85.38] (may be forged))
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x8A6Whi12604321
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 9 Sep 2019 23:32:45 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com x8A6Whi12604321
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019081901; t=1568097166;
        bh=M4Rnbdd+hBMC+MWdqNSpD8GkoZfmjy8tx/d4XPGtAhA=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=Pxtcidup6Gdn7/1hrKDmBExh97qyYca26tW4nhbkgDO+SwesZCS8beg00BcEud1Ku
         wbzZTgtVqyvUhtx+8wLEIHh7RuUJUmbXQWSaBYliD19LatO+KBanWaHral24Xp1+uK
         M15TgZ0jObx7FXR9EENpY5+peMYPcSMc642eyXMVM7wU5uj8iiXbmnAlragUUxFl9E
         8QaEAosw/BowfI3Bl2y2WZwl1ZhEZqjiqZEtvzDDvGivo1dwaBjGjvVGwe7Xw1rpYt
         SSAo3/5HjqDZn1ewRdItOdUtHotuMe1TcBIWb5Ny9YbJAeWkEXGZSGX0zKmo9HIHLg
         Ke6QzIqehFaYA==
Date:   Tue, 10 Sep 2019 07:32:33 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <20190910062828.GA40888@gmail.com>
References: <20190905232222.14900-1-bshanks@codeweavers.com> <7BFFC7D1-6158-4237-AEF9-D10635F054FC@zytor.com> <20190910062828.GA40888@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] x86/umip: Add emulation for 64-bit processes
To:     Ingo Molnar <mingo@kernel.org>
CC:     Brendan Shanks <bshanks@codeweavers.com>,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
From:   hpa@zytor.com
Message-ID: <193CDEE9-B533-4BFE-972E-384C00359945@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On September 10, 2019 7:28:28 AM GMT+01:00, Ingo Molnar <mingo@kernel=2Eorg=
> wrote:
>
>* hpa@zytor=2Ecom <hpa@zytor=2Ecom> wrote:
>
>> I would strongly suggest that we change the term "emulation" to=20
>> "spoofing" for these instructions=2E We need to explain that we do
>*not*=20
>> execute these instructions the was the CPU would have, and unlike the
>
>> native instructions do not leak kernel information=2E
>
>Ok, I've edited the patch to add the 'spoofing' wording where=20
>appropriate, and I also made minor fixes such as consistently=20
>capitalizing instruction names=2E
>
>Can I also add your Reviewed-by tag?
>
>So the patch should show up in tip:x86/asm today-ish, and barring any=20
>complications is v5=2E4 material=2E
>
>Thanks,
>
>	Ingo

Yes, please do=2E

Reviewed-by: H=2E Peter Anvin (Intel) <hpa@zytor=2Ecom>
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
