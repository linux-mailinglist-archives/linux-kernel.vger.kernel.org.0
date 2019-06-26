Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F10B6563AF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 09:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfFZHv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 03:51:27 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41904 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfFZHv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 03:51:26 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5Q7mv3L148629;
        Wed, 26 Jun 2019 07:51:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=DLhWWoV7DMpdCJCPBZ560V866X8OmXEL0hmdn5y03HU=;
 b=zkCCX+vlqjpK/SbAi35EyfCvewlIFJIT7L+vliQHeFK3ExkzLkSTA0WkTqc4E0fuN5jn
 bJQwmSx1eaLU2MWK4p3uRPXG9Dz3UxRNrdnTlaUKuuOAVI9/MERhCD8vBHQheNPwZpaa
 TW1O4C7agV9R2Hfxr9ZtX5JYQDgPq8hpmWOIGeSkWkUH72njkcznopFyciIVj4aBJ3KB
 EjkpVr5HIhht8XtS6NJETTtJn664kRpW9UnDQ8Ey6AHC8+hPz7u4xAO+emKlXQHb42kd
 K7OIm7+zE6ahfpwnvdncuUUkFxU9bIMQclmXEmIdBP/Dlq2ArJM31LWkizPYvv0xzlS4 eA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2t9brt8nyc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jun 2019 07:51:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5Q7okWL095097;
        Wed, 26 Jun 2019 07:51:03 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2t9p6ums8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jun 2019 07:51:03 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5Q7ovQl020429;
        Wed, 26 Jun 2019 07:50:58 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Jun 2019 00:50:57 -0700
Date:   Wed, 26 Jun 2019 10:50:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Fabian Krueger <fabian.krueger@fau.de>
Cc:     devel@driverdev.osuosl.org, linux-kernel@i4.cs.fau.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Scheiderer <michael.scheiderer@fau.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] staging: kpc2000: style refactoring
Message-ID: <20190626075048.GD28859@kadam>
References: <20190625115251.GA28859@kadam>
 <20190626073531.8946-1-fabian.krueger@fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626073531.8946-1-fabian.krueger@fau.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=844
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906260094
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=906 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906260094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is better.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

