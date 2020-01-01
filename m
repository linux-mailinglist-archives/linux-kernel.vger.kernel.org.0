Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1D312E001
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jan 2020 19:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgAAS0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jan 2020 13:26:43 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:13063
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727421AbgAAS0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 13:26:30 -0500
X-IronPort-AV: E=Sophos;i="5.69,382,1571695200"; 
   d="scan'208";a="334542281"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES128-SHA256; 01 Jan 2020 19:26:25 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     kernel-janitors@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] powerpc/powernv: use resource_size
Date:   Wed,  1 Jan 2020 18:49:50 +0100
Message-Id: <1577900990-8588-11-git-send-email-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1577900990-8588-1-git-send-email-Julia.Lawall@inria.fr>
References: <1577900990-8588-1-git-send-email-Julia.Lawall@inria.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use resource_size rather than a verbose computation on
the end and start fields.

The semantic patch that makes these changes is as follows:
(http://coccinelle.lip6.fr/)

<smpl>
@@ struct resource ptr; @@
- (ptr.end - ptr.start + 1)
+ resource_size(&ptr)
</smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 arch/powerpc/platforms/powernv/pci-ioda.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index da1068a9c263..364140145ce0 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -792,7 +792,7 @@ static int pnv_ioda_deconfigure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
 		fcomp = OPAL_IGNORE_RID_FUNCTION_NUMBER;
 		parent = pe->pbus->self;
 		if (pe->flags & PNV_IODA_PE_BUS_ALL)
-			count = pe->pbus->busn_res.end - pe->pbus->busn_res.start + 1;
+			count = resource_size(&pe->pbus->busn_res);
 		else
 			count = 1;
 
@@ -874,7 +874,7 @@ static int pnv_ioda_configure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
 		fcomp = OPAL_IGNORE_RID_FUNCTION_NUMBER;
 		parent = pe->pbus->self;
 		if (pe->flags & PNV_IODA_PE_BUS_ALL)
-			count = pe->pbus->busn_res.end - pe->pbus->busn_res.start + 1;
+			count = resource_size(&pe->pbus->busn_res);
 		else
 			count = 1;
 

