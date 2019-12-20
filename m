Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7637E127427
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 04:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfLTDte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 22:49:34 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:48008 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbfLTDte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 22:49:34 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBK3nLfQ051685;
        Fri, 20 Dec 2019 03:49:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=GTiOcXJQunO//AwjgksBQNuwNz7ld2diMaJL2w78mIw=;
 b=iFdZFh7BMzxdmaJTWACH4bQdhMJvAfy7aEG0HKQQDtNp2MS4TIFeZet1jl3C+tmyaguY
 /DgRP0kpBXgdbBfQalBUPwSkawRW0sm1DMme8Qp+9RXFQR7qmhU8RzOY3+0oCauu0w2I
 IWibW1IyosN0kCDZiJTEJTkhzVuueo7JOBHDKFX1y3ezoKlAAc0obzO/tuRcTtS/Axg7
 0rlu7Af4jv1DlWehURhGT3YJGyUOhoH8374+OjdMFMFUyOlYIpNAanLAeNNi4jBD8QLj
 YUVN3/D0iMqf68GM8XNUO4IV1YVRaUmELTaYQHBJLatmEl4E99vAfC98ySLJMYc+Cfqu PQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2x01knpexe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Dec 2019 03:49:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBK3huSJ064540;
        Fri, 20 Dec 2019 03:47:21 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2x04mt9ja6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Dec 2019 03:47:21 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBK3lHJt008028;
        Fri, 20 Dec 2019 03:47:18 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Dec 2019 19:47:17 -0800
To:     John Garry <john.garry@huawei.com>
Cc:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>,
        <yanaijie@huawei.com>, <chenxiang66@hisilicon.com>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH v2] scsi: libsas: Tidy SAS address print format
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1576758957-227350-1-git-send-email-john.garry@huawei.com>
Date:   Thu, 19 Dec 2019 22:47:15 -0500
In-Reply-To: <1576758957-227350-1-git-send-email-john.garry@huawei.com> (John
        Garry's message of "Thu, 19 Dec 2019 20:35:57 +0800")
Message-ID: <yq1o8w38xq4.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9476 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=829
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912200025
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9476 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=909 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912200026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> Currently we use a mixture of %016llx, %llx, and %16llx when printing a
> SAS address.

Applied to 5.6/scsi-queue, thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
