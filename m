Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D02E3ECE0E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2019 11:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfKBKkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Nov 2019 06:40:01 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:35497 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbfKBKkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 06:40:00 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 474wYT0lsSz9sP6;
        Sat,  2 Nov 2019 21:39:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1572691197;
        bh=Ry79hgUA7ZsMknpBJFNzR+c97YQ0WmZG98BuWT+fhOw=;
        h=From:To:Cc:Subject:Date:From;
        b=W1jrLADN7kIcngvDvFe6XiU8v5n8w9YuWDf8+c14Zk3WOTtdOIOEhnwUadnjB4sZS
         gHDZwHGxlvVPorgjZdwptd9mYjREYzNd0AOE2GimSIH3igd1DlB/lvplXKta6BHBSB
         oLetbIquvHLzRytppGrJIZSThzYG+CPxz+MvgmMc4qPws4A1j0Tuj+5vKUiNj7i78O
         lyBX1T97crtUeIAiXrb3CamSEEbEpiZio6xo5s+g0aDerLKx6PTJUcc/EIA7dVj0mw
         9Dd4BqHGL9lUEWW2VQskH5X/z37GavfyFKlmRQ9FvalVhTfYvCShs6k6kAculsl+mV
         /BA4D+6mdnN2g==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     bauerman@linux.ibm.com, christophe.leroy@c-s.fr,
        fbarrat@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.4-4 tag
Date:   Sat, 02 Nov 2019 21:39:56 +1100
Message-ID: <875zk236kj.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull some more powerpc fixes for 5.4:

The following changes since commit 2272905a4580f26630f7d652cc33935b59f96d4c:

  spufs: fix a crash in spufs_create_root() (2019-10-11 16:57:41 +1100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.4-4

for you to fetch changes up to 7d6475051fb3d9339c5c760ed9883bc0a9048b21:

  powerpc/powernv: Fix CPU idle to be called with IRQs disabled (2019-10-29 21:47:01 +1100)

- ------------------------------------------------------------------
powerpc fixes for 5.4 #4

Our recent cleanup of EEH led to an oops on bare metal machines when the cxl
(CAPI) driver creates virtual devices for an attached FPGA accelerator.

The "secure virtual machine" support we added in v5.4 had a bug if the kernel
was relocated (moved during boot), in those cases the signature of the kernel
text wouldn't verify and the Ultravisor would refuse to run the VM.

A recent change to disable interrupts before calling arch_cpu_idle_dead() caused
a WARN_ON() in our bare metal CPU offline code to always trigger.

The KUAP (SMAP) support we added for 32-bit Book3S had a bug if the address
range crossed a segment (256MB) boundary which could lead to spurious faults.

Thanks to:
  Christophe Leroy, Frederic Barrat, Michael Anderson, Nicholas Piggin, Sam
  Bobroff, Thiago Jung Bauermann.

- ------------------------------------------------------------------
Christophe Leroy (1):
      powerpc/32s: fix allow/prevent_user_access() when crossing segment boundaries.

Frederic Barrat (1):
      powerpc/powernv/eeh: Fix oops when probing cxl devices

Nicholas Piggin (1):
      powerpc/powernv: Fix CPU idle to be called with IRQs disabled

Thiago Jung Bauermann (1):
      powerpc/prom_init: Undo relocation before entering secure mode


 arch/powerpc/include/asm/book3s/32/kup.h     |  1 +
 arch/powerpc/include/asm/elf.h               |  3 ++
 arch/powerpc/kernel/prom_init.c              | 13 +++++
 arch/powerpc/kernel/prom_init_check.sh       |  3 +-
 arch/powerpc/platforms/powernv/eeh-powernv.c |  2 +-
 arch/powerpc/platforms/powernv/smp.c         | 53 ++++++++++++++------
 6 files changed, 57 insertions(+), 18 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAl29WnoACgkQUevqPMjh
pYDoog/+MDn3jR/l7fYsUKku6WilXtOUeH9UORfnAOHtiJY7hAjd1kGiLq3iah2Z
B8yh0z6XCxInRXnfDFnwAQJ6znGnOzZ76wu61Lt+wI6BjxjaN1tgSqfCkhnAPDqu
JK0/lMte6xjBlCnhwTg6EkELGjPoUNTXbe1qaiGOgnmIJnztYbTE6cjj2uCfBc1z
FY4BEdR7lddzQGlZa7WDad7imH8T3RWT2QVphSh1qjIMZHMyCtOx7dqUUry0hzJ/
Ps4Yqsyplmfip1lc6THe94g/fqxZwA7FET7PSbrWViYozNkBF9rSkfhfW7NyCxel
3nH2gFwnPAEcaHoaELrHLFYcU3yKsja5AyIbujyF2i91rghnaO4jB+qugEiFaTyQ
QL50igWCtZF0pjIJ7ZHUp2lmN+jERTSenTlhg3jKB0rIgQhHtXAbnHs14wnO4wlB
OYrk+Z/NnSm57valvISHTDJ7btcstw6q0MbYYl8fxNK1oQ5UdSr9oiidSFAqOecY
nCKZZI1e7fTQMrJ6tlKA5y+IjM9CiOaSsgvtGzI9Ii1vbqGShV2sJ6xaYCU6sE4t
lmdlHOPJRqhPnq0xI+Wgs7UuOoY+o8fj61pNogMTdJQhlsRnS3RObeAFT8Gy6OWE
8bXuAtF71tL5KRC8X1YeI6jEMRKN5jbSiH4d3Qeh3LL6cQ26omo=
=MGF+
-----END PGP SIGNATURE-----
