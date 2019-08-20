Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8D9952A9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 02:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbfHTAUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 20:20:23 -0400
Received: from ozlabs.org ([203.11.71.1]:39851 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728985AbfHTAUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 20:20:20 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46CBJg0XFkz9sNC;
        Tue, 20 Aug 2019 10:20:18 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v1 05/10] powerpc/mm: Do early ioremaps from top to bottom on PPC64 too.
In-Reply-To: <1566221500.6f5zxv68dm.astroid@bobo.none>
References: <6bc35eca507359075528bc0e55938bc1ce8ee485.1565726867.git.christophe.leroy@c-s.fr> <019c5d90f7027ccff00e38a3bcd633d290f6af59.1565726867.git.christophe.leroy@c-s.fr> <1566221500.6f5zxv68dm.astroid@bobo.none>
Date:   Tue, 20 Aug 2019 10:20:16 +1000
Message-ID: <87r25g662n.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas Piggin <npiggin@gmail.com> writes:
> Christophe Leroy's on August 14, 2019 6:11 am:
>> Until vmalloc system is up and running, ioremap basically
>> allocates addresses at the border of the IOREMAP area.
>> 
>> On PPC32, addresses are allocated down from the top of the area
>> while on PPC64, addresses are allocated up from the base of the
>> area.
>  
> This series looks pretty good to me, but I'm not sure about this patch.
>
> It seems like quite a small divergence in terms of code, and it looks
> like the final result still has some ifdefs in these functions. Maybe
> you could just keep existing behaviour for this cleanup series so it
> does not risk triggering some obscure regression?

Yeah that is also my feeling. Changing it *should* work, and I haven't
found anything that breaks yet, but it's one of those things that's
bound to break something for some obscure reason.

Christophe do you think you can rework it to retain the different
allocation directions at least for now?

cheers
