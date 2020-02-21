Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F67F1684F5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 18:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgBURa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 12:30:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27112 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727291AbgBURa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 12:30:56 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01LHPeem097193;
        Fri, 21 Feb 2020 12:30:45 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yadge6a65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Feb 2020 12:30:44 -0500
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 01LHRpsX102535;
        Fri, 21 Feb 2020 12:30:44 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yadge6a5g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Feb 2020 12:30:44 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01LHTnss005017;
        Fri, 21 Feb 2020 17:30:43 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma04dal.us.ibm.com with ESMTP id 2y6897meb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Feb 2020 17:30:43 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01LHUg2n45679026
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Feb 2020 17:30:42 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92DF6B2064;
        Fri, 21 Feb 2020 17:30:42 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EEA3CB2068;
        Fri, 21 Feb 2020 17:30:41 +0000 (GMT)
Received: from rascal.austin.ibm.com (unknown [9.41.179.32])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 21 Feb 2020 17:30:41 +0000 (GMT)
From:   Scott Cheloha <cheloha@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Nathan Lynch <nathanl@linux.ibm.com>,
        Rick Lindley <ricklind@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Suchanek <msuchanek@suse.com>,
        Michal Hocko <mhocko@suse.com>,
        Nathan Fontenont <ndfont@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: pseries: accelerate drmem and simplify hotplug with xarrays
Date:   Fri, 21 Feb 2020 11:29:00 -0600
Message-Id: <20200221172901.1596249-1-cheloha@linux.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200128221113.17158-1-cheloha@linux.ibm.com>
References: <20200128221113.17158-1-cheloha@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-21_06:2020-02-21,2020-02-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=715 clxscore=1011
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002210132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series introduces two xarrays of LMBs in an effort to speed
up the drmem code and simplify the hotplug code on pseries machines.

The first patch introduces an xarray of LMBs indexed by physical
address.  xa_load() is then used to accelerate LMB lookup during
memory_add_physaddr_to_nid().  The interface is used during boot,
in drmem_init(), and memory hot-add, in dlpar_add_lmb(), on pseries
machines.  Its linear LMB search is a serious bottleneck on larger
machines that xa_load() flattens nicely as shown in the before/after
example.

The second patch introduces a second xarray of LMBs, this one
indexed by DRC index.  The xarray API is leveraged to replace
the custom LMB search/iteration/marking code currently used in
the pseries memory hotplug module.  The result is cleaner and,
again thanks to xa_load(), faster.

v1: One big patch.

v2 changes:
- Split up the big patch from v1 into a series.
- Provide a more dramatic example in patch 1/2 to emphasize the
  linear search bottleneck in memory_add_physaddr_to_nid().
- Expand the use of the xarray API in patch 2/2 to replace more
  custom code.

