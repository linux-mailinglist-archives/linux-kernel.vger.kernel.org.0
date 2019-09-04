Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01269A88F5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 21:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730632AbfIDOmo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 4 Sep 2019 10:42:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31988 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729398AbfIDOmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 10:42:43 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x84ETspl088262
        for <linux-kernel@vger.kernel.org>; Wed, 4 Sep 2019 10:42:42 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2utdes4xu5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 10:42:41 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Wed, 4 Sep 2019 15:42:40 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 4 Sep 2019 15:42:37 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x84Ega2d43647078
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Sep 2019 14:42:36 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A214EAE055;
        Wed,  4 Sep 2019 14:42:36 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 349A4AE045;
        Wed,  4 Sep 2019 14:42:36 +0000 (GMT)
Received: from localhost (unknown [9.199.56.52])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  4 Sep 2019 14:42:36 +0000 (GMT)
Date:   Wed, 04 Sep 2019 20:12:34 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 2/3] Powerpc64/Watchpoint: Don't ignore extraneous
 exceptions
To:     mikey@neuling.org, mpe@ellerman.id.au,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     benh@kernel.crashing.org, christophe.leroy@c-s.fr,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        npiggin@gmail.com, paulus@samba.org
References: <20190710045445.31037-1-ravi.bangoria@linux.ibm.com>
        <20190710045445.31037-3-ravi.bangoria@linux.ibm.com>
In-Reply-To: <20190710045445.31037-3-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 19090414-0028-0000-0000-00000397A571
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19090414-0029-0000-0000-00002459F765
Message-Id: <1567608022.j44gajn34z.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-04_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=921 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909040143
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ravi Bangoria wrote:
> On Powerpc64, watchpoint match range is double-word granular. On
> a watchpoint hit, DAR is set to the first byte of overlap between
> actual access and watched range. And thus it's quite possible that
> DAR does not point inside user specified range. Ex, say user creates
> a watchpoint with address range 0x1004 to 0x1007. So hw would be
> configured to watch from 0x1000 to 0x1007. If there is a 4 byte
> access from 0x1002 to 0x1005, DAR will point to 0x1002 and thus
> interrupt handler considers it as extraneous, but it's actually not,
> because part of the access belongs to what user has asked. So, let
> kernel pass it on to user and let user decide what to do with it
> instead of silently ignoring it. The drawback is, it can generate
> false positive events.

I think you should do the additional validation here, instead of 
generating false positives. You should be able to read the instruction, 
run it through analyse_instr(), and then use OP_IS_LOAD_STORE() and 
GETSIZE() to understand the access range. This can be used to then 
perform a better match against what the user asked for.

- Naveen

