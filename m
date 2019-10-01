Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99703C2BFD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 04:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731685AbfJAClx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Sep 2019 22:41:53 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56572 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbfJAClx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 22:41:53 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x912e5EO111918;
        Tue, 1 Oct 2019 02:41:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=7QYldd5lauKFuOsuByd3OmP/vn3Q5ZE4ilUHuwmwfUc=;
 b=J+P0w7HResP37L98RYlyLveta/TRKqFOCu/cbnJHpXBVBf2jjErQb/O+BAmkhiv2fSZ1
 K+rk4Jvj35ve7DUGlVKQyDVctCr20PZoY/3zZGs1bPHw3CVUM/WapzjF2+nY6X8U35pB
 XKPSA64qT37HA5Fa+G0hXOIpSkBXD5f2TuhyKw3I6tvt/6ug78cX+Kg4nMDsa2Mmh/ck
 ZSBfhVy8YxfVBGedV/pMy5uZKvPq/iiIZdE7NCLFiuXpKT0pAQGJpUAxjtUs/wCYdiGM
 7r7skilWsGUuUSWIFXrqLveGYJxIZM6nMkqSmykOrYIOHeo2vWckduIUKkSoRdDY7LXt qw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2va05rjrv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 02:41:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x912ceNO030338;
        Tue, 1 Oct 2019 02:41:48 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2vbnqbv2bx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 02:41:48 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x912fkVK027537;
        Tue, 1 Oct 2019 02:41:46 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 30 Sep 2019 19:41:46 -0700
To:     Colin King <colin.king@canonical.com>
Cc:     qla2xxx-upstream@qlogic.com,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: qla2xxx: remove redundant assignment to pointer host
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190905134229.21194-1-colin.king@canonical.com>
Date:   Mon, 30 Sep 2019 22:41:43 -0400
In-Reply-To: <20190905134229.21194-1-colin.king@canonical.com> (Colin King's
        message of "Thu, 5 Sep 2019 14:42:29 +0100")
Message-ID: <yq1imp9yyoo.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9396 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910010026
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9396 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910010026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> The pointer host is being initialized with a value that is never read
> and is being re-assigned a little later on. The assignment is
> redundant and hence can be removed.

Applied to 5.5/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
