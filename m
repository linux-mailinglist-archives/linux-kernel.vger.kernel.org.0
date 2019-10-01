Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B722C2C1B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 04:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732347AbfJAC6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Sep 2019 22:58:30 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45016 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731123AbfJAC63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 22:58:29 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x912u0VR122136;
        Tue, 1 Oct 2019 02:58:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=NWfWwRHmRaqhsAqfppuxFT0/veRBB/ZYdCDyNvpCJ3U=;
 b=f/fuOZblS2XxGrFtm6usq+8v1NhBgR2/sh+WCA84jxjzEQFL3Ey98SlwhbAw8SqtSCGv
 vTxaUYNcSqLmJIoJxcIaaem2m/XlYiWKMB+Hp0SoPJMHv6SLVrzUeH/TwoY2fO+OYGPR
 KEosTEAVWHaZkU2CfqFl6Jt5ukABFbt2NrH3lcqGvKDdWx+zZnkE+y2A5gL8Jqc2QsYA
 cu/yzLjlHZ/aTug1l0wySZy4J+crtwwl/1vmfhEWog7E2dDiIickvDd3s2zZ/KfVnZVO
 l8z7ARMvWBqdnfr0rMzKXvIY51ul/xtYkXpgFNWHoNlb6GkB8ohP+SZTDEfr8jJ+jQYH 2w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2va05rjt44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 02:58:16 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x912wFjn062198;
        Tue, 1 Oct 2019 02:58:16 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2vbnqbvmvu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 02:58:16 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x912wBW2010529;
        Tue, 1 Oct 2019 02:58:11 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 30 Sep 2019 19:58:10 -0700
To:     Colin King <colin.king@canonical.com>
Cc:     John Garry <john.garry@huawei.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] scsi: hisi_sas: fix spelling mistake "digial" -> "digital"
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190916091706.32268-1-colin.king@canonical.com>
Date:   Mon, 30 Sep 2019 22:58:08 -0400
In-Reply-To: <20190916091706.32268-1-colin.king@canonical.com> (Colin King's
        message of "Mon, 16 Sep 2019 10:17:06 +0100")
Message-ID: <yq1sgodxjcv.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9396 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=932
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910010029
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9396 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910010029
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> There is a spelling mistake in literal string. Fix it.

Applied to 5.5/scsi-queue. Thanks.

-- 
Martin K. Petersen	Oracle Linux Engineering
