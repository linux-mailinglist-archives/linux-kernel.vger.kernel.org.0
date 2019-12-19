Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10B411271B4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 00:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfLSXnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 18:43:45 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:56800 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbfLSXnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 18:43:45 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBJNT1pR079308;
        Thu, 19 Dec 2019 23:43:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=V40tARymiv39q2cmnKqiqtnzC46o+QgO8uC2+bbWTHs=;
 b=j2LsY6xPOd0x5OZxlgZJQpZf6YfGKuEAxaeGbPKgJ0BMcdNxYcNzzqsrmES1N4JtTreI
 vgwdpOmSX8HqE56xR4/JUTlz4onJqbQswSgOHt6QzHh4PTMHf5CBvThbusXt7mfxQ+uy
 CzpX81N03jYlD0/4X8kB2ayCDzp1o71wPD+EC5HG6y0S0At5YDOMWWQftvY5w6vbPjQQ
 b7b4qBc/9uVRTYuQGMSJVHgQRzlF3W3dARHmdt3dmXlZ/PIeYAumJ8V0i2FEBUE1XqPB
 pxtAk8069N4kpbVhlbWqKXl/Ux+UaP1S+xQET+rnEYzoijcONOqek446Spu6MV07JLc4 iw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2x01knnv9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Dec 2019 23:43:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBJNYFR1011128;
        Thu, 19 Dec 2019 23:41:36 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2wyut62r92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Dec 2019 23:41:36 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBJNfYra009356;
        Thu, 19 Dec 2019 23:41:34 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Dec 2019 15:41:34 -0800
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     <mikecyr@linux.ibm.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: ibmvscsi_tgt: remove set but not used variables 'iue' and 'sd'
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20191213064042.161840-1-chenzhou10@huawei.com>
Date:   Thu, 19 Dec 2019 18:41:31 -0500
In-Reply-To: <20191213064042.161840-1-chenzhou10@huawei.com> (Chen Zhou's
        message of "Fri, 13 Dec 2019 14:40:42 +0800")
Message-ID: <yq1h81vc28k.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9476 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912190173
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9476 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912190173
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Chen,

> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c: In function ibmvscsis_send_messages:
> drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:1888:19: warning: variable iue set but not used [-Wunused-but-set-variable]
> drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c: In function ibmvscsis_queue_data_in:
> drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:3806:8: warning: variable sd set but not used [-Wunused-but-set-variable]

Applied to 5.6/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
