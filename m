Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84900C06D3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2019 15:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbfI0N7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Sep 2019 09:59:09 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60994 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbfI0N7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 09:59:09 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8RDwn29021767;
        Fri, 27 Sep 2019 13:59:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=OISkejdCnUQ7n1u+9AO5cwXNSfG1nz9xfUQ6TViyWls=;
 b=rajcAFOyckY2py9OvWKGBHE0XENcGcHHZWI7QydjlrZz9LrWBYBJPTca08zYkuOcedvD
 tin+eBGjDIDdCFMFged5W7wZUxe99ySnap81P1wdbdmQOS60Zz+uib0d91nknSbeHmuu
 TEZ/gzNnDc/h1ih5xP5SStWU4VhoIYjsPIgC5uZETBBRl4GBchKhwkPG4ItNmnLKzAAw
 SVED0dJHfl0lJcrfx5Z7FRcVP4zb5yZiHjJacCXjXijQxAI1Y9nMQLACqO3G6bH9n9Af
 m9MZMKo8+9Exsop2Fatt1GZEB9v0Pa4MnSBEkfctcYQkULY/r/Bo8dPBRB6MR8JFoTxu 3A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2v5cgrjdry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Sep 2019 13:59:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8RDwaeP014695;
        Fri, 27 Sep 2019 13:58:59 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2v8yk03hxy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Sep 2019 13:58:52 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8RDwS9f032464;
        Fri, 27 Sep 2019 13:58:28 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 27 Sep 2019 06:58:27 -0700
Date:   Fri, 27 Sep 2019 16:58:18 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Connor Kuehl <connor.kuehl@canonical.com>
Cc:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        straube.linux@gmail.com, devel@driverdev.osuosl.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8188eu: remove dead code/vestigial
 do..while loop
Message-ID: <20190927102349.GG27389@kadam>
References: <20190924142819.5243-1-connor.kuehl@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924142819.5243-1-connor.kuehl@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9392 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=843
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909270132
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9392 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=924 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909270132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good.  Thanks!

regards,
dan carpenter

