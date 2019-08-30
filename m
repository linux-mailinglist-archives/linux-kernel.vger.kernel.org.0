Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3D1A3651
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 14:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbfH3MHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 08:07:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11496 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728209AbfH3MHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 08:07:23 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7UC32Xt056909
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 08:07:22 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uq2jwte0e-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 08:07:21 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ldufour@linux.ibm.com>;
        Fri, 30 Aug 2019 13:07:19 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 30 Aug 2019 13:07:16 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7UC7ELY37355652
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Aug 2019 12:07:14 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E1E04204F;
        Fri, 30 Aug 2019 12:07:14 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B398742047;
        Fri, 30 Aug 2019 12:07:13 +0000 (GMT)
Received: from pomme.com (unknown [9.145.17.35])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 30 Aug 2019 12:07:13 +0000 (GMT)
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        aneesh.kumar@linux.ibm.com, npiggin@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] powerpc/mm: Conditionally call H_BLOCK_REMOVE
Date:   Fri, 30 Aug 2019 14:07:09 +0200
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19083012-0016-0000-0000-000002A4A2D8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19083012-0017-0000-0000-00003304FD2D
Message-Id: <20190830120712.22971-1-ldufour@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-30_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=790 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908300132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the commit ba2dd8a26baa ("powerpc/pseries/mm: call H_BLOCK_REMOVE"),
the call to H_BLOCK_REMOVE is always done if the feature is exhibited.

On some system, the hypervisor may not support all the combination of
segment base page size and page size. When this happens the hcall is
returning H_PARAM, which is triggering a BUG_ON check leading to a panic.

The PAPR document is specifying a TLB Block Invalidate Characteristics item
detailing which couple base page size, page size the hypervisor is
supporting through H_BLOCK_REMOVE. Furthermore, the characteristics are
also providing the size of the block the hcall could process.

Supporting various block size seems not needed as all systems I was able to
play with was support an 8 addresses block size, which is the maximum
through the hcall. Supporting various size may complexify the algorithm in
call_block_remove() so unless this is required, this is not done.

In the case of block size different from 8, a warning message is displayed
at boot time and that block size will be ignored checking for the
H_BLOCK_REMOVE support.

Due to the minimal amount of hardware showing a limited set of
H_BLOCK_REMOVE supported page size, I don't think there is a need to push
this series to the stable mailing list.

The first patch is initializing the penc values for each page size to an
invalid value to be able to detect those which have been initialized as 0
is a valid value.

The second patch is reading the characteristic through the hcall
ibm,get-system-parameter and record the supported block size for each page
size.

The third patch is changing the check used to detect the H_BLOCK_REMOVE
availability to take care of the base page size and page size couple.

Laurent Dufour (3):
  powerpc/mm: Initialize the HPTE encoding values
  powperc/mm: read TLB Block Invalidate Characteristics
  powerpc/mm: call H_BLOCK_REMOVE when supported

 arch/powerpc/include/asm/book3s/64/mmu.h |   3 +
 arch/powerpc/mm/book3s64/hash_utils.c    |   8 +-
 arch/powerpc/platforms/pseries/lpar.c    | 118 ++++++++++++++++++++++-
 3 files changed, 125 insertions(+), 4 deletions(-)

-- 
2.23.0

