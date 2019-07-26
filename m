Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F04A76BFE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 16:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387569AbfGZOsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 10:48:33 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55536 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbfGZOsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 10:48:33 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6QEmVe6050747;
        Fri, 26 Jul 2019 14:48:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : from : subject :
 message-id : date : mime-version : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=8kymT+5xJD+jtkrophmWlIqXssgA2k9y/HisZZkpHfo=;
 b=cGExvzI9m33gfQUgTZYOgA9tU4MuVGPCoSfaudQIU2RzPLfPQKU9C62joZT+NWPBVw+q
 KvioCjviiRDeroiliz9SPkQrq7TawGYTdcqSM9wU7FgMvGF7t1SbAmSDlVqO7O0NeM++
 rZYrsw8eLaz7r3vNxdY7ZFCmviIz4oZSc+srHEvh3lDfOQJmjGoV2hm5pSKCih2KQbnH
 XKnCK6G6vZn1yrS+Sr+ETsKEYVDINdzDKRzLaZhgz+uiuEKjmHiflD93I0NA8zA2LNr9
 /EmcpF54XkJ4IVpO1XvbV3lPtdBsDquiHQSvKqq7Xnz+jMgIYf/92EQWH7siM+yAvZDl jw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2tx61can03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Jul 2019 14:48:31 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6QElWAn091793;
        Fri, 26 Jul 2019 14:48:31 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2tx60yyndu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Jul 2019 14:48:31 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6QEmUad010286;
        Fri, 26 Jul 2019 14:48:30 GMT
Received: from [10.152.34.53] (/10.152.34.53)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 26 Jul 2019 07:48:30 -0700
To:     linux-kernel@vger.kernel.org
From:   George Kennedy <george.kennedy@oracle.com>
Subject: LPC 2019 distros microconference proposal: "Distros and Syzkaller -
 Why bother?"
Organization: Oracle Corporation
Message-ID: <1ada9248-6406-1afb-2b37-a25a1c3d6e03@oracle.com>
Date:   Fri, 26 Jul 2019 10:48:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9330 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=779
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907260182
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9330 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=845 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907260182
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have proposed "Distros and Syzkaller - Why bother?" for the LPC 2019 
distros microconference.

I am curious as to how other distros are using Syzkaller and if there 
are ways for us to collaborate.

I am curious how Syzkaller fits into the distro's development cycle, 
release cycle and if it is part
of the distro's Continuous Integration (CI) process?

Any insights would be appreciated.

Thank you,
George Kennedy

