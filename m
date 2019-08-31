Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06A52A4252
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2019 06:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfHaE6D convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 31 Aug 2019 00:58:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7244 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725298AbfHaE6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 00:58:02 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7V4v2Nn038830
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2019 00:58:01 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2uqc4ph5jq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2019 00:58:01 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <sachinp@linux.vnet.ibm.com>;
        Sat, 31 Aug 2019 05:57:59 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 31 Aug 2019 05:57:56 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7V4vtbb18022426
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 31 Aug 2019 04:57:55 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EBE674203F;
        Sat, 31 Aug 2019 04:57:54 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BFD6A42041;
        Sat, 31 Aug 2019 04:57:53 +0000 (GMT)
Received: from [9.85.86.104] (unknown [9.85.86.104])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat, 31 Aug 2019 04:57:53 +0000 (GMT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: Oops (request_key_auth_describe) while running cve-2016-7042 from
 LTP
From:   Sachin Sant <sachinp@linux.vnet.ibm.com>
In-Reply-To: <11986.1567178014@warthog.procyon.org.uk>
Date:   Sat, 31 Aug 2019 10:27:52 +0530
Cc:     Hillf Danton <hdanton@sina.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@ozlabs.org, keyrings@vger.kernel.org
Content-Transfer-Encoding: 8BIT
References: <85B7196E-D717-4F19-A7E8-82A18287A3DE@linux.vnet.ibm.com>
 <11986.1567178014@warthog.procyon.org.uk>
To:     David Howells <dhowells@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-TM-AS-GCONF: 00
x-cbid: 19083104-0008-0000-0000-0000030F3A30
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19083104-0009-0000-0000-00004A2D8338
Message-Id: <B5F9CFC3-2B4E-4121-9EA2-F110B79832C6@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-31_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=882 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908310055
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 30-Aug-2019, at 8:43 PM, David Howells <dhowells@redhat.com> wrote:
> 
> Can you try this patch instead of Hillf’s?

Works for me. Test ran fine without any problem.

Tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>

Thanks
-Sachin

