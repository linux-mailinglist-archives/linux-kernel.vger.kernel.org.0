Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 541BE2EA7C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 04:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfE3CG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 22:06:56 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:60628 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfE3CG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 22:06:56 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4U2428O001659;
        Thu, 30 May 2019 02:06:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=Zy5vdPgjjQk9xLYX7WnxHkcZYvNXypKj8mTr56Z1D68=;
 b=5qYPgO7LTRNx77OxqlrryzIY3gzPFHz2gCeVg+r+QFyFs7nTCMQdTH3PF8TWDVvel3oI
 UuTEHeuR0zZhYk52itunA/A54m+ftvc8NH+pOBT+q0U43mB8C6MyixJNnFI91yB9gatf
 mtuLaEtVOyI0E8gn60oIzZPqM+HyUDOLT3HMi1E+/MQ5UKAieA6vSfzltqNDQVr807n+
 CLXhqpeSl1GWL+aRfQ+U76msGFJc11gSJ/G4Y79Cre+HktIdpwgbkULMAGy7eYRhtYn1
 WsJi3qjwXSemZUWwZdaZYLtN1Dg2EqDyf1fX/OabmWzrKOWxBu/cIOULb/5vqFYfoCeg lA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 2spu7dnhs9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 02:06:32 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4U264Re000989;
        Thu, 30 May 2019 02:06:32 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2sr31vkhts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 02:06:31 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4U26U7G003337;
        Thu, 30 May 2019 02:06:30 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 May 2019 19:06:30 -0700
To:     "Thomas Meyer" <thomas@m3y3r.de>
Cc:     james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: lpfc: Use *_pool_zalloc rather than *_pool_alloc
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1559161113889-196429735-0-diffsplit-thomas@m3y3r.de>
        <1559161113901-1017843021-1-diffsplit-thomas@m3y3r.de>
Date:   Wed, 29 May 2019 22:06:28 -0400
In-Reply-To: <1559161113901-1017843021-1-diffsplit-thomas@m3y3r.de> (Thomas
        Meyer's message of "Wed, 29 May 2019 22:21:36 +0200")
Message-ID: <yq1v9xsy9uj.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=801
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905300014
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=855 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905300014
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thomas,

> Use *_pool_zalloc rather than *_pool_alloc followed by memset with 0.

Applied to 5.3/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
