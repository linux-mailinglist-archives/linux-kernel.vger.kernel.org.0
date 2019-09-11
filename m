Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E04F2AF824
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2019 10:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfIKIlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Sep 2019 04:41:32 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35032 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfIKIlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 04:41:32 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8B8dTsY028594;
        Wed, 11 Sep 2019 08:41:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=xGO9SBAbulRLI7ZbRakTvABa/JaF87+OoWtKT13pbQg=;
 b=DUgrt1P17LA7+GB2zwXXKjr6o0liEZ+Z/cOoOr26XPv+RfaSurzXWIfMV/+sZMjbeUl8
 MPFXEC5QTLfyFlPJdbOvHoTPf+qgb9SIemU65U8dxhJnMEw9ft4JIZFYH+rY7bzApVXf
 PxUb6QxiZJH+hhMkqX/MCUU9tUMq5zotLkE/6sndqLpi2tpuk0jEl92eSfL2uvqk+eqr
 WyDqkEYvVRRB1hBLmpoqIYipvAr2Pr73SQdVzKmGhk99yERyOQ9wSfMKdBbhunJsM4em
 ajdDyfhdcmcykuIikw0fB/otFpmEglzb+k8gO+Q/7xkBpaWqlRHU7FV7Exsb0eM1e2mZ vQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2uw1jy8d54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Sep 2019 08:41:28 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8B8c85I192973;
        Wed, 11 Sep 2019 08:41:28 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2uxk0t0864-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Sep 2019 08:41:27 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8B8fJYx019409;
        Wed, 11 Sep 2019 08:41:21 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Sep 2019 01:41:19 -0700
Date:   Wed, 11 Sep 2019 11:41:11 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Sandro Volery <sandro@volery.com>
Cc:     valdis.kletnieks@vt.edu, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: exfat: Avoid use of strcpy
Message-ID: <20190911084111.GG15977@kadam>
References: <20190911055749.GA10786@volery>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911055749.GA10786@volery>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9376 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909110082
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9376 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909110082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 07:57:49AM +0200, Sandro Volery wrote:
> Replaced strcpy with strscpy in exfat_core.c.
> 
> Signed-off-by: Sandro Volery <sandro@volery.com>
> ---
>  drivers/staging/exfat/exfat_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
> index da8c58149c35..c71b145e8a24 100644
> --- a/drivers/staging/exfat/exfat_core.c
> +++ b/drivers/staging/exfat/exfat_core.c
> @@ -2964,7 +2964,7 @@ s32 resolve_path(struct inode *inode, char *path, struct chain_t *p_dir,
>  	if (strlen(path) >= (MAX_NAME_LENGTH * MAX_CHARSET_SIZE))
>  		return FFS_INVALIDPATH;
>  
> -	strcpy(name_buf, path);
> +	strscpy(name_buf, path, sizeof(name_buf));

It checked strlen() earlier so we know that it can't overflow but, oh
wow, the "name_buf" is a shared buffer.  wow wow wow.  This seems very
racy.

regards,
dan carpenter

