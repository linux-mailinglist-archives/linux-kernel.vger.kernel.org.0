Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54E8B13E2DB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 17:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732896AbgAPQ5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 11:57:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4342 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387483AbgAPQ5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:57:23 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00GGqYn4000998;
        Thu, 16 Jan 2020 11:57:00 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xfaw2n90s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jan 2020 11:57:00 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 00GGqo28029144;
        Thu, 16 Jan 2020 16:56:58 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma01dal.us.ibm.com with ESMTP id 2xf758m72s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jan 2020 16:56:58 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00GGuvLU45351198
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jan 2020 16:56:57 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 96292124053;
        Thu, 16 Jan 2020 16:56:57 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5FC47124052;
        Thu, 16 Jan 2020 16:56:57 +0000 (GMT)
Received: from localhost (unknown [9.41.100.106])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 16 Jan 2020 16:56:57 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH vdsotest] Use vdso wrapper for gettimeofday()
In-Reply-To: <0eddeeb64c97b8b5ce0abd74e88d2cc0303e49c6.1579090596.git.christophe.leroy@c-s.fr>
References: <0eddeeb64c97b8b5ce0abd74e88d2cc0303e49c6.1579090596.git.christophe.leroy@c-s.fr>
Date:   Thu, 16 Jan 2020 10:56:56 -0600
Message-ID: <871rrzjq5j.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-16_05:2020-01-16,2020-01-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 suspectscore=1 adultscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 phishscore=0 mlxlogscore=665 bulkscore=0 mlxscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001160136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> To properly handle errors returned by gettimeofday(), the
> DO_VDSO_CALL() macro has to be used, otherwise vdsotest
> misinterpret VDSO function return on error.
>
> This has gone unnoticed until now because the powerpc VDSO
> gettimeofday() always succeed, but while porting powerpc to
> generic C VDSO, the following has been encountered:

Thanks for this, I'll review it soon.

Can you point me to patches for the powerpc generic vdso work?
