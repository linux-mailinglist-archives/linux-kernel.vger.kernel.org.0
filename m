Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F234C1934E4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 01:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbgCZANB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 20:13:01 -0400
Received: from inva020.nxp.com ([92.121.34.13]:40076 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727498AbgCZANA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 20:13:00 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CB6CF1A072D;
        Thu, 26 Mar 2020 01:12:58 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9232D1A0728;
        Thu, 26 Mar 2020 01:12:58 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.70])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id D006D4040F;
        Wed, 25 Mar 2020 17:12:57 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     arm@kernel.org, soc@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org
Subject: [GIT PULL] soc/fsl drivers changes for next(v5.7)
Date:   Wed, 25 Mar 2020 19:12:57 -0500
Message-Id: <20200326001257.22696-1-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi soc maintainers,

Please merge the following new changes for soc/fsl drivers.

Regards,
Leo

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git tags/soc-fsl-next-v5.7

for you to fetch changes up to 461c3ac0dc46ba7fc09628aadf63c81253c4c3de:

  soc: fsl: qe: fix sparse warnings for ucc_slow.c (2020-03-24 19:09:40 -0500)

----------------------------------------------------------------
NXP/FSL SoC driver updates for v5.7

DPAA2 DPIO driver performance optimization
- Add and use QMAN multiple enqueue interface
- Use function pointer indirection to replace checks in hotpath

QUICC Engine drivers
- Fix sparse warnings and exposed endian issues

----------------------------------------------------------------
Colin Ian King (1):
      soc: fsl: dpio: fix dereference of pointer p before null check

Li Yang (7):
      soc: fsl: qe: fix sparse warnings for qe.c
      soc: fsl: qe: fix sparse warning for qe_common.c
      soc: fsl: qe: fix sparse warnings for ucc.c
      soc: fsl: qe: fix sparse warnings for qe_ic.c
      soc: fsl: qe: fix sparse warnings for ucc_fast.c
      soc: fsl: qe: ucc_slow: remove 0 assignment for kzalloc'ed structure
      soc: fsl: qe: fix sparse warnings for ucc_slow.c

Youri Querry (3):
      soc: fsl: dpio: Adding QMAN multiple enqueue interface
      soc: fsl: dpio: QMAN performance improvement with function pointer indirection
      soc: fsl: dpio: Replace QMAN array mode with ring mode enqueue

 drivers/soc/fsl/dpio/dpio-service.c |  69 +++-
 drivers/soc/fsl/dpio/qbman-portal.c | 767 ++++++++++++++++++++++++++++++++----
 drivers/soc/fsl/dpio/qbman-portal.h | 158 +++++++-
 drivers/soc/fsl/qe/qe.c             |   4 +-
 drivers/soc/fsl/qe/qe_common.c      |   2 +-
 drivers/soc/fsl/qe/qe_ic.c          |   2 +-
 drivers/soc/fsl/qe/ucc.c            |   2 +-
 drivers/soc/fsl/qe/ucc_slow.c       |  33 +-
 include/soc/fsl/dpaa2-io.h          |   6 +-
 include/soc/fsl/qe/ucc_fast.h       |   6 +-
 include/soc/fsl/qe/ucc_slow.h       |  13 +-
 11 files changed, 935 insertions(+), 127 deletions(-)
