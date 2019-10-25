Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31C38E4924
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 13:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410124AbfJYLDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 07:03:55 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:33265 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407262AbfJYLDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 07:03:55 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4701Sm2xxqz9sPK;
        Fri, 25 Oct 2019 22:03:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1572001432;
        bh=zR2+Wwbibdf/2nUQuITloJZKmPyWJx1+odpdcK+KecM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=femDesdzuQMKmpeQquHw9TYWi2ahr/MEHHgZP72991U55pcEPgkOtaw7UktH8gHSH
         t8mxNFAm01wWMBTHub3OozAc2CiVlBYzz7RBav3esumybZNTyXi35rORWAL+aR7OwD
         Lc9ZaoKGGRAds/fPXStuUdq5HyP78jR4ZEA2NdFwVA9LczvXt0Kk5P4NykZquk8lOf
         /GNTHjPRYJi61LSBo2e7nDfFjWpVwSexgkjbJUPAiNt1F/v1BqAM1m1fyAwpZyPY8M
         7dbC0jyQ0TlLa9qKy3C9J1rUfAVV9VzS5QC5GjfZn92quJPJ3Fii8c1tMU8vbveF7q
         7ggeAwqpuQOxA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org,
        Mike Anderson <andmike@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Ram Pai <linuxram@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH] powerpc/prom_init: Undo relocation before entering secure mode
In-Reply-To: <20190911163433.12822-1-bauerman@linux.ibm.com>
References: <20190911163433.12822-1-bauerman@linux.ibm.com>
Date:   Fri, 25 Oct 2019 22:03:51 +1100
Message-ID: <87o8y5dr3c.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thiago Jung Bauermann <bauerman@linux.ibm.com> writes:
> The ultravisor will do an integrity check of the kernel image but we
> relocated it so the check will fail. Restore the original image by
> relocating it back to the kernel virtual base address.
>
> This works because during build vmlinux is linked with an expected virtual
> runtime address of KERNELBASE.
>
> Fixes: 6a9c930bd775 ("powerpc/prom_init: Add the ESM call to prom_init")
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/elf.h         |  3 +++
>  arch/powerpc/kernel/prom_init.c        | 11 +++++++++++
>  arch/powerpc/kernel/prom_init_check.sh |  3 ++-
>  3 files changed, 16 insertions(+), 1 deletion(-)

This breaks the build when CONFIG_RELOCATABLE=n:

    prom_init.c:(.init.text+0x3160): undefined reference to `relocate'

See http://kisskb.ellerman.id.au/kisskb/buildresult/14004234/

cheers
