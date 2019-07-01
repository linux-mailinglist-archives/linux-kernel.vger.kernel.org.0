Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7560334318
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 11:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfFDJZA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 4 Jun 2019 05:25:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55350 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726877AbfFDJY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 05:24:59 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x549HbX7104005
        for <linux-kernel@vger.kernel.org>; Tue, 4 Jun 2019 05:24:58 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2swjwvrdee-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 05:24:58 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <sachinp@linux.vnet.ibm.com>;
        Tue, 4 Jun 2019 10:24:56 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 4 Jun 2019 10:24:54 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x549OrfL62914798
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Jun 2019 09:24:53 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A1B2A4065;
        Tue,  4 Jun 2019 09:24:53 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B6F7FA4054;
        Tue,  4 Jun 2019 09:24:52 +0000 (GMT)
Received: from [9.109.244.70] (unknown [9.109.244.70])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  4 Jun 2019 09:24:52 +0000 (GMT)
From:   Sachin Sant <sachinp@linux.vnet.ibm.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: [PowerPC][next-20190603] WARNING: at kernel/fork.c:721
Date:   Tue, 4 Jun 2019 14:54:51 +0530
Cc:     linux-next@vger.kernel.org
To:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.3445.104.11)
X-TM-AS-GCONF: 00
x-cbid: 19060409-0012-0000-0000-00000322F38A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060409-0013-0000-0000-0000215BD195
Message-Id: <ED78D3E2-CDCB-494F-9918-2C086F9BC158@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-04_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=604 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906040062
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While booting linux-next [20190603] on a POWER9 LPAR ran into
following warning

[    9.002935] WARNING: CPU: 0 PID: 1 at kernel/fork.c:721 __put_task_struct+0x34/0x170
[    9.002947] Modules linked in: dm_mirror dm_region_hash dm_log dm_mod
[    9.002960] CPU: 0 PID: 1 Comm: systemd Not tainted 5.2.0-rc3-next-20190603-autotest #1
[    9.002971] NIP:  c0000000001191e4 LR: c00000000020c53c CTR: 0000000000000000
[    9.002980] REGS: c0000008b2783810 TRAP: 0700   Not tainted  (5.2.0-rc3-next-20190603-autotest)
[    9.002990] MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 24222842  XER: 20040000
[    9.003004] CFAR: c00000000020c538 IRQMASK: 0 
[    9.003004] GPR00: c00000000020c53c c0000008b2783aa0 c00000000138ca00 c0000008b92e19f8 
[    9.003004] GPR04: c0000008b2783b98 c0000008b2783b98 c0000008b92e24b0 0000000000000000 
[    9.003004] GPR08: 0000000000000000 0000000000000001 0000000000000000 c000000000a81060 
[    9.003004] GPR12: 0000000024224842 c0000000017c0000 0000000000000000 0000000000000000 
[    9.003004] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000001 
[    9.003004] GPR20: 0000000000000000 00007fff95f90000 c0000008b2756dc0 c0000008b2783df0 
[    9.003004] GPR24: 0000000000002000 c0000008ad74d200 c0000008b926a218 0000000000000000 
[    9.003004] GPR28: c0000008b92e1400 0000000000000000 0000000000000000 c0000008b92e19f8 
[    9.003083] NIP [c0000000001191e4] __put_task_struct+0x34/0x170
[    9.003094] LR [c00000000020c53c] css_task_iter_end+0x11c/0x1b0
[    9.003101] Call Trace:
[    9.003108] [c0000008b2783aa0] [c0000008b92e1400] 0xc0000008b92e1400 (unreliable)
[    9.003119] [c0000008b2783ad0] [c00000000020c53c] css_task_iter_end+0x11c/0x1b0
[    9.003129] [c0000008b2783b10] [c00000000020f60c] pidlist_array_load+0x12c/0x390
[    9.003140] [c0000008b2783bf0] [c00000000020fa20] cgroup_pidlist_start+0x1b0/0x1e0
[    9.003151] [c0000008b2783c40] [c0000000001ffd98] cgroup_seqfile_start+0x38/0x50
[    9.003163] [c0000008b2783c60] [c00000000049c270] kernfs_seq_start+0x80/0x120
[    9.003175] [c0000008b2783ca0] [c0000000003fea08] seq_read+0x208/0x540
[    9.003184] [c0000008b2783d20] [c00000000049cdd4] kernfs_fop_read+0x1a4/0x260
[    9.003196] [c0000008b2783d70] [c0000000003c3cec] __vfs_read+0x3c/0x70
[    9.003205] [c0000008b2783d90] [c0000000003c3dd4] vfs_read+0xb4/0x1b0
[    9.003214] [c0000008b2783dd0] [c0000000003c42bc] ksys_read+0x7c/0x130
[    9.003224] [c0000008b2783e20] [c00000000000b688] system_call+0x5c/0x70
[    9.003232] Instruction dump:
[    9.003237] 38423850 7c0802a6 60000000 7c0802a6 fbc1fff0 fbe1fff8 f8010010 f821ffd1 
[    9.003251] 7c7f1b78 8123067c 7d290034 5529d97e <0b090000> 81230110 7d290034 5529d97e 
[    9.003264] ---[ end trace 2194bb4cf2567482 ]—

Have not seen this warning previously and is new with this next build.

void __put_task_struct(struct task_struct *tsk)
{
        WARN_ON(!tsk->exit_state);     <<== 
        WARN_ON(refcount_read(&tsk->usage));

Since I am running into various boot failures with next tree for last week or so
am not able to bisect.

Thanks
-Sachin
