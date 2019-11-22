Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58786105E8A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2019 03:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfKVCNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 21:13:36 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:46752 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfKVCNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 21:13:36 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAM29MIY144986;
        Fri, 22 Nov 2019 02:13:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=rbaVrfvNpeSog8dcDylxXVV3ptewurNNj/oaRb7B83Y=;
 b=R2IINA7yBSLivO2IMdgp/49coWk21Epjfp4oasnXp4JR8Xl36Wq1bKjmfDLFRe/hZWS1
 RDLkt318zMmlHs5PpIjfbG5UckhjCAdkr6Ud4Vffj7Gt0h6BPvi1Fet6dfE62+65DWod
 ZlAnicLodJTK82OFh9D2dodBEcQXU6ZYsA0rord8BGLYg167LzVabB93Rw9BmjkOIxy4
 B1ujsT/aE2Kpz3U85HiWIz9KY6oPP0mqBWRuFyFTf8zH2OpUuiGLZO0At4hMwV9I/KJH
 SfjEd6xa+/tDmNj0mn7II5+O8lxm96dItBfEQetr8wKE+yexou7v0hPydQMqbzc1VKlP Pg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2wa8hu7xs4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Nov 2019 02:13:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAM28gGV112601;
        Fri, 22 Nov 2019 02:13:16 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2wdfrwd8jw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Nov 2019 02:13:16 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAM2DFHx013213;
        Fri, 22 Nov 2019 02:13:15 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Nov 2019 18:13:14 -0800
To:     John Garry <john.garry@huawei.com>
Cc:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>,
        <hch@lst.de>, <linux-scsi@vger.kernel.org>,
        <chenxiang66@hisilicon.com>, <linux-kernel@vger.kernel.org>,
        <yanaijie@huawei.com>
Subject: Re: [PATCH] scsi: scsi_transport_sas: Fix memory leak when removing devices
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1574242755-94156-1-git-send-email-john.garry@huawei.com>
Date:   Thu, 21 Nov 2019 21:13:12 -0500
In-Reply-To: <1574242755-94156-1-git-send-email-john.garry@huawei.com> (John
        Garry's message of "Wed, 20 Nov 2019 17:39:15 +0800")
Message-ID: <yq136egd5fr.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9448 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=822
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911220017
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9448 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=908 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911220017
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> Removing a non-host rphy causes a memory leak:

Applied to 5.5/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
