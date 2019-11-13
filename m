Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8592FFA706
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 04:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfKMDGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 22:06:46 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:43178 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbfKMDGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 22:06:46 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAD34Gqa093160;
        Wed, 13 Nov 2019 03:06:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=UcUnWbUcO8uAL27ZIr6jIOj83AcLtiKVoXpB4FfilqM=;
 b=GjacV2HaBVKcqMHAzelHyvgg4nZSeJtWUSRjlLh4BuccCn+zJLwCmiR55CkrkkFzhgUw
 Wre7xSnMgnrYHanyHNJBAwXLG1Bw+5n9OQIJw5LyanyuItSKKwp+NT/2GsTitHVtf8ba
 26WmkOujq2KG5JigYn0khAuFkmi28jAgFpf5nT0yJFhUaUVEWsSwu4iJJf87hPlG4/Lp
 /cvXGY8VV+93rOWvs/6MysEDGmGGgF2uh+H+G95M7um288/Mc3TF5fB7VrwyEeAxiBPF
 07Wqt04eMxkHwr1f6Ch+TafdI0kVk0z+r6/XZTAfRf2zNyhk5Ej+zhIFPaSItoD0mjHK RA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2w5ndq95pp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Nov 2019 03:06:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAD34QST156735;
        Wed, 13 Nov 2019 03:04:36 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2w7vpnfj9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Nov 2019 03:04:36 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAD33tna006318;
        Wed, 13 Nov 2019 03:03:56 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Nov 2019 19:03:55 -0800
To:     Can Guo <cang@codeaurora.org>
Cc:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        rnayak@codeaurora.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com, saravanak@google.com, salyzyn@google.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v3 1/5] scsi: Adjust DBD setting in mode sense for caching mode page per LLD
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1572670898-750-1-git-send-email-cang@codeaurora.org>
        <1572670898-750-2-git-send-email-cang@codeaurora.org>
Date:   Tue, 12 Nov 2019 22:03:52 -0500
In-Reply-To: <1572670898-750-2-git-send-email-cang@codeaurora.org> (Can Guo's
        message of "Fri, 1 Nov 2019 22:01:34 -0700")
Message-ID: <yq1tv78pjdz.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9439 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=850
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911130025
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9439 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=917 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911130025
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Can,

> Host sends MODE_SENSE_10 with caching mode page, to check if the
> device supports the cache feature.  UFS JEDEC standards require DBD
> field to be set to 1.

UFS requires DBD for all MODE SENSE(10) invocations, not just for
accessing the caching mode page. I think the flag name needs to reflect
this.

Also, I do not particularly like this being a scsi_host flag. All the
other flags we have in this department are per scsi_device.

My recommendation would be to add a set_dbd_for_ms flag to struct
scsi_device and then do:

	sdev->set_dbd_for_ms = 1;

in ufshcd_slave_alloc() mirroring the existing:

        sdev->use_10_for_ms = 1;

This makes the MODE SENSE tweakery consistent.

Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
