Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA729857A5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 03:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389588AbfHHBca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Aug 2019 21:32:30 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39858 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730433AbfHHBc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 21:32:29 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x781Tgae055528;
        Thu, 8 Aug 2019 01:31:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=I7g93oDAJADygq6HSUWo+aeYES9vSI9AEdt1OGiyNz8=;
 b=XGRmiAL5xrMyH4BD6rQpMgEzZE5OWdR7ScRvV9DRz38sQN7YLEqw+lLIW2kQMTjduqGU
 J9uXHChdMlexO/4wYNOhU6C8bX9IVQyGC/Q4UXTm7Tu93/t1l5sstQRljSQ8Ca9SbmOD
 SvzpiPn89Km8HzZQAnTE9acMQHdD0cVqOXSQXXK9xpMLdNXxCCZncYl1b7Uvak4JiK6J
 VU/GVImvti7C+in2am3uX15FzMxfFOCeO4D/MLUhiW/z2txb4T32im4QZm6x9RSDEU3c
 JaKc+lU1WrIJsZsc7cG+Cdt42eOxkPjg3Rg/y6s2BrgPg+ltfzdxdoUI/CLpvBlm54DU pQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2u52wrffjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Aug 2019 01:31:49 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x781SOHm122436;
        Thu, 8 Aug 2019 01:31:48 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2u763jhe8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Aug 2019 01:31:48 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x781VgAF001151;
        Thu, 8 Aug 2019 01:31:43 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 07 Aug 2019 18:31:42 -0700
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Tyrel Datwyler <tyreld@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] scsi: ibmvfc: Mark expected switch fall-throughs
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190729002608.GA25263@embeddedor>
Date:   Wed, 07 Aug 2019 21:31:39 -0400
In-Reply-To: <20190729002608.GA25263@embeddedor> (Gustavo A. R. Silva's
        message of "Sun, 28 Jul 2019 19:26:08 -0500")
Message-ID: <yq1mugke938.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9342 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=850
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908080011
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9342 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=906 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908080011
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Gustavo,

> Mark switch cases where we are expecting to fall through.

Applied to 5.4/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
