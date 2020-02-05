Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00EC115258C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 05:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgBEEUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 23:20:12 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26772 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727832AbgBEEUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 23:20:11 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0154IgxB065034;
        Tue, 4 Feb 2020 23:20:01 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xyhn27wn4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Feb 2020 23:20:00 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 0154F1Iw002400;
        Wed, 5 Feb 2020 04:20:00 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma04dal.us.ibm.com with ESMTP id 2xykc99w38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Feb 2020 04:20:00 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0154JxPk40894772
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Feb 2020 04:19:59 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A3F02805A;
        Wed,  5 Feb 2020 04:19:59 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F06EA28058;
        Wed,  5 Feb 2020 04:19:58 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.124.31.110])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  5 Feb 2020 04:19:58 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 26C4F2E3006; Wed,  5 Feb 2020 09:49:56 +0530 (IST)
Date:   Wed, 5 Feb 2020 09:49:56 +0530
From:   Gautham R Shenoy <ego@linux.vnet.ibm.com>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     ego@linux.vnet.ibm.com,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: Re: [PATCH 2/3] powerpc/sysfs: Show idle_purr and idle_spurr for
 every CPU
Message-ID: <20200205041956.GA5401@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <1574856072-30972-1-git-send-email-ego@linux.vnet.ibm.com>
 <1574856072-30972-3-git-send-email-ego@linux.vnet.ibm.com>
 <1575564547.si4rk0s96p.naveen@linux.ibm.com>
 <20200203045013.GC13468@in.ibm.com>
 <1580802180.jpxk9s8apz.naveen@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580802180.jpxk9s8apz.naveen@linux.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-04_09:2020-02-04,2020-02-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002050034
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naveen,

On Tue, Feb 04, 2020 at 01:22:19PM +0530, Naveen N. Rao wrote:
> Gautham R Shenoy wrote:
> >Hi Naveen,
> >
> >On Thu, Dec 05, 2019 at 10:23:58PM +0530, Naveen N. Rao wrote:
> >>>diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
> >>>index 80a676d..42ade55 100644
> >>>--- a/arch/powerpc/kernel/sysfs.c
> >>>+++ b/arch/powerpc/kernel/sysfs.c
> >>>@@ -1044,6 +1044,36 @@ static ssize_t show_physical_id(struct device *dev,
> >>> }
> >>> static DEVICE_ATTR(physical_id, 0444, show_physical_id, NULL);
> >>>
> >>>+static ssize_t idle_purr_show(struct device *dev,
> >>>+			      struct device_attribute *attr, char *buf)
> >>>+{
> >>>+	struct cpu *cpu = container_of(dev, struct cpu, dev);
> >>>+	unsigned int cpuid = cpu->dev.id;
> >>>+	struct lppaca *cpu_lppaca_ptr = paca_ptrs[cpuid]->lppaca_ptr;
> >>>+	u64 idle_purr_cycles = be64_to_cpu(cpu_lppaca_ptr->wait_state_cycles);
> >>>+
> >>>+	return sprintf(buf, "%llx\n", idle_purr_cycles);
> >>>+}
> >>>+static DEVICE_ATTR_RO(idle_purr);
> >>>+
> >>>+DECLARE_PER_CPU(u64, idle_spurr_cycles);
> >>>+static ssize_t idle_spurr_show(struct device *dev,
> >>>+			       struct device_attribute *attr, char *buf)
> >>>+{
> >>>+	struct cpu *cpu = container_of(dev, struct cpu, dev);
> >>>+	unsigned int cpuid = cpu->dev.id;
> >>>+	u64 *idle_spurr_cycles_ptr = per_cpu_ptr(&idle_spurr_cycles, cpuid);
> >>
> >>Is it possible for a user to read stale values if a particular cpu is in an
> >>extended cede? Is it possible to use smp_call_function_single() to force the
> >>cpu out of idle?
> >
> >Yes, if the CPU whose idle_spurr cycle is being read is still in idle,
> >then we will miss reporting the delta spurr cycles for this last
> >idle-duration. Yes, we can use an smp_call_function_single(), though
> >that will introduce IPI noise. How often will idle_[s]purr be read ?
> 
> Since it is possible for a cpu to go into extended cede for multiple seconds
> during which time it is possible to mis-report utilization, I think it is
> better to ensure that the sysfs interface for idle_[s]purr report the proper
> values through use of IPI.
>

Fair enough.


> With repect to lparstat, the read interval is user-specified and just gets
> passed onto sleep().

Ok. So I guess currently you will be sending smp_call_function every
time you read a PURR and SPURR. That number will now increase by 2
times when we read idle_purr and idle_spurr.


> 
> - Naveen
> 

--
Thanks and Regards
gautham.
