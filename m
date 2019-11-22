Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B765410728B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2019 13:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbfKVMzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Nov 2019 07:55:06 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:4666 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726526AbfKVMzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 07:55:06 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAMCkwcB028665;
        Fri, 22 Nov 2019 13:54:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=bxiuTK+x3oPhnDKBKfKRJ01+VjbhWxaGagP881Oi19M=;
 b=HK7+USpsxZtqvR/TzymAPqh+iPDWPjX/+6rVTEImlPygNpUxuKwqo78AErKac93eyX1w
 T7zAUyTazpQG53YjdL4mN+aRCLv+tXu9G1vIFOPe18+VHI5CzOB1ssGH7bD2si4W1899
 A5eq/oFIL1QCW0mcouyDbja1yUfzAmj1SOjiHwFp2cbf07kYQO0PanywDdem6NQTh0e+
 CEV0tXdVRhU/dUk5jAyDDJ1naaORANUDwLAKCw/WAPS8Z480WkQV/z0w/N9F3vqp1Kno
 Jep5OJod/jXS5RaHF/QAIJfn61DwF5uCQqXoxKVmYUm9MxzEs8l4kr48kUVGpXoGDdqK ig== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2wa9usrue0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Nov 2019 13:54:35 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C67E110002A;
        Fri, 22 Nov 2019 13:54:34 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 99C1E2BD314;
        Fri, 22 Nov 2019 13:54:34 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG3NODE1.st.com (10.75.127.7)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 22 Nov 2019 13:54:34
 +0100
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
To:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH] dt-bindings: remoteproc: stm32: add wakeup-source property
Date:   Fri, 22 Nov 2019 13:54:02 +0100
Message-ID: <20191122125402.14730-1-arnaud.pouliquen@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-22_02:2019-11-21,2019-11-22 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the optional wdg interrupt is defined, then this property
may be defined.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
This commit is related to the merge conflict issue reported by
Stephen Rothwell: https://lkml.org/lkml/2019/11/21/1168
---
 .../devicetree/bindings/remoteproc/st,stm32-rproc.yaml          | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
index acf18d170352..c0d83865e933 100644
--- a/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
@@ -50,6 +50,8 @@ properties:
     description: Should contain the WWDG1 watchdog reset interrupt
     maxItems: 1
 
+  wakeup-source: true
+
   mboxes:
     description:
       This property is required only if the rpmsg/virtio functionality is used.
-- 
2.17.1

