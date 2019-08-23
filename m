Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 955E19A84B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 09:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392757AbfHWHLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 03:11:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25460 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389927AbfHWHLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 03:11:33 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7N773xo036086
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 03:11:32 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ujap99wn9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 03:11:32 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <huntbag@linux.vnet.ibm.com>;
        Fri, 23 Aug 2019 08:11:30 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 23 Aug 2019 08:11:26 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7N7BPnO51773542
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Aug 2019 07:11:25 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02F155204E;
        Fri, 23 Aug 2019 07:11:25 +0000 (GMT)
Received: from boston16h.aus.stglabs.ibm.com (unknown [9.3.23.78])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 408F45204F;
        Fri, 23 Aug 2019 07:11:23 +0000 (GMT)
From:   Abhishek Goel <huntbag@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, paulus@samba.org
Cc:     npiggin@gmail.com, mpe@ellerman.id.au, ego@linux.vnet.ibm.com,
        svaidy@linux.ibm.com, mikey@neuling.org, rjw@rjwysocki.net,
        daniel.lezcano@linaro.org,
        Abhishek Goel <huntbag@linux.vnet.ibm.com>
Subject: [RFC 0/3] New idle device-tree format and support for versioned stop state
Date:   Fri, 23 Aug 2019 02:09:37 -0500
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 19082307-4275-0000-0000-0000035C72A3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082307-4276-0000-0000-0000386E9AD6
Message-Id: <20190823070940.43220-1-huntbag@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-23_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908230072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Background
------------------

Previously if a older kernel runs on a newer firmware, it may enable
all available states irrespective of its capability of handling it.
Consider a case that some stop state has a bug, we end up disabling all
the stop states. This patch introduces selective control to solve this
problem.

Previous version of these patches can be found at:
https://lkml.org/lkml/2018/10/11/544
These patch however also had patches for support of opal save-restore
which now I am decoupling and will take them seperately.
I have posted the corresponding skiboot patches for this kernel patchset
here : https://patchwork.ozlabs.org/cover/1144587/

What's new?
--------------------

Add stop states under ibm,idle-states in addition to the current array
based device tree properties.

New device tree format adds a compatible flag which has version
corresponding to every state, so that only kernel which has the capability
to handle the version of stop state will enable it. Drawback of the array
based dt node is that versioning of idle states is not possible.

Older kernel will still see stop0 and stop0_lite in older format and we
will deprecate it after some time.

Consider a case that stop4 has a bug. We take the following steps to
mitigate the problem.

1) Change compatible string for stop4 in OPAL to "stop4,v2" from
"stop4,v1", i.e. basicallly bump up the previous version and ship the
new firmware.

2) The kernel will ignore stop4 as it won't be able to recognize this
new version. Kernel will also ignore all the deeper states because its
possible that a cpu have requested for a deeper state but was never able
to enter into it. But we will still have shallower states that are there
before stop 4. This, thus prevents from completely disabling stop states.

Linux kernel can now look at the version string and decide if it has the
ability to handle that idle state. Henceforth, if kernel does not know
about a version, it will skip that state and all the deeper state.

Once when the workaround are implemented into the kernel, we can bump up
the known version in kernel for that state, so that support can be
enabled once again in kernel.

New Device-tree :

Final output
       power-mgt {
            ...
         ibm,enabled-stop-levels = <0xec000000>;
         ibm,cpu-idle-state-psscr-mask = <0x0 0x3003ff 0x0 0x3003ff>;
         ibm,cpu-idle-state-latencies-ns = <0x3e8 0x7d0>;
         ibm,cpu-idle-state-psscr = <0x0 0x330 0x0 0x300330>;
         ibm,cpu-idle-state-flags = <0x100000 0x101000>;
         ibm,cpu-idle-state-residency-ns = <0x2710 0x4e20>;
         ibm,idle-states {
                     stop4 {
                         flags = <0x207000>;
                         compatible = "stop4,v1",
                         psscr-mask = <0x0 0x3003ff>;
                         latency-ns = <0x186a0>;
                         residency-ns = <0x989680>;
                         psscr = <0x0 0x300374>;
			 ...
                  };
                    ...
                    stop11 {
                         ...
                         compatible = "stop11,v1",
                         ...
                  };
             };


Abhishek Goel (3):
  cpuidle/powernv : Pass state pointer instead of values to stop loop
  cpuidle/powernv: Add support for versioned stop states
  cpuidle/powernv : Add flags to identify stop state type

 arch/powerpc/include/asm/cpuidle.h    |   8 +-
 arch/powerpc/include/asm/opal-api.h   |   7 +
 arch/powerpc/include/asm/processor.h  |   5 +-
 arch/powerpc/platforms/powernv/idle.c | 371 +++++++++++++++++++++-----
 drivers/cpuidle/cpuidle-powernv.c     |  81 +++---
 5 files changed, 363 insertions(+), 109 deletions(-)

-- 
2.17.1

