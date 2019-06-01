Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0753931B38
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2019 12:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfFAKWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jun 2019 06:22:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41656 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726130AbfFAKWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 06:22:54 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x51AMCcM126669
        for <linux-kernel@vger.kernel.org>; Sat, 1 Jun 2019 06:22:54 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sun77bjsh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2019 06:22:53 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Sat, 1 Jun 2019 11:22:51 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 1 Jun 2019 11:22:49 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x51AMmLw52101302
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 1 Jun 2019 10:22:48 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 95AD3A4054;
        Sat,  1 Jun 2019 10:22:48 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70E16A405B;
        Sat,  1 Jun 2019 10:22:48 +0000 (GMT)
Received: from osiris (unknown [9.152.212.21])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat,  1 Jun 2019 10:22:48 +0000 (GMT)
Date:   Sat, 1 Jun 2019 12:22:47 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/purgatory: update .gitignore
References: <20190531024651.5925-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531024651.5925-1-yamada.masahiro@socionext.com>
X-TM-AS-GCONF: 00
x-cbid: 19060110-0016-0000-0000-000002824FE6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060110-0017-0000-0000-000032DF5378
Message-Id: <20190601102247.GF3600@osiris>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-01_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=838 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906010077
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 11:46:51AM +0900, Masahiro Yamada wrote:
> Since commit 4c0f032d4963 ("s390/purgatory: Omit use of bin2c"),
> kexec-purgatory.c is not generated.
> 
> purgatory and purgatory.lds are generated files, so should be ignored
> by git.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  arch/s390/purgatory/.gitignore | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/purgatory/.gitignore b/arch/s390/purgatory/.gitignore
> index e9e66f178a6d..04a03433c720 100644
> --- a/arch/s390/purgatory/.gitignore
> +++ b/arch/s390/purgatory/.gitignore
> @@ -1,2 +1,3 @@
> -kexec-purgatory.c
> +purgatory
> +purgatory.lds
>  purgatory.ro

Applied, thanks.

