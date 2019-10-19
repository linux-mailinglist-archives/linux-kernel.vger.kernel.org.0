Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49BCBDD762
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2019 10:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbfJSIeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Oct 2019 04:34:03 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34774 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfJSIeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 04:34:02 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9J8T0LA094450;
        Sat, 19 Oct 2019 08:33:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=aXsdytmhua8cLksxQINyZd301Fq+c8U55m35wQFiV0w=;
 b=m/ihub8pbXoc01JQRudlfPpDd4SYR5xKYalnEOVWFOPefYl/aMankktfOKqpfNI0l5PM
 BdHjXS1H9Zi+vZlZPdz8G2sqA43GSeTx87l6W8zIUS2LDhULimgIOBRpWLTuWgPcyYEV
 QqOjOPJoq6Z5QYaU885Ws4whHQ2+HxblX2cZxaKAUk8zs6kegThuZNF+3TiTIutQmjDx
 bWW70CNSjiNnqjPxLAqV/THd1p52/MpB3eZjAxEypbWSoi0y4ZXakzYPIvNEfrdJdWyY
 9yCRgj+neDOO+zOmFJQ0nn0QJODbjUyiQufaXtInf0+5omoxaUvJ5806W85fieSN8lmi ew== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2vqtep8jm1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Oct 2019 08:33:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9J8Rsh6049597;
        Sat, 19 Oct 2019 08:31:29 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2vqqmh7rkr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Oct 2019 08:31:29 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9J8VRtF028148;
        Sat, 19 Oct 2019 08:31:27 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 19 Oct 2019 08:31:26 +0000
Date:   Sat, 19 Oct 2019 11:31:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ayman Bagabas <ayman.bagabas@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mattias Jacobsson <2pi@mok.nu>, Takashi Iwai <tiwai@suse.de>,
        kbuild test robot <lkp@intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] platform/x86: huawei-wmi: Stricter battery
 thresholds set
Message-ID: <20191019082855.GN21344@kadam>
References: <20191018224221.15495-1-ayman.bagabas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018224221.15495-1-ayman.bagabas@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9414 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=951
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910190073
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9414 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910190073
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 06:42:13PM -0400, Ayman Bagabas wrote:
> Check if battery thresholds are within 0 and 100.
> ---

Thanks!

Don't forget to add your Signed-off-by: though.

regards,
dan carpenter

