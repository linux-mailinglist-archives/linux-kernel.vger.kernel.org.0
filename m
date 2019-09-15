Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A89C4B2F1A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2019 09:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfIOHmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Sep 2019 03:42:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32988 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725788AbfIOHmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 03:42:38 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8F7fm4h086513;
        Sun, 15 Sep 2019 03:42:23 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2v1djsv393-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 15 Sep 2019 03:42:23 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x8F7g1Fj086898;
        Sun, 15 Sep 2019 03:42:22 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2v1djsv38v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 15 Sep 2019 03:42:22 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8F7dopM016623;
        Sun, 15 Sep 2019 07:42:22 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma03wdc.us.ibm.com with ESMTP id 2v0t3cqm1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 15 Sep 2019 07:42:22 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8F7gLdc42008958
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 15 Sep 2019 07:42:21 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6678112062;
        Sun, 15 Sep 2019 07:42:21 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F466112061;
        Sun, 15 Sep 2019 07:42:21 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.85.81.174])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 15 Sep 2019 07:42:21 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 8E54F2E2D63; Sun, 15 Sep 2019 13:12:17 +0530 (IST)
Date:   Sun, 15 Sep 2019 13:12:17 +0530
From:   Gautham R Shenoy <ego@linux.vnet.ibm.com>
To:     Nathan Lynch <nathanl@linux.ibm.com>
Cc:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Kamalesh Babulal <kamaleshb@in.ibm.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: Re: [PATCH 0/2] pseries/hotplug: Change the default behaviour of
 cede_offline
Message-ID: <20190915074217.GA943@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <1568284541-15169-1-git-send-email-ego@linux.vnet.ibm.com>
 <87impxr0am.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87impxr0am.fsf@linux.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-15_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909150084
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Nathan,

On Thu, Sep 12, 2019 at 10:39:45AM -0500, Nathan Lynch wrote:
> "Gautham R. Shenoy" <ego@linux.vnet.ibm.com> writes:
> > The patchset also defines a new sysfs attribute
> > "/sys/device/system/cpu/cede_offline_enabled" on PSeries Linux guests
> > to allow userspace programs to change the state into which the
> > offlined CPU need to be put to at runtime.
> 
> A boolean sysfs interface will become awkward if we need to add another
> mode in the future.
> 
> What do you think about naming the attribute something like
> 'offline_mode', with the possible values 'extended-cede' and
> 'rtas-stopped'?

We can do that. However, IMHO in the longer term, on PSeries guests,
we should have only one offline state - rtas-stopped.  The reason for
this being, that on Linux, SMT switch is brought into effect through
the CPU Hotplug interface. The only state in which the SMT switch will
recognized by the hypervisors such as PHYP is rtas-stopped.

All other states (such as extended-cede) should in the long-term be
exposed via the cpuidle interface.

With this in mind, I made the sysfs interface boolean to mirror the
current "cede_offline" commandline parameter. Eventually when we have
only one offline-state, we can deprecate the commandline parameter as
well as the sysfs interface.

Thoughts?

--
Thanks and Regards
gautham.
