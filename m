Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2AEE4AF3C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 02:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729715AbfFSA6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 20:58:22 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58534 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729435AbfFSA6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 20:58:22 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J0roOC185570;
        Wed, 19 Jun 2019 00:58:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=t7cTODPgzKbuvjtqLFqxo9Sa5UKPbxE1cKwVPB1mYaU=;
 b=QTFw+peAH09UBk+xamxDRzhZrbU7Dcm74meIF3MB0rUobFzthVff8DfybpY6b+AmdOds
 TPmvKIpwatuL5OR/BDFcWaFBpHW1V9FitEQUtkOC3hZHrJAcvUHjMbAa6gC4BeBrykgj
 dMgOxZh31lnXJhLjTljiWqwjgRGXCkA5jPFv7eCcxrSqcr3Fbq6jzfpr9779gPIsNsVQ
 VgzzlRUzL/+XaV8chsNKCOtJFeWXsbh5yqqfOgRdC41YdtIPKYXqVee+bRXVuafQh4cz
 qFq4tjPVqklU0DOWselpIBJCTdBLlbK+SPxXDLb8KNfy7OE0/QEdeZ1SLwXE76r/blSX ZA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2t78098f68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 00:58:10 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J0stFV088294;
        Wed, 19 Jun 2019 00:56:09 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2t77ynhufr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 00:56:09 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5J0u6Pe030895;
        Wed, 19 Jun 2019 00:56:06 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Jun 2019 17:56:06 -0700
To:     John Garry <john.garry@huawei.com>
Cc:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <intel-linux-scu@intel.com>, <artur.paszkiewicz@intel.com>,
        <jinpu.wang@profitbricks.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hare@suse.de>
Subject: Re: [PATCH v2] scsi: libsas, lldds: Use dev_is_expander()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1560170501-220025-1-git-send-email-john.garry@huawei.com>
Date:   Tue, 18 Jun 2019 20:56:03 -0400
In-Reply-To: <1560170501-220025-1-git-send-email-john.garry@huawei.com> (John
        Garry's message of "Mon, 10 Jun 2019 20:41:41 +0800")
Message-ID: <yq1sgs6xujg.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=793
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906190005
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=859 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906190005
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> Many times in libsas, and in LLDDs which use libsas, the check for an
> expander device is re-implemented or open coded.
>
> Use dev_is_expander() instead. We rename this from
> sas_dev_type_is_expander() to not spill so many lines in referencing.

Applied to 5.3/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
