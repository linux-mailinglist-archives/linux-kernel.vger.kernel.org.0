Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F84C19740E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 07:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbgC3Fwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 01:52:50 -0400
Received: from ushosting.nmnhosting.com ([66.55.73.32]:37028 "EHLO
        ushosting.nmnhosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728492AbgC3Fwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 01:52:49 -0400
Received: from mail2.nmnhosting.com (unknown [202.169.106.97])
        by ushosting.nmnhosting.com (Postfix) with ESMTPS id BB2D52DC6849;
        Mon, 30 Mar 2020 16:52:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=d-silva.org;
        s=201810a; t=1585547566;
        bh=usgtpWwfPqN3Po8Erc64Din9rr6Mrn4qoxSsihnBfcI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bMbioP7EtdRIN7Psu7rzMUpwa2C/X6QC4z279/qrlgZqOuYGPlOwaH67cXt1O9uFN
         yOjDqQ7nMQ+tvZeiC3hFYQ7HkNgHSBbyXfOcwjqnoGGaTF/NmFZa/cZdks4yFx1rMN
         SY8i1g6ylE1zIvnQ4+BlwncOv6lIg8IPtu7wxpS04cV44QA+KZi2iMEu6bwkTuOfof
         Y49t6MWeq96LBdLMYXjaSmO54h9U3i1fSUQp5vBqUJ19SIAdr2sm6OAW6Z1Qkuv20U
         7r9tsLXd/jVSP2tx5O3YbfGLhX60JbQU/5G2VTu+b3ndMWAb430Gz2hu8VpwC6JFRp
         0ESQ++Zwi1ehD6oM/g89XDPAa1J5Rnn890kEAlVRB7y46BhGvxZbPZ4Vw9AkNpJsHB
         cMV5R2mdHXLLQgCpbDHpG6zziIq/nLlkrhCrNCg5beqdPmiTucYeBODFIHKReDK02p
         +bTsSrqanwYTuozWj8TiV9BtUYmI6YnNsfpXcEHcUATwh7NBNKNuNIDiN2vKdHC56v
         3MJRPUnWhYZg6Q2eB5TAj14uimXz9l5Y0LlG1MynoP2X+JYl/o4p5ZmKb9I2wE1J6z
         /JOLdd+DdJwF1YHIa2bnFcs514YF3C+C5vK1g2b0TyRT23PrKcfcG1qzvflCD9DxrC
         nzuS2Tu74wUp1I8IUt9lKT1M=
Received: from localhost.lan ([10.0.1.179])
        by mail2.nmnhosting.com (8.15.2/8.15.2) with ESMTP id 02R7C4B0045934;
        Fri, 27 Mar 2020 18:12:20 +1100 (AEDT)
        (envelope-from alastair@d-silva.org)
From:   "Alastair D'Silva" <alastair@d-silva.org>
To:     alastair@d-silva.org
Cc:     "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Anton Blanchard <anton@ozlabs.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kurz <groug@kaod.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org
Subject: [PATCH v4 25/25] MAINTAINERS: Add myself & nvdimm/ocxl to ocxl
Date:   Fri, 27 Mar 2020 18:12:02 +1100
Message-Id: <20200327071202.2159885-26-alastair@d-silva.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327071202.2159885-1-alastair@d-silva.org>
References: <20200327071202.2159885-1-alastair@d-silva.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mail2.nmnhosting.com [10.0.1.20]); Fri, 27 Mar 2020 18:12:20 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OpenCAPI Persistent Memory driver will be maintained as part ofi
the ppc tree.

I'm also adding myself as an author of the driver & contributor to
the generic ocxl driver.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f8670989ec91..3fb9a9f576a7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12064,13 +12064,16 @@ F:	tools/objtool/
 OCXL (Open Coherent Accelerator Processor Interface OpenCAPI) DRIVER
 M:	Frederic Barrat <fbarrat@linux.ibm.com>
 M:	Andrew Donnellan <ajd@linux.ibm.com>
+M:	Alastair D'Silva <alastair@d-silva.org>
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Supported
 F:	arch/powerpc/platforms/powernv/ocxl.c
+F:	arch/powerpc/platforms/powernv/pmem/*
 F:	arch/powerpc/include/asm/pnv-ocxl.h
 F:	drivers/misc/ocxl/
 F:	include/misc/ocxl*
 F:	include/uapi/misc/ocxl.h
+F:	include/uapi/nvdimm/ocxl-pmem.h
 F:	Documentation/userspace-api/accelerators/ocxl.rst
 
 OMAP AUDIO SUPPORT
-- 
2.24.1

