Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B456F5AA2E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2019 12:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfF2Kck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jun 2019 06:32:40 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34996 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbfF2Kck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 06:32:40 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5TASv4t078874;
        Sat, 29 Jun 2019 10:32:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=2oU+baNnGYXLU4uPl5XcwjOYu5QeXXsmvgarRO4YJus=;
 b=lZW1QkFJN6GpNXLAAUB/sWg4pjVBfdAQ5bNF5+MI4ots4E+FR7Y+NDgtogqXEQFmEvzP
 gG3gkxPzht/ACgvfxfDpbfGhUid1LdGAyucfbaSh8t1qPoTywZT98zATH4bqnqz5Pyon
 Uc0Fy5JI9hkGq9HPigW988LJ8cjXt7bxXODtuTF22Z3xQx3ERTE2dcComsZT4aa/Njjr
 p9ySP6TbPuh7fVPe5hCoo0WOKXTpn8TgkAXQG0wFt/PCDRzjiuYBWEmdKJ+V6LGejJD2
 bh6ewWZd7NMjuRSbV8hm14QiEbajwFZfih0Ra14TuzAqU6VJCys0/TQtz2IT3QEhZMkV 3g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2te61pg0mu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 29 Jun 2019 10:32:36 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5TAW0ON085529;
        Sat, 29 Jun 2019 10:32:35 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2tdx1a3kda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 Jun 2019 10:32:35 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5TAWYBw028039;
        Sat, 29 Jun 2019 10:32:34 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 29 Jun 2019 03:32:33 -0700
Date:   Sat, 29 Jun 2019 13:32:24 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] staging/rtl8723bs/hal: fix comparison to
 true/false is error prone
Message-ID: <20190629103222.GH19015@kadam>
References: <20190629101909.GA14880@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190629101909.GA14880@hari-Inspiron-1545>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9302 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906290132
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9302 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906290132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You sent 10 patches with the same subject.

Btw, I can't recall ever seeing a bug caused by a true false comparison.
I agree on style principles with the checkpatch warning, but I do
think it over states the risk (which is as far as I can see is zero).

regards,
dan carpenter

