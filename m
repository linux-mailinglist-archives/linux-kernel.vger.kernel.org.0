Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74653E9BFB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 14:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfJ3NC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 09:02:59 -0400
Received: from 8bytes.org ([81.169.241.247]:50024 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbfJ3NC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 09:02:59 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 7131634A; Wed, 30 Oct 2019 14:02:58 +0100 (CET)
Date:   Wed, 30 Oct 2019 14:02:57 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Fixes for Linux v5.4-rc5
Message-ID: <20191030130251.GA11315@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit d6d5df1db6e9d7f8f76d2911707f7d5877251b02:

  Linux 5.4-rc5 (2019-10-27 13:19:19 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.4-rc5

for you to fetch changes up to 160c63f909ffbc797c0bbe23310ac1eaf2349d2f:

  iommu/vt-d: Fix panic after kexec -p for kdump (2019-10-30 10:30:22 +0100)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.4-rc5

Including:

	- Follow-on fix for Renesas IPMMU to get rid of a redundant
	  error message.

	- Quirk for AMD IOMMU to make it work on another Acer Laptop
	  model with a broken IVRS ACPI table.

	- Fix for a panic at kdump in the Intel IOMMU driver.

----------------------------------------------------------------
John Donnelly (1):
      iommu/vt-d: Fix panic after kexec -p for kdump

Takashi Iwai (1):
      iommu/amd: Apply the same IVRS IOAPIC workaround to Acer Aspire A315-41

YueHaibing (1):
      iommu/ipmmu-vmsa: Remove dev_err() on platform_get_irq() failure

 drivers/iommu/amd_iommu_quirks.c | 13 +++++++++++++
 drivers/iommu/intel-iommu.c      |  2 +-
 drivers/iommu/ipmmu-vmsa.c       |  4 +---
 3 files changed, 15 insertions(+), 4 deletions(-)

Please pull.

Thanks,

	Joerg

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAl25ifgACgkQK/BELZcB
GuPHAw/8DlQeiUSZF2f79oWA/4qLZNYJcHMEVJ1c23+x/EC8M1uTO/x7XN27mNpV
Ld8EJeA0T2LwOyJx1VPHNSYU7Qes2bSDXdfHL2PUEaVEzT/bC8HO6h2YTVXSbPPB
kbAsf3/Bvf3HOSDzLQR8veWkTWeP42SiQA/3bw4B40jzJgaCbPkDoKRwphdVZ02c
E4DjLlfZCwvyHbKzjsXnKivJQPfjrTVm3tuStcmRfoFTFw0PZP/8zJNwgpYHfHr5
pX0mjHMZc2X0PofpCVq02q8DDypxpTADDu7rKj/W4VVZrq6Dpe5Q07Gmo8qDt5hs
YoNVmqm5KRXm5wsNnCgQrWoEcBulybM5S3mI5RLUy49gGd39EjU8STfCa07chXVL
16l6bYbzs3ZQxJp25gynyIzoCs71JEj7mDbnYt/YJ9XRwiOBFtgyub/esZD978DQ
zRySGnxoyZdSktxiMgffM61M7TK8oeJiruGQXtBYNjK1oPcJH+feJ0Rrbz09stOK
xd3YDzJ7e2TkgIBlVgoiMdkbjYk5jBg5OeMmwlM3HBtQVBVTCeGEfwCKB8hfiBXN
P+6JIGY+BbopDSW/zDUfMJYBbs72RxQdVUAITzf+coXbQq0Ldx3OtUBhHBSglhPk
xAhDdMpPJM9TjXEhEhMqtlP5p6+Vw+cnKFgSN071tDPVjvwHa6o=
=26Gu
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
