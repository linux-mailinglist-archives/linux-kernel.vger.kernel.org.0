Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B06B51012D1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2019 06:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfKSFI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 00:08:28 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:51170 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbfKSFI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:08:27 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJ54Cvm118063;
        Tue, 19 Nov 2019 05:08:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=IH0WjlNL7rKxLG37GwdnWXVekjBu4cR117TZnEVESOY=;
 b=bq4CSO+QzTp/yU0F2UgoWF6PMjmW64+fDY/J7NURHv3FRC2cEotQIzViTM/4dsnf5Pg6
 an0P565hi6kHGs5PTqbq7EgS4w3uD/l6CoEwNLQDOnQNcSlf/6QQj789+rBK1z2nMwwr
 Q09NExSoMhGVaTDIuMqbKWg8+OIq7DQ/pJe4gdrshf//Kwz7lRe5qazEECnQ6fCy5kUC
 0J/7l9R2fvyP9oq9F2ACX+Vd3yIijiYNXUdHoR11eIBvhPkMCFvKC37k0NsRSXrMtVfr
 sqpF0zgUT9oF55Q/CSLjwtRlzSY1RAWIlvPW0GVoRnIoBo7iKocBzJBapPr8FoEeXbcd eg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2wa8htmh6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 05:08:18 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJ4wHXQ076076;
        Tue, 19 Nov 2019 05:06:18 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2wc0afqwut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 05:06:18 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAJ56FUk001985;
        Tue, 19 Nov 2019 05:06:17 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Nov 2019 21:06:15 -0800
To:     Pan Bian <bianpan2016@163.com>
Cc:     QLogic-Storage-Upstream@qlogic.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: bnx2i: fix potential use after free
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1573043541-19126-1-git-send-email-bianpan2016@163.com>
Date:   Tue, 19 Nov 2019 00:06:13 -0500
In-Reply-To: <1573043541-19126-1-git-send-email-bianpan2016@163.com> (Pan
        Bian's message of "Wed, 6 Nov 2019 20:32:21 +0800")
Message-ID: <yq1k17wihfe.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=542
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911190045
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=627 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911190046
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Pan,

> The membe hba->pcidev may be used after its reference is dropped. Move
> the put function to where it is never used to avoid potential use
> after free issues.

Applied to 5.5/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
