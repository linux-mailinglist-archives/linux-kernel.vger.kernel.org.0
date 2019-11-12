Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C83B9F8FBF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 13:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfKLMik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 07:38:40 -0500
Received: from ozlabs.org ([203.11.71.1]:48891 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbfKLMij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 07:38:39 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47C6jn2Mfzz9sP4;
        Tue, 12 Nov 2019 23:38:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1573562317;
        bh=u8PtPdFwh6LAkLykCtMHOtF4IC6sKGnHKS1uCNqFdgk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=T71/JYX7DYIoe2lbsDhSPD1fndBLi6rmHtQjFTM6k641QvTtfn3dOXvJ/Z8AhneVW
         YIrfMlJ5yjPHwRor6bIE7SQTii7K1erPk2+BG4hsU0xYZLmI4u/xp/ft4m5YOakohT
         tGTsMvY8Q4f6wkjYjUxqZTTaQhkLWNOxjqKTPyjPvs4qkiq+eEL0fqa0ZJ9QtoN3y+
         j0MvHZwmpLCI/6FbJqRhhC5EyvlKxgNDWxCUOE87OJc1BJSlZrPMfQQ8IoaI5AL19K
         H71JTjg+U+VU30hSBijuFfLmoGpAV7oQhaEpItB4eYaR3dgiocypNWVZpj8mnfCZKX
         /cndjiUgkMQ6g==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        tglx@linutronix.de, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 03/34 v3] powerpc: Use CONFIG_PREEMPTION
In-Reply-To: <20191024160458.vlnf3wlcyjl2ich7@linutronix.de>
References: <20191015191821.11479-1-bigeasy@linutronix.de> <20191015191821.11479-4-bigeasy@linutronix.de> <156db456-af80-1f5e-6234-2e78283569b6@c-s.fr> <87d0ext4q3.fsf@mpe.ellerman.id.au> <20191024135920.cp673ivbcomu2bgy@linutronix.de> <20191024160458.vlnf3wlcyjl2ich7@linutronix.de>
Date:   Tue, 12 Nov 2019 23:38:33 +1100
Message-ID: <874kz92rsm.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
> From: Thomas Gleixner <tglx@linutronix.de>
>
> CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
> Both PREEMPT and PREEMPT_RT require the same functionality which today
> depends on CONFIG_PREEMPT.
>
> Switch the entry code over to use CONFIG_PREEMPTION.
>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> [bigeasy: +Kconfig]
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> v2=E2=80=A6v3: Don't mention die.c changes in the description.
> v1=E2=80=A6v2: Remove the changes to die.c.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
