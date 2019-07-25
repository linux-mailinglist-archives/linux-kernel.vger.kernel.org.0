Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC01759EC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 23:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfGYV5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 17:57:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36223 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726747AbfGYV5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 17:57:37 -0400
Received: from [IPv6:2601:646:8600:3281:c0fd:a1a9:fe86:7a43] ([IPv6:2601:646:8600:3281:c0fd:a1a9:fe86:7a43])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x6PLvGSa1183782
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 25 Jul 2019 14:57:20 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com x6PLvGSa1183782
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564091840;
        bh=RqnM1Hbe/2mxPUWtAJdKgwytQ94sTTvucO2DuQjVfmw=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=rg5hUaiZrqgvQvzMnzp6GWGlmEg4xH+/yZOdKnQkQeTz2gkT9fht/SYKHf6S1b0Sm
         rwmzvTn3e7wrU9H544eMGEMl040uqaGgEgnFYu7m6/mMMsM1G9gRXROUEXWYwUi7g5
         PpXu2btHFVU3ZxmUhPJjE63VU/cnjzsn4YJdEu2Uh6s3E6sZhydqXeGdCGR7ALtetd
         DEFe2ujhqaNvmCHKCOFpensSDVp8v3xD9eb0J9/U8fFpX39OFN3g27+jXtbnM9COAD
         Ix39/17MxqzZ3sEKv3DekpXohTTrHLaIQ9HX+DfW2w1ISPbdVwADccRvausBSE+vh/
         TcFV6auq0dW7Q==
Date:   Thu, 25 Jul 2019 14:57:10 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <alpine.DEB.2.21.1907252343180.1791@nanos.tec.linutronix.de>
References: <20190724231528.32381-1-jhubbard@nvidia.com> <20190724231528.32381-2-jhubbard@nvidia.com> <B7DC31CA-E378-445A-A937-1B99490C77B4@zytor.com> <alpine.DEB.2.21.1907250848050.1791@nanos.tec.linutronix.de> <345add60-de4a-73b1-0445-127738c268b4@nvidia.com> <alpine.DEB.2.21.1907252343180.1791@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/1] x86/boot: clear some fields explicitly
To:     Thomas Gleixner <tglx@linutronix.de>,
        John Hubbard <jhubbard@nvidia.com>
CC:     john.hubbard@gmail.com, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
From:   hpa@zytor.com
Message-ID: <3DFA2707-89A6-4DD2-8DFB-0C2D1ABA1B3C@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On July 25, 2019 2:48:30 PM PDT, Thomas Gleixner <tglx@linutronix=2Ede> wro=
te:
>On Thu, 25 Jul 2019, John Hubbard wrote:
>> On 7/25/19 12:22 AM, Thomas Gleixner wrote:
>> > It removes the clearing of the range between kbd_status and hdr
>without any
>> > replacement=2E It neither clears edid_info=2E
>>=20
>>=20
>> Yes=2E Somehow I left that chunk out=2E Not my finest hour=2E=20
>
>S*** happens
>
>> > +		char *p =3D (char *) boot_params;
>> > +		int i;
>> > +
>> > +		for (i =3D 0; i < ARRAY_SIZE(toclear); i++)
>> > +			memset(p + toclear[i]=2Estart, 0, toclear[i]=2Elen);
>> >  	}
>> >  }
>>=20
>> Looks nice=2E
>
>I have no idea whether it works and I have no cycles either, so I would
>appreciate it if you could polish it up so we can handle that new
>fangled
>GCC "feature" nicely=2E
>
>Alternatively file a bug report to the GCC folks :)
>
>But seriously I think it's not completely insane what they are doing
>and
>the table based approach is definitely more readable and maintainable
>than
>the existing stuff=2E
>
>Thanks,
>
>	tglx

Doing this table based does seem like a good idea=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
