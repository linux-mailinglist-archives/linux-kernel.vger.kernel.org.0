Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 261271908D4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 10:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgCXJQN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 24 Mar 2020 05:16:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25972 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726129AbgCXJQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:16:13 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02O93wqX064445;
        Tue, 24 Mar 2020 05:16:03 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ywejw4wv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Mar 2020 05:16:02 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 02O93wD4064429;
        Tue, 24 Mar 2020 05:16:01 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ywejw4wuf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Mar 2020 05:16:01 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 02O9EdDe017613;
        Tue, 24 Mar 2020 09:16:00 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma02wdc.us.ibm.com with ESMTP id 2ywawjq77b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Mar 2020 09:16:00 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02O9FxoK37290390
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Mar 2020 09:15:59 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 64B30BE059;
        Tue, 24 Mar 2020 09:15:59 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E4BDCBE051;
        Tue, 24 Mar 2020 09:15:56 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.85.116.254])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 24 Mar 2020 09:15:55 +0000 (GMT)
X-Mailer: emacs 27.0.90 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Sachin Sant <sachinp@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Baoquan He <bhe@redhat.com>, linux-nvdimm@lists.01.org,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [5.6.0-rc7] Kernel crash while running ndctl tests
In-Reply-To: <CF20E440-4DCB-4EFD-88B6-0AB98DC7FBD4@linux.vnet.ibm.com>
References: <CF20E440-4DCB-4EFD-88B6-0AB98DC7FBD4@linux.vnet.ibm.com>
Date:   Tue, 24 Mar 2020 14:45:53 +0530
Message-ID: <87a746cdva.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-24_02:2020-03-23,2020-03-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 suspectscore=2 spamscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003240048
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sachin Sant <sachinp@linux.vnet.ibm.com> writes:

> While running ndctl[1] tests against 5.6.0-rc7 following crash is encountered.
>
> Bisect leads me to  commit d41e2f3bd546 
> mm/hotplug: fix hot remove failure in SPARSEMEM|!VMEMMAP case
>
> Reverting this commit helps and the tests complete without any crash.
>
> pmem0: detected capacity change from 0 to 10720641024
> BUG: Kernel NULL pointer dereference on read at 0x00000000
> Faulting instruction address: 0xc000000000c3447c
> Oops: Kernel access of bad area, sig: 11 [#1]
> LE PAGE_SIZE=64K MMU=Hash SMP NR_CPUS=2048 NUMA pSeries
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Modules linked in: dm_mod nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip6_tables nft_compat ip_set rfkill nf_tables nfnetlink sunrpc sg pseries_rng papr_scm uio_pdrv_genirq uio sch_fq_codel ip_tables sd_mod t10_pi ibmvscsi scsi_transport_srp ibmveth
> CPU: 11 PID: 7519 Comm: lt-ndctl Not tainted 5.6.0-rc7-autotest #1
> NIP:  c000000000c3447c LR: c000000000088354 CTR: c00000000018e990
> REGS: c0000006223fb630 TRAP: 0300   Not tainted  (5.6.0-rc7-autotest)
> MSR:  800000000280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 24048888  XER: 00000000
> CFAR: c00000000000dec4 DAR: 0000000000000000 DSISR: 40000000 IRQMASK: 0 
> GPR00: c0000000003c5820 c0000006223fb8c0 c000000001684900 0000000004000000 
> GPR04: c00c000101000000 0000000007ffffff c00000067ff20900 c00c000000000000 
> GPR08: 0000000000000000 c00c000100000000 0000000000000000 c000000003f00000 
> GPR12: 0000000000008000 c00000001ec70200 00007fffc102f9e8 000000001002e088 
> GPR16: 0000000000000000 0000000010050d88 000000001002f778 000000001002f770 
> GPR20: 0000000000000000 0000000000000100 0000000000000001 0000000000001000 
> GPR24: 0000000000000008 0000000000000000 0000000004000000 c00c000100004000 
> GPR28: c000000003101aa0 c00c000100000000 0000000001000000 0000000004000100 
> NIP [c000000000c3447c] vmemmap_populated+0x98/0xc0
> LR [c000000000088354] vmemmap_free+0x144/0x320
> Call Trace:
> [c0000006223fb8c0] [c0000006223fb960] 0xc0000006223fb960 (unreliable)
> [c0000006223fb980] [c0000000003c5820] section_deactivate+0x220/0x240
> [c0000006223fba30] [c0000000003dc1d8] __remove_pages+0x118/0x170
> [c0000006223fba80] [c000000000086e5c] arch_remove_memory+0x3c/0x150
> [c0000006223fbb00] [c00000000041a3bc] memunmap_pages+0x1cc/0x2f0
> [c0000006223fbb80] [c0000000007d6d00] devm_action_release+0x30/0x50
> [c0000006223fbba0] [c0000000007d7de8] release_nodes+0x2f8/0x3e0
> [c0000006223fbc50] [c0000000007d0b38] device_release_driver_internal+0x168/0x270
> [c0000006223fbc90] [c0000000007ccf50] unbind_store+0x130/0x170
> [c0000006223fbcd0] [c0000000007cc0b4] drv_attr_store+0x44/0x60
> [c0000006223fbcf0] [c00000000051fdb8] sysfs_kf_write+0x68/0x80
> [c0000006223fbd10] [c00000000051f200] kernfs_fop_write+0x100/0x290
> [c0000006223fbd60] [c00000000042037c] __vfs_write+0x3c/0x70
> [c0000006223fbd80] [c00000000042404c] vfs_write+0xcc/0x240
> [c0000006223fbdd0] [c00000000042442c] ksys_write+0x7c/0x140
> [c0000006223fbe20] [c00000000000b278] system_call+0x5c/0x68
> Instruction dump:
> 2ea80000 4196003c 794a2428 7d685215 41820030 7d48502a 71480002 41820024 
> 714a0008 4082002c e90b0008 786adf62 <e8680000> 7c635436 70630001 4c820020 
> ---[ end trace 579b48162da1b890 ]—


Can you try this change?

diff --git a/mm/sparse.c b/mm/sparse.c
index aadb7298dcef..3012d1f3771a 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -781,6 +781,8 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 			ms->usage = NULL;
 		}
 		memmap = sparse_decode_mem_map(ms->section_mem_map, section_nr);
+		/* Mark the section invalid */
+		ms->section_mem_map &= ~SECTION_HAS_MEM_MAP;
 	}
 
 	if (section_is_early && memmap)

a pfn_valid check involves pnf_section_valid() check if section is
having MEM_MAP. In this case we did end up  setting the ms->uage = NULL.
So when we do that tupdate the section to not have MEM_MAP.

-aneesh
