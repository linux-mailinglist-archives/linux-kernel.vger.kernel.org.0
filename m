Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED14617CDE9
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Mar 2020 12:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgCGLrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Mar 2020 06:47:41 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:36655 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbgCGLrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 06:47:40 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48ZN5J3Jygz9sPJ;
        Sat,  7 Mar 2020 22:47:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1583581657;
        bh=T3Lc6pu0BF+ofHjpid246WVPoobyjA8sQizLZI14QII=;
        h=From:To:Cc:Subject:Date:From;
        b=ImJFabrrCN7wW00obUBvVIVpYWRF9ZE+ny/CHzmGTLU1ytFKk7TUeUUOVBZ7DWsxE
         8KehbT2GLm8euKGOjfAVEcXd9NRp3LBcu46vMyeW22GMGA66Bln+5az1Z3YP/U6FNS
         wpcFe8xoZs2a2mpKof/eh8bNa7E+DxsQuLoPUxqIxF5Fp9A8DbUh8ZxN2kKqXGSuwb
         +3SEwZdrKXtPE9/I6buseCX+chTXBH/dsFv6G9fcXD0Faimh1cTIpynjnnbsTBMATS
         YTm9tfdlaFkGOnBxrINkeyl+cL+CTm4a5KsWwUy3VzRfap2Fe10Rgkn4JIKkzFlH4W
         xpfHzHe0KBi1g==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     desnesn@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, naveen.n.rao@linux.vnet.ibm.com,
        ravi.bangoria@linux.ibm.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.6-4 tag
Date:   Sat, 07 Mar 2020 22:47:24 +1100
Message-ID: <87imjgpesz.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull some more powerpc fixes for 5.6:

The following changes since commit 9eb425b2e04e0e3006adffea5bf5f227a896f128:

  powerpc/entry: Fix an #if which should be an #ifdef in entry_32.S (2020-02-19 10:35:22 +1100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.6-4

for you to fetch changes up to 59bee45b9712c759ea4d3dcc4eff1752f3a66558:

  powerpc/mm: Fix missing KUAP disable in flush_coherent_icache() (2020-03-05 17:15:08 +1100)

- ------------------------------------------------------------------
powerpc fixes for 5.6 #4

One fix for a recent regression to our breakpoint/watchpoint code.

Another fix for our KUAP support, this time a missing annotation in a rarely
used path in signal handling.

A fix for our handling of a CPU feature that effects the PMU, when booting
guests in some configurations.

A minor fix to our linker script to explicitly include the .BTF section.

Thanks to:
  Christophe Leroy, Desnes A. Nunes do Rosario, Leonardo Bras, Naveen N. Rao,
  Ravi Bangoria, Stefan Berger.

- ------------------------------------------------------------------
Desnes A. Nunes do Rosario (1):
      powerpc: fix hardware PMU exception bug on PowerVM compatibility mode systems

Michael Ellerman (1):
      powerpc/mm: Fix missing KUAP disable in flush_coherent_icache()

Naveen N. Rao (1):
      powerpc: Include .BTF section

Ravi Bangoria (1):
      powerpc/watchpoint: Don't call dar_within_range() for Book3S


 arch/powerpc/kernel/cputable.c      |  4 +++-
 arch/powerpc/kernel/hw_breakpoint.c | 12 +++++++-----
 arch/powerpc/kernel/vmlinux.lds.S   |  6 ++++++
 arch/powerpc/mm/mem.c               |  2 ++
 4 files changed, 18 insertions(+), 6 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAl5jhbEACgkQUevqPMjh
pYChUw/+OoOuPWLsnCm6G1qNXl0Bybos15zThSvFIt9/LDk4w1FA7DsO0fsaSejZ
r/N/AN02sxTprINhd9+cEjTIdfMR45CVbGJZPqN7ynovhMOQieT60uMjoBUr+9Xx
htHXyPokQNWRn4n5CTTxiwTlu9ehA0zqT9moEHMkERUdsx2BMWEb65lkNT1Jc5/C
qdQ334Raj5ckZFaSBzvGRNGZYDg+lPlDU6Bnu+gxsPLZN+Yr9p9Pr3PHEXDrrEOs
ILknaRoBq0vkI8np2q5iJeqQPri+LgVsTI9400zfJBTWVw4IiFbTmQnPsCOhpXr9
ruUXWROq0hj2216T5pSS+zQkfLLVYI1Wb6O4tFAL2KogrC895qhx+11IAQo+fcKM
IoR4cuQsE1OuWwQjKZfXTz2b+2zdPHEIUSh34rtoo3zT9BUZ5V6peXMIV8UVCdv4
esjOI5oL8R3pa+8MOstDfH8wBDLX49zwjv5g4vCIuiAEqN/Cd6JdCqbLDbpYMIRt
KClQQySKOfh45rl59a3+HRlrgPjLQCVjqHIaoPtxj647y8p33HvLVDXEduJtQ0QK
KwFrzpkpD00L8aV+94pPVFTALG+lsxLxqtgOVd4sMwtHTDlrJ9FWefU+Hh4GuKTi
glUuT0+C21UpLPcvazM5utqQOWWrpk+03Z0Ny9UGxKRTBtiBn6U=
=0jhJ
-----END PGP SIGNATURE-----
