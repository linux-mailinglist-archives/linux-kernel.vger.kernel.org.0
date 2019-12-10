Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10452117CAA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 01:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfLJAvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 19:51:46 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:56814 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbfLJAvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 19:51:45 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBA0ixgg071299;
        Tue, 10 Dec 2019 00:51:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=/E5tyMAH9RiXvb61SAiwAfhRym6/2hA1l0zXBSn/A3c=;
 b=l+ifuIi8LWyHUReeLi9aoLOpoQCUuu1cnBjHpGnXT/i+PYCD0qvvjnruTVMecgSHegr9
 WIjsKge3qrEZ8vBE0MCKOzb7BKZwxthvA77yfuSktyzL8wiROTSdLZJZb6hHXMQOkRDo
 zjWVM0bIit8y7XnEwsFCvSAD1yekmjm97D22pcVhC3/G1kDcCSQmCTXMLSRDr+eukxOk
 5vtq5HoQPq/FwNs2v0u390b7Xdt9n6seV3WgWE2xG0wl65FpXqqGSm6j02Iyh9Ot6oAI
 FfBpX1A3oJdsDcYxCVkwPCUBcQ+8yKQalsLU2uZDy9mDuYlY0ldxAi+wUzkcvDO6Ws1S tA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2wrw4myuac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Dec 2019 00:51:27 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBA0hTgN164290;
        Tue, 10 Dec 2019 00:51:27 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2wsw6g1mep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Dec 2019 00:51:27 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBA0pNhc025788;
        Tue, 10 Dec 2019 00:51:24 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Dec 2019 16:51:23 -0800
To:     Bean Huo <huobean@gmail.com>
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        pedrom.sousa@synopsys.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        cang@codeaurora.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scsi: ufs: delete unused structure filed tr
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20191205220912.5696-1-huobean@gmail.com>
Date:   Mon, 09 Dec 2019 19:51:20 -0500
In-Reply-To: <20191205220912.5696-1-huobean@gmail.com> (Bean Huo's message of
        "Thu, 5 Dec 2019 23:09:12 +0100")
Message-ID: <yq1h829ngtz.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9466 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=945
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912100005
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9466 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912100005
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Bean,

> Delete unused structure field tr in structure utp_upiu_req, since no
> person uses it for task management.

Applied to 5.6/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
