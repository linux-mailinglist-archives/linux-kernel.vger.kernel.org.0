Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDEFED7F2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 04:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbfKDDE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Nov 2019 22:04:27 -0500
Received: from terminus.zytor.com ([198.137.202.136]:53415 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728643AbfKDDE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 22:04:26 -0500
Received: from [IPv6:2601:646:8600:3281:102f:ba8b:7a69:7a8a] ([IPv6:2601:646:8600:3281:102f:ba8b:7a69:7a8a])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id xA433haZ092262
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Sun, 3 Nov 2019 19:03:45 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com xA433haZ092262
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019091901; t=1572836630;
        bh=YHmnDJJIhxFAT6Io1jUZZxs7VOrc7D7NbUvhYDnhU24=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=Pu1X0tV2m5PAlzR/appMLa4FxmBFAkI+Mg0Od1AwSIr5NVB4+aYSg7fyKLIt4/Uri
         f0xZHC3iKXV0iY8Z6aIb7iJmBy4ynHBtCFR5xpFmKVcpj+MKO5miwu/YLUDxiBXqfI
         TF+KTLwq5faYWD1ktGqsSZimovkkpjXcgK8I9x5S4CgkTjGdZm21OexRzfyjjVrwvS
         5WSYk2tQaPR027iDhUMUR/qpfDcNc7HDm8R2JiyZnhaem1NCYGyT69ITqEcniMKd3f
         crkNBnlimcxjKGUaizj+MBCCQqvlQr339xzpYq4HIQfUIiR5cR3/wbRlezlUI0X4LA
         YCFeDbrSUVg1A==
Date:   Sun, 03 Nov 2019 19:03:36 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <CAMEGPiqq1aoVNgezkx5DdQO7Jm2NL+pZzzY-N0AoU=+s470LcQ@mail.gmail.com>
References: <20190620062246.2665-1-e5ten.arch@gmail.com> <20191029210250.17007-1-e5ten.arch@gmail.com> <CBCA4048-A9C1-42E6-A821-1EE36AE8CDC7@zytor.com> <CAMEGPioV_MTKO9DK6JT5355b7x0py-D_K467etDDnxWSYAbEig@mail.gmail.com> <40DC5B42-6C0D-4A5B-B23E-884ADB0108F0@zytor.com> <CAMEGPiqq1aoVNgezkx5DdQO7Jm2NL+pZzzY-N0AoU=+s470LcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] replace timeconst bc script with an sh script
To:     Ethan Sommer <e5ten.arch@gmail.com>
CC:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Mark Rutland <mark.rutland@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Corey Minyard <cminyard@mvista.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   hpa@zytor.com
Message-ID: <EC20169B-26FF-4AC0-AABE-B6FFB0B3AA40@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On November 3, 2019 3:57:06 PM PST, Ethan Sommer <e5ten=2Earch@gmail=2Ecom>=
 wrote:
>> The point isn't to make it work *now*, but getting it to *stay* work=2E
>Since the only thing that can change to affect the outcome of the
>script
>or program is the value of CONFIG_HZ, isn't knowing that it works
>within
>a range of any reasonable values to set CONFIG_HZ to enough to know
>that
>it will stay working? I just tested again using the bc script and my C
>program, and this time I tested every possible value up to 100000, and
>they both still matched output=2E It doesn't seem like there's something
>that would cause the C program to stop working in the future due to
>precision issues=2E

No, it's not=2E Because some time we are going to want to change the way t=
he constants we need, or use them for something else, and be so on=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
