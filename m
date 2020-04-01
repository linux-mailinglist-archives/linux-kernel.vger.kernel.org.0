Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA6019A32D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 03:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731658AbgDABO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 21:14:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51870 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731470AbgDABOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 21:14:25 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8425F5F88E;
        Tue, 31 Mar 2020 21:14:23 -0400 (EDT)
        (envelope-from daniel.santos@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=subject:to:cc
        :references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=sasl; bh=CDrTBsI/C2cd
        72MmvNIWAUzbW2k=; b=bZT2zMyZNVdO/oLMGv6sskK/RxaaNbn77dsMRR9jrkc7
        JGSBOF7quTj7xvmnQXu+ojSPQaUdPTEOSGLq8tHIaCqlVozDA5a7sPMPVPdWGwtW
        7p0MpXx5fSFq9imBXUTRIcjRApgi+zayR1mWlfcJxklLPh5lPFIyI5aXuKiNIiM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=subject:to:cc
        :references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=wWIDYw
        aGvnQpkcU9WoqnQXo+F9c1W/1GvhVMJ8lMKanKCrIJGd194jy6+PWHGWt+wVHNKI
        RbB6m9bc9JOGiyTQTtC60z8FXt8r6vTpySqGGyJqZaGxIppbSr8EERXGmFfcYWxw
        onk5xlz3ljD87GAsJRC7ar85H86bQN9ZSmuXU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7B9F65F88D;
        Tue, 31 Mar 2020 21:14:23 -0400 (EDT)
        (envelope-from daniel.santos@pobox.com)
Received: from [192.168.0.8] (unknown [76.183.130.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3C8B65F88C;
        Tue, 31 Mar 2020 21:14:20 -0400 (EDT)
        (envelope-from daniel.santos@pobox.com)
Subject: Re: [PATCH] compiler.h: fix error in BUILD_BUG_ON() reporting
To:     Vegard Nossum <vegard.nossum@oracle.com>,
        Joe Perches <joe@perches.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ian Abbott <abbotti@mev.co.uk>
References: <20200331112637.25047-1-vegard.nossum@oracle.com>
 <dc53b8704ec674cba636b41d7f55bf507a7bd7aa.camel@perches.com>
 <123d3606-cebf-4261-4b04-7d53d1fcdb07@prevas.dk>
 <ae25b7b1efcfe4eda9465c4fb4712ede928a33c4.camel@perches.com>
 <f3b392d2-d8a4-6788-91b9-d74d98f035a5@oracle.com>
From:   Daniel Santos <daniel.santos@pobox.com>
Message-ID: <c5bf64f2-fac9-ccc5-c65e-f187e55c3aba@pobox.com>
Date:   Tue, 31 Mar 2020 20:12:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <f3b392d2-d8a4-6788-91b9-d74d98f035a5@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Pobox-Relay-ID: 1F02B496-73B6-11EA-B06B-C28CBED8090B-06139138!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/20 2:08 PM, Vegard Nossum wrote:
>
> __LINE__ is only used currently for creating a unique identifier, as fa=
r
> as I can tell.
>
> The way it works is that it creates a function declaration with the
> attribute __attribute__((error(message))), which makes gcc throw an
> error if the function is ever used (i.e. calls are not compiled out).

Back before __attribute__((error())), these macros used to just declare
a function that isn't defined and you only got an error at link-time --
the line number did matter then.=C2=A0 Then there was the negative array
index thing.

>
> The number does appear in the output, but it's not even really obvious
> that it's a line number. And the compiler's diagnostics are pretty good
> at showing the whole "stack trace" of where the call came from
> (including the proper line numbers).
>
>
> Vegard

And the stack trace used to be useless without -g or -g3, but I believe
gcc gives the macro expansion back trace without it now.=C2=A0 But imo, t=
he
macro expansion back trace is a lot of noise that we can eliminate with
a direct gcc mechanism to break the build on some __builtin_constant_p()
expression.

Daniel
