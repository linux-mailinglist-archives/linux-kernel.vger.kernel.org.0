Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F022E48D72
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 21:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfFQTGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 15:06:03 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39124 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbfFQTGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:06:02 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HJ3kTC109174;
        Mon, 17 Jun 2019 19:05:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=ws5Oz7lWc6UyIPNTo46edvG5iO98Fd3iWSFkEtJcGmE=;
 b=xKn6GvqYkiT5wbo8pgSYOLRYfXliVt+b+xhEuaOc3E03O/zXLgbqhxlulkjJdOmuXzQE
 jCO480TFhZgyVvfX5nYiNH+MKPybXPBnNmj0c4kXuSlVr41hewK8UbNWD7AeK2r9Dgxg
 r3vKnu40S8adUU0jtbaU75PbaTuWcSJ2uFVWHkz5LqaKM9tUsHiDh6hLf/X21VGKvp8X
 i18kGJbMA0TiQs7LuAcq0QakM0d4eMpPpF7nXb6YdffyUUtYbSc0SUyXSmhAKgteAXeK
 6H6D/ogblVNegqmKwJEcO5Z9r+QlBlHZcp4nSyk0UFK5myuM0gkgzVjwww2u1Exxj4SX Qw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2t4rmp07wq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jun 2019 19:05:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HJ4PPx117997;
        Mon, 17 Jun 2019 19:05:58 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2t5mgbh6dh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jun 2019 19:05:58 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5HJ5uFi029702;
        Mon, 17 Jun 2019 19:05:56 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 17 Jun 2019 12:05:56 -0700
Date:   Mon, 17 Jun 2019 22:05:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] MFD fixes for v5.2
Message-ID: <20190617190549.GW1893@kadam>
References: <20190617100054.GE16364@dell>
 <CAHk-=wgTL5sYCGxX8+xQqyBRWRUE05GAdL58+UTG8bYwjFxMkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgTL5sYCGxX8+xQqyBRWRUE05GAdL58+UTG8bYwjFxMkw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=829
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906170169
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=886 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906170169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ah...  Sorry.  There are a couple similar bugs in other places and I'll
take a look at those tomorrow as well.

regards,
dan carpenter

