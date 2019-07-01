Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02DCB2A22A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2019 02:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfEYAyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 20:54:53 -0400
Received: from ozlabs.org ([203.11.71.1]:38857 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbfEYAyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 20:54:51 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 459lBd53mCz9sBr; Sat, 25 May 2019 10:54:49 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 8b909e3548706cbebc0a676067b81aadda57f47e
X-Patchwork-Hint: ignore
In-Reply-To: <20190522220158.18479-1-bauerman@linux.ibm.com>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH] powerpc: Fix loading of kernel + initramfs with kexec_file_load()
Message-Id: <459lBd53mCz9sBr@ozlabs.org>
Date:   Sat, 25 May 2019 10:54:49 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-05-22 at 22:01:58 UTC, Thiago Jung Bauermann wrote:
> Commit b6664ba42f14 ("s390, kexec_file: drop arch_kexec_mem_walk()")
> changed kexec_add_buffer() to skip searching for a memory location if
> kexec_buf.mem is already set, and use the address that is there.
> 
> In powerpc code we reuse a kexec_buf variable for loading both the kernel
> and the initramfs by resetting some of the fields between those uses, but
> not mem. This causes kexec_add_buffer() to try to load the kernel at the
> same address where initramfs will be loaded, which is naturally rejected:
> 
>   # kexec -s -l --initrd initramfs vmlinuz
>   kexec_file_load failed: Invalid argument
> 
> Setting the mem field before every call to kexec_add_buffer() fixes this
> regression.
> 
> Fixes: b6664ba42f14 ("s390, kexec_file: drop arch_kexec_mem_walk()")
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> Reviewed-by: Dave Young <dyoung@redhat.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/8b909e3548706cbebc0a676067b81aad

cheers
