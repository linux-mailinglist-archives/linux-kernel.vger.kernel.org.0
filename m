Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 486C414A9A1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jan 2020 19:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgA0SQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 13:16:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25914 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725828AbgA0SQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 13:16:24 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00RIFEWT046661
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 13:16:22 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xrjr4je58-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 13:16:21 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 27 Jan 2020 18:16:20 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 27 Jan 2020 18:16:17 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00RIGGeB60948548
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jan 2020 18:16:16 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7F89A4040;
        Mon, 27 Jan 2020 18:16:16 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0442AA4055;
        Mon, 27 Jan 2020 18:16:16 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.185.238])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 27 Jan 2020 18:16:15 +0000 (GMT)
Subject: Re: [PATCH 1/2] ima: use the IMA configured hash algo to calculate
 the boot aggregate
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Mon, 27 Jan 2020 13:16:15 -0500
In-Reply-To: <ca189378a5f841d0ba111c6405079569@huawei.com>
References: <1580140919-6127-1-git-send-email-zohar@linux.ibm.com>
         <ca189378a5f841d0ba111c6405079569@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20012718-0012-0000-0000-000003812734
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012718-0013-0000-0000-000021BD7810
Message-Id: <1580148975.5088.38.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-27_06:2020-01-24,2020-01-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001270146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-01-27 at 17:38 +0000, Roberto Sassu wrote:
> > -----Original Message-----
> > From: linux-integrity-owner@vger.kernel.org [mailto:linux-integrity-
> > owner@vger.kernel.org] On Behalf Of Mimi Zohar
> > Sent: Monday, January 27, 2020 5:02 PM
> > To: linux-integrity@vger.kernel.org
> > Cc: Jerry Snitselaar <jsnitsel@redhat.com>; James Bottomley
> > <James.Bottomley@HansenPartnership.com>; linux-
> > kernel@vger.kernel.org; Mimi Zohar <zohar@linux.ibm.com>
> > Subject: [PATCH 1/2] ima: use the IMA configured hash algo to calculate the
> > boot aggregate
> 
> Hi Mimi
> 
> I did a similar change (patch 8/8) in the patch set I just sent. The patch is simpler,
> as it reuses the data structures I introduced in the previous patches. Let me know
> if I can keep this part in my patch set or I should remove it.

Only 2/2 "ima: support calculating the boot_aggregate based on
different TPM banks" is really needed to address Jerry's bug report.
 Let's review your patch set before making any decisions about 1/2
"ima: use the IMA configured hash algo to calculate the boot
aggregate".

thanks,

Mimi

