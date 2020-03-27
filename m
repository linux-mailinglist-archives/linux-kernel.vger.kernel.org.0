Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2A1F196AA2
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Mar 2020 04:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgC2C2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Mar 2020 22:28:02 -0400
Received: from ushosting.nmnhosting.com ([66.55.73.32]:35204 "EHLO
        ushosting.nmnhosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbgC2C2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 22:28:02 -0400
Received: from mail2.nmnhosting.com (unknown [202.169.106.97])
        by ushosting.nmnhosting.com (Postfix) with ESMTPS id 5E12D2DC67FE;
        Fri, 27 Mar 2020 18:12:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=d-silva.org;
        s=201810a; t=1585293141;
        bh=bEfzXRR0cTBf+yBtWTvEdtXlD5xDUP18rOvIDgiLves=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gd3j0DuoeTtlWmyHUBUazlQ1VFusMIA9aMaYhizfgDpSKt92Sy7qNXsG96bPw/XxL
         9QhMWe73iJYRcKatLqQyH20jrk2zgVkqk6EZ71FermuqUedtDX+/a0Nl0KdpTvyQGX
         TI7AMhz5XxEnv3yAqHVIW9qqxXNSXJloUqB4fVEgjJLPiAyElMs9/sGcUgkKv9wRiT
         pVzWhJmqwR4it0c5Jr1sRPCU+d7RO8j9kbV60yXlW6plmXpocT8DiJaRVac54Kl5bx
         iykZ94QQC1lJiJhk6vSgbqe3hvFn4jc4B7ggDCo3TAcwMB0jDRWxoQ9t48F2xrqoxc
         Uc7oM3knlUNd38QNUCVGzKSnmF0yYLUaLZOpbB6nKsaWWmft6E6+3oQTcHtQjB8Ja/
         f9bmXSMg7fOd70wY0ezYnuB6dFA38AdcPEhax50weTdofK/DbxqRRk+Nn/8pWP3THe
         yfQFCXqYYY7dSVktejI9B3aDo17PWhaE3+ZCC1FDLqmXe9TesqrQPPeQ8B/8Lnk3jm
         +jdLoxFPBf78IBZA6+JcRjRAKDCxDsrWUAW8qhRPf595Us6aILG5DUC852KzjPL4me
         SGVCPNuhRq371astBd/3M8cq2ByQeoJvs2+NtXwgbRW4GSgBLQwfL719g3fE041XB8
         93xnLU1sO4dAMbvZvsnBeSS8=
Received: from localhost.lan ([10.0.1.179])
        by mail2.nmnhosting.com (8.15.2/8.15.2) with ESMTP id 02R7C4Ah045934;
        Fri, 27 Mar 2020 18:12:16 +1100 (AEDT)
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
Subject: [PATCH v4 08/25] ocxl: Emit a log message showing how much LPC memory was detected
Date:   Fri, 27 Mar 2020 18:11:45 +1100
Message-Id: <20200327071202.2159885-9-alastair@d-silva.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327071202.2159885-1-alastair@d-silva.org>
References: <20200327071202.2159885-1-alastair@d-silva.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mail2.nmnhosting.com [10.0.1.20]); Fri, 27 Mar 2020 18:12:16 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch emits a message showing how much LPC memory & special purpose
memory was detected on an OCXL device.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
Acked-by: Frederic Barrat <fbarrat@linux.ibm.com>
Acked-by: Andrew Donnellan <ajd@linux.ibm.com>
---
 drivers/misc/ocxl/config.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/misc/ocxl/config.c b/drivers/misc/ocxl/config.c
index a62e3d7db2bf..69cca341d446 100644
--- a/drivers/misc/ocxl/config.c
+++ b/drivers/misc/ocxl/config.c
@@ -568,6 +568,10 @@ static int read_afu_lpc_memory_info(struct pci_dev *dev,
 		afu->special_purpose_mem_size =
 			total_mem_size - lpc_mem_size;
 	}
+
+	dev_info(&dev->dev, "Probed LPC memory of %#llx bytes and special purpose memory of %#llx bytes\n",
+		 afu->lpc_mem_size, afu->special_purpose_mem_size);
+
 	return 0;
 }
 
-- 
2.24.1

