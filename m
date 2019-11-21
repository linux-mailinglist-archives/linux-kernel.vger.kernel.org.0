Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08D711047BD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 01:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfKUAxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 19:53:40 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16056 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726658AbfKUAxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 19:53:40 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAL0lmEX044681
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 19:53:39 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wadmyymfv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 19:53:39 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 21 Nov 2019 00:53:36 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 21 Nov 2019 00:53:33 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAL0qs6M18153960
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Nov 2019 00:52:54 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6ADF25204F;
        Thu, 21 Nov 2019 00:53:32 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.233.220])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id CE42F52050;
        Thu, 21 Nov 2019 00:53:31 +0000 (GMT)
Subject: Re: [PATCH v8 4/5] IMA: Add support to limit measuring keys
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Date:   Wed, 20 Nov 2019 19:53:31 -0500
In-Reply-To: <fef8fc67-643d-e579-9628-6516fd02b4db@linux.microsoft.com>
References: <20191118223818.3353-1-nramas@linux.microsoft.com>
         <20191118223818.3353-5-nramas@linux.microsoft.com>
         <1574291957.4793.144.camel@linux.ibm.com>
         <fef8fc67-643d-e579-9628-6516fd02b4db@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19112100-4275-0000-0000-000003842654
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112100-4276-0000-0000-00003897A1F0
Message-Id: <1574297611.4793.154.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-20_08:2019-11-20,2019-11-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 impostorscore=0 mlxscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 suspectscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1911210004
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-11-20 at 16:03 -0800, Lakshmi Ramasubramanian wrote:
> On 11/20/2019 3:19 PM, Mimi Zohar wrote:
> 
> Hi Mimi,
> 
> >> The above can be used to correlate the key measurement IMA entry,
> >> ima-sig and ima-modsig entries using the same key.
> > 
> > True, but associating the public key measurement with the file
> > signature requires information from the certificate (e.g. issuer,
> > serial number, and/or subject, subject keyid).
> > 
> > For a regression test, it would be nice if the key measurement,
> > itself, contained everything needed in order to validate the file
> > signatures in the measurement list.
> 
> I am just trying to understand your asks - Please clarify:
> 
> 1, My change includes only the public key and not the entire certificate 
> information in the measured buffer.
> 
> Should I update this current patch set to measure the entire cert. Or, 
> can that be done as a separate patch set?
> 
> 2, Should a regression test be part of this patch set for the key 
> measurement changes to be accepted?

Once the key measurement is defined and upstreamed, changing it would
result in a regression.  If we think that it would change multiple
times, then perhaps the buffer measurement needs to contain some sort
of versioning.

I would very much like for a regression test to be included in this
patch set, but it isn't a requirement, as long as everything needed
for verifying a signature is included in the key measurement.

Mimi

