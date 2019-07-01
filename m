Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2B210393
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2019 02:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfEAAzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 20:55:51 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:57909 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727553AbfEAAzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 20:55:51 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44v0Lp6GJ9z9s3l;
        Wed,  1 May 2019 10:55:46 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Serge Belyshev <belyshev@depni.sinp.msu.ru>,
        Segher Boessenkool <segher@kernel.crashing.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] powerpc/32s: fix BATs setting with CONFIG_STRICT_KERNEL_RWX
In-Reply-To: <09733bd9d90f2ab9dfee9838442e0bea01df194d.1556640535.git.christophe.leroy@c-s.fr>
References: <09733bd9d90f2ab9dfee9838442e0bea01df194d.1556640535.git.christophe.leroy@c-s.fr>
Date:   Wed, 01 May 2019 10:55:46 +1000
Message-ID: <878svrat7x.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> Serge reported some crashes with CONFIG_STRICT_KERNEL_RWX enabled
> on a book3s32 machine.
>
> Analysis shows two issues:
> - BATs addresses and sizes are not properly aligned.
> - There is a gap between the last address covered by BATs and the
> first address covered by pages.
>
> Memory mapped with DBATs:
> 0: 0xc0000000-0xc07fffff 0x00000000 Kernel RO coherent
> 1: 0xc0800000-0xc0bfffff 0x00800000 Kernel RO coherent
> 2: 0xc0c00000-0xc13fffff 0x00c00000 Kernel RW coherent
> 3: 0xc1400000-0xc23fffff 0x01400000 Kernel RW coherent
> 4: 0xc2400000-0xc43fffff 0x02400000 Kernel RW coherent
> 5: 0xc4400000-0xc83fffff 0x04400000 Kernel RW coherent
> 6: 0xc8400000-0xd03fffff 0x08400000 Kernel RW coherent
> 7: 0xd0400000-0xe03fffff 0x10400000 Kernel RW coherent
>
> Memory mapped with pages:
> 0xe1000000-0xefffffff  0x21000000       240M        rw       present           dirty  accessed
>
> This patch fixes both issues. With the patch, we get the following
> which is as expected:
>
> Memory mapped with DBATs:
> 0: 0xc0000000-0xc07fffff 0x00000000 Kernel RO coherent
> 1: 0xc0800000-0xc0bfffff 0x00800000 Kernel RO coherent
> 2: 0xc0c00000-0xc0ffffff 0x00c00000 Kernel RW coherent
> 3: 0xc1000000-0xc1ffffff 0x01000000 Kernel RW coherent
> 4: 0xc2000000-0xc3ffffff 0x02000000 Kernel RW coherent
> 5: 0xc4000000-0xc7ffffff 0x04000000 Kernel RW coherent
> 6: 0xc8000000-0xcfffffff 0x08000000 Kernel RW coherent
> 7: 0xd0000000-0xdfffffff 0x10000000 Kernel RW coherent
>
> Memory mapped with pages:
> 0xe0000000-0xefffffff  0x20000000       256M        rw       present           dirty  accessed
>
> Reported-by: Serge Belyshev <belyshev@depni.sinp.msu.ru>
> Fixes: 63b2bc619565 ("powerpc/mm/32s: Use BATs for STRICT_KERNEL_RWX")
> Cc: stable@vger.kernel.org

I could probably still get this into v5.1 if you're confident it's a
good fix.

cheers
