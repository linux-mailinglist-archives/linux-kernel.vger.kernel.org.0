Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E24016A464
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 11:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbgBXKyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 05:54:01 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:41695 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726838AbgBXKyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 05:54:01 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48QzT36SWzz9sP7;
        Mon, 24 Feb 2020 21:53:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1582541640;
        bh=k0BqyixTJoNetYX9suYhia4s7kCRC36DzGPHDhr3mo4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=sBs1S4FpxMEXaNkDN3F4/M+KmkKLxfXttli0RCvqhL7K0iXzNvYnQOLL8hpByXajJ
         elAusZETQUdwRNVzw/k2kVnAsF3uY5Sezbek1ohH3yEgcD5fSzgQHMRPxzpx1itG9W
         0WnCODRM2k/kHQs/waNxhsn/FBVaFepVm+oZB4561D4dI5IaArWHx3wMynGgdSDSrR
         tF8MtVXpq8amG8WM9LJG4w9E+FeQiNHYU8HJp+gZuhXs6BFYL+hYRIfqnjDwJ+2dFi
         dQx4daUIcze42+VBgCFd0n4iIHcjLo0cCH1J5fc0WDsJuihqZdLoIbBtveQJ8QOQsU
         Ali8Himjep26Q==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Neuling <mikey@neuling.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 00/12] Reduce ifdef mess in ptrace
In-Reply-To: <5b5d8f61-c9aa-1afd-6001-44a17f00c1a6@c-s.fr>
References: <cover.1561735587.git.christophe.leroy@c-s.fr> <f62b0f67-c418-3734-0b07-65aea7537a78@c-s.fr> <7b86733f81c7e15d81ab14b98c8998011ed54880.camel@neuling.org> <5b5d8f61-c9aa-1afd-6001-44a17f00c1a6@c-s.fr>
Date:   Mon, 24 Feb 2020 21:54:00 +1100
Message-ID: <8736b01cjb.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> Le 24/02/2020 =C3=A0 03:15, Michael Neuling a =C3=A9crit=C2=A0:
>> Christophe,
>>> Le 28/06/2019 =C3=A0 17:47, Christophe Leroy a =C3=A9crit :
>>>> The purpose of this series is to reduce the amount of #ifdefs
>>>> in ptrace.c
>>>
>>> Any feedback on this series which aims at fixing the issue you opened at
>>> https://github.com/linuxppc/issues/issues/128 ?
>>=20
>> Yeah, sorry my bad. You did all the hard work and I ignored it.
>>=20
>> I like the approach and is a long the lines I was thinking. Putting it i=
n a
>> ptrace subdir, splitting out adv_debug_regs, TM, SPE, Alitivec, VSX.
>> ppc_gethwdinfo() looks a lot nicer now too (that was some of the worst o=
f it).
>>=20
>> I've not gone through it with a fine tooth comb though. There is (rightl=
y) a lot
>> of code moved around which could have introduced some issues.
>>=20
>> It applies on v5.2 but are you planning on updating it to a newer base?
>>=20
>
> As you noticed there is a lot of code moved around, and rebasing=20
> produces a lot of conflicts. So I didn't want to spend hours to rebase=20
> and rebase without being sure it was the right approach.
>
> Now that I got a positive feedback I'll consider rebasing it, hopping=20
> that Michael will pick it up.

I would love to.

cheers
