Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0B911295F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 11:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfLDKhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Dec 2019 05:37:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24892 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727268AbfLDKg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 05:36:59 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB4AXi8j010461
        for <linux-kernel@vger.kernel.org>; Wed, 4 Dec 2019 05:36:58 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wnqn5cnxx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 05:36:58 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Wed, 4 Dec 2019 10:36:56 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 4 Dec 2019 10:36:53 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB4AaqI247775788
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Dec 2019 10:36:52 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E5AB11C052;
        Wed,  4 Dec 2019 10:36:52 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C9E3A11C054;
        Wed,  4 Dec 2019 10:36:49 +0000 (GMT)
Received: from [9.199.53.54] (unknown [9.199.53.54])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  4 Dec 2019 10:36:49 +0000 (GMT)
Subject: Re: [PATCH v2 0/3] perf report: Few fixes
To:     acme@kernel.org, jolsa@redhat.com
Cc:     kan.liang@intel.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        ak@linux.intel.com, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20191114132213.5419-1-ravi.bangoria@linux.ibm.com>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Wed, 4 Dec 2019 16:06:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191114132213.5419-1-ravi.bangoria@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19120410-0028-0000-0000-000003C4A377
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120410-0029-0000-0000-00002487C11D
Message-Id: <a2915a45-8dcf-af26-ff95-6b7bc68f0313@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-04_03:2019-12-04,2019-12-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 malwarescore=0 mlxlogscore=764
 priorityscore=1501 suspectscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912040083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaldo, Jiri,

Any feedback?

Ravi

On 11/14/19 6:52 PM, Ravi Bangoria wrote:
> v1: https://lore.kernel.org/r/20191112054946.5869-1-ravi.bangoria@linux.ibm.com
> 
> v1 fixed a segfault when -F phys_daddr is used in perf report without
> --mem-mode. Arnaldo suggested to bail out the option completely in
> such case instead of showing 0 values.
> 
> Ravi Bangoria (3):
>    perf hists: Replace pr_err with ui__error
>    perf report: Make -F more strict like -s
>    perf report: Error out for mem mode fields if mem info is not
>      available
> 
>   tools/perf/builtin-report.c |  8 ++++++++
>   tools/perf/util/sort.c      | 16 +++++++++++-----
>   2 files changed, 19 insertions(+), 5 deletions(-)
> 

