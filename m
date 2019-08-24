Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 983B59B92D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2019 01:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbfHWX5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 19:57:17 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41399 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfHWX5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 19:57:16 -0400
Received: by mail-pl1-f196.google.com with SMTP id m9so6434520pls.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 16:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DECqAjRbs0dx++Yw52kS5iaow8vfy6FFKI9UfNLHwa8=;
        b=Sh/iQuG4r0n16ndfsUiMdW5uWISPt4O3fPpwzjksUhyNukWLC9O0B3dkNPDJgV/DAM
         NYz9F85UVLsgs7CR+zetmtChrSbr3gbE0YbbxFBQQe6FrbgktE/qFt9fel+vx+3GJWrZ
         XbB3lr6Ipk2CS3ujREwd0nb3FbErCv1495rryuzT7QM21r30uCM/SxIheDlnIGlaz7j2
         fgeHFeLW6YIE4bh8HbzjOJyAhKfTRBQaHx63liv3oqUzqWj0e0WrgefEqLw5v8OHsijg
         Gw3TgPqvguIqohDlenwC0zLzONNAixbvCeOp2mkTCCCIbpmCafZaeXBPHLXp0G6lHFVq
         3Frg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DECqAjRbs0dx++Yw52kS5iaow8vfy6FFKI9UfNLHwa8=;
        b=Sefr6hecBNZs4snCSS7zS+gzaWUftLJU5v+ZEg3ndZIUB7AQ11xVSnX7hONu1xTVfI
         OZpH850M4x8cGKofp/56XKgeLhJ03K/64FM8wmHRtcBl9YGRc5af7ORwZ7CP0m47mnQN
         CBc06a45hR4O/EhIz+taE1Mh4qP1X/8eaxMDsGxbrnviak3OUn1bQwFfeLjAmWeSrfMm
         1DcR/D2TUxtn93cbMddhjJlyq01AgcZwonz64k6HaqewzKeBwOUCN1OTj4CxXNM65PwZ
         6YhsHL2EPPjFT7oC7ieNyPU/FhsLOh9UKwr+8/oMX/nxQUmHRHAXxKuIq0dkEIjaqdzY
         2rTQ==
X-Gm-Message-State: APjAAAWTMHzhBpnpaxuu0olTQUIHsz/s+Qd9Ya5m5+ekFqfFz/3GPF4p
        jbSJ0pTMcWldaQe7+I2eEHYGvA==
X-Google-Smtp-Source: APXvYqzzrucrRZEAkynZxciTL3BrdFPgNtoE7hZAvcg6fuyWCkSe2qgtsJX3lk9XJ7EtFcEou0+fJA==
X-Received: by 2002:a17:902:343:: with SMTP id 61mr7849130pld.215.1566604636003;
        Fri, 23 Aug 2019 16:57:16 -0700 (PDT)
Received: from ?IPv6:2600:1012:b064:e620:ac21:e025:1693:952e? ([2600:1012:b064:e620:ac21:e025:1693:952e])
        by smtp.gmail.com with ESMTPSA id z4sm3581994pfg.166.2019.08.23.16.57.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Aug 2019 16:57:15 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] uprobes/x86: fix detection of 32-bit user mode
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16G77)
In-Reply-To: <alpine.DEB.2.21.1908240142000.1939@nanos.tec.linutronix.de>
Date:   Fri, 23 Aug 2019 16:57:14 -0700
Cc:     Sebastian Mayr <me@sam.st>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dmitry Safonov <dsafonov@virtuozzo.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <32D5D6B1-B29E-426E-90B6-48565A3B8F3B@amacapital.net>
References: <20190728152617.7308-1-me@sam.st> <alpine.DEB.2.21.1908232343470.1939@nanos.tec.linutronix.de> <alpine.DEB.2.21.1908240142000.1939@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 23, 2019, at 4:44 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
>> On Sat, 24 Aug 2019, Thomas Gleixner wrote:
>>> On Sun, 28 Jul 2019, Sebastian Mayr wrote:
>>>=20
>>> -static inline int sizeof_long(void)
>>> +static inline int sizeof_long(struct pt_regs *regs)
>>> {
>>> -    return in_ia32_syscall() ? 4 : 8;
>>=20
>>  This wants a comment.
>>=20
>>> +    return user_64bit_mode(regs) ? 8 : 4;
>=20
> The more simpler one liner is to check
>=20
>    test_thread_flag(TIF_IA32)

I still want to finish killing TIF_IA32 some day.  Let=E2=80=99s please not a=
dd new users.

