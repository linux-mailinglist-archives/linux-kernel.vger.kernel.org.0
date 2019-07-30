Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0807A037
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 07:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbfG3FBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 01:01:55 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:41447 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728547AbfG3FBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 01:01:55 -0400
Received: from neuling.org (localhost [127.0.0.1])
        by ozlabs.org (Postfix) with ESMTP id 45yPYF0NxWz9s3Z;
        Tue, 30 Jul 2019 15:01:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=neuling.org;
        s=201811; t=1564462913;
        bh=Vgdma4M3NjY+571qzaaGNdc2/IobJXlKXEZw6X3gf8k=;
        h=Subject:From:To:Cc:Date:From;
        b=HL7zp8pO6qQEj4dGzi3XO2/xjjxFw+mjFHz9ELt1et+Qb5Kg1SP+80KBlrU3bnHLP
         i2T3e4+XYcH6f9pVp2gvL5+J2e12HgKos6AigFv04AnbPj+tLVy2dxoXVaJ7QeueUS
         nzDHNN0S5SqRSTY+EgWo909aN5sPTE4rVkr8ccVJHSGGg4yfm5/2SsD3oW1EZl2+mM
         UW1Or3Rg35OuZPHc6moAgT4G6tXWVIIXpjgdQ/J3pHMt4zR80QTjWlo0X5M+7pa6OK
         VMpd1GmwNAzgo7vEZ89nri2jDKn+OzIGqsVeF2wE74JOCcrFcEfBz4Dmx07gXTV7fK
         +/AGVgaRQ3Zqw==
Received: by neuling.org (Postfix, from userid 1000)
        id 04BF52A17B3; Tue, 30 Jul 2019 15:01:52 +1000 (AEST)
Message-ID: <67db82ab73dbb630c45003795f7597274f30983e.camel@neuling.org>
Subject: CVE-2019-13648: Linux kernel: powerpc: kernel crash in TM handling
 triggerable by any local user
From:   Michael Neuling <mikey@neuling.org>
To:     oss-security@lists.openwall.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Linuxppc-users <linuxppc-users@lists.ozlabs.org>,
        Michael Ellerman <michael@ellerman.id.au>
Date:   Tue, 30 Jul 2019 15:01:52 +1000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux kernel for powerpc since v3.9 has a bug in the TM handling  where=
 any
unprivileged local user may crash the operating system.

This bug affects machines using 64-bit CPUs where Transactional Memory (TM)=
 is
not present or has been disabled (see below for more details on affected CP=
Us).

To trigger the bug a process constructs a signal context which still has th=
e MSR
TS bits set. That process then passes this signal context to the sigreturn(=
)
system call. When returning back to userspace, the kernel then crashes with=
 a
bad TM transition (TM Bad Thing) or by executing TM code on a non-TM system=
.

All 64bit machines where TM is not present are affected. This includes Powe=
rPC
970 (G5), PA6T, POWER5/6/7 VMs under KVM or LPARs under PowerVM and POWER9 =
bare
metal.=20

Additionally systems with TM hardware but where TM is disabled in software =
(via
ppc_tm=3Doff kernel cmdline) are also affected. This includes POWER8/9 VMs =
under
KVM or LPARs under PowerVM and POWER8 bare metal.

The bug was introduced in commit:
  2b0a576d15e0 ("powerpc: Add new transactional memory state to the signal =
context")

Which was originally merged in v3.9.=20

The upstream fix is here:
  https://git.kernel.org/torvalds/c/f16d80b75a096c52354c6e0a574993f3b0dfbdf=
e

The fix can be verified by running `sigfuz -m` from the kernel selftests:
 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/to=
ols/testing/selftests/powerpc/signal/sigfuz.c?h=3Dv5.2

cheers
Mikey

