Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAB8AB0461
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2019 21:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730194AbfIKTEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Sep 2019 15:04:13 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38676 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728105AbfIKTEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 15:04:13 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8BIxecq070989;
        Wed, 11 Sep 2019 19:04:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=/eClILhHkjw0LpYIhEDRFhF0ehDvHS1dirEpGKitMHs=;
 b=nTa9vXO4zoomQrSYBGOhwFZIkgs6tPetu3O5OUM5P9V1ZX4PFiQPySoWDvF1uNJIa69U
 JZD+IQXlGXm1nw7Cr4wSMXSsjor0sUp5Papj2hggmPgzYHShrZgJtzwpqrk0f9WEQ6u0
 SN2IHrtNsHQu3t7SON1BXWZFr+SLkEUZ4V4l2tlI6V9V9q0NBiE3k4HaXrj7lyID+X84
 q5lqtfHjiTDmIGBTgf0okA5YMpcL/6EGsI8JUMrnkuBzdHp6ThB3YJUedHaRSWmw/rBf
 mbEzsB5/F05d5fEsd/1lBMvyWzBfrkLOStRUULjK/R7gBN1cza8y/uGDzOC+BMfSVQL5 jA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2uw1m947aq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Sep 2019 19:04:08 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8BJ3ggE015899;
        Wed, 11 Sep 2019 19:04:07 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2uy33b2ht8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Sep 2019 19:04:07 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8BJ421Y012734;
        Wed, 11 Sep 2019 19:04:02 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Sep 2019 12:04:01 -0700
Date:   Wed, 11 Sep 2019 22:03:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Sandro Volery <sandro@volery.com>
Cc:     valdis.kletnieks@vt.edu, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH v4] Staging: exfat: avoid use of strcpy
Message-ID: <20190911190355.GA18977@kadam>
References: <20190911195303.GA27966@volery>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911195303.GA27966@volery>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9377 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=965
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909110175
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9377 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909110174
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 09:53:03PM +0200, Sandro Volery wrote:
> diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
> index da8c58149c35..4336fee444ce 100644
> --- a/drivers/staging/exfat/exfat_core.c
> +++ b/drivers/staging/exfat/exfat_core.c
> @@ -2960,18 +2960,15 @@ s32 resolve_path(struct inode *inode, char *path, struct chain_t *p_dir,
>  	struct super_block *sb = inode->i_sb;
>  	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
>  	struct file_id_t *fid = &(EXFAT_I(inode)->fid);
> -
> -	if (strlen(path) >= (MAX_NAME_LENGTH * MAX_CHARSET_SIZE))
> +	

You have added a tab here.

> +	if (strscpy(name_buf, path, sizeof(name_buf)) < 0)
>  		return FFS_INVALIDPATH;
>  
> -	strcpy(name_buf, path);
> -
>  	nls_cstring_to_uniname(sb, p_uniname, name_buf, &lossy);
>  	if (lossy)
>  		return FFS_INVALIDPATH;
>  
> -	fid->size = i_size_read(inode);
> -
> +fid->size = i_size_read(inode);

And you accidentally deleted some white space here.

I use vim, so I have it configured to highlight whitespace at the end of
a line.  I don't remember how it's done now but I googled it for you.
https://vim.fandom.com/wiki/Highlight_unwanted_spaces

regards,
dan carpenter
