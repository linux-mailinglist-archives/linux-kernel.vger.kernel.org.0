Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCC2F16E68
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 02:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfEHAmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 20:42:43 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:33673 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfEHAmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 20:42:42 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44zHkQ6mGQz9s00;
        Wed,  8 May 2019 10:42:38 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Yury Norov <yury.norov@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Breno Leitao <leitao@debian.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Yury Norov <ynorov@marvell.com>
Subject: Re: [PATCH] powerpc: restore current_thread_info()
In-Reply-To: <20190507230746.GA19259@yury-thinkpad>
References: <20190507225121.18676-1-ynorov@marvell.com> <20190507225856.GP23075@ZenIV.linux.org.uk> <20190507230746.GA19259@yury-thinkpad>
Date:   Wed, 08 May 2019 10:42:37 +1000
Message-ID: <87h8a5wzcy.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yury Norov <yury.norov@gmail.com> writes:
> On Tue, May 07, 2019 at 11:58:56PM +0100, Al Viro wrote:
>> On Tue, May 07, 2019 at 03:51:21PM -0700, Yury Norov wrote:
>> > Commit ed1cd6deb013 ("powerpc: Activate CONFIG_THREAD_INFO_IN_TASK")
>> > removes the function current_thread_info(). It's wrong because the
>> > function is used in non-arch code and is part of API.
>> 
>> In include/linux/thread_info.h:
>> 
>> #ifdef CONFIG_THREAD_INFO_IN_TASK
>> /*
>>  * For CONFIG_THREAD_INFO_IN_TASK kernels we need <asm/current.h> for the
>>  * definition of current, but for !CONFIG_THREAD_INFO_IN_TASK kernels,
>>  * including <asm/current.h> can cause a circular dependency on some platforms.
>>  */
>> #include <asm/current.h>
>> #define current_thread_info() ((struct thread_info *)current)
>> #endif
>
> Ah, sorry. Then it might be my rebase issue. I was confused because Christophe
> didn't remove the comment to current_thread_info(), so I decided he
> removed it erroneously.

Yeah you're right, that comment should have been removed too.

cheers
