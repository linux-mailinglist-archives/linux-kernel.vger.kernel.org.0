Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6621A13FA2C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 21:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733291AbgAPUIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 15:08:30 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:57712 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgAPUIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 15:08:30 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00GK368V132707;
        Thu, 16 Jan 2020 20:07:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=VXKP063RLeaEtvwZyxBIApAY7BlmugdZZoADPBt2YAg=;
 b=Q7wnOTFYlvOxiPoKMEqnlqRwvviOsCfv6eCIMDbOBNmD3T5Hyi6Z8ku4oy52bDgGr/Ls
 3euJmiXxZCmpVtlHKqb/TH4X19wd33S7+N9MN3T81wsn/xfL0ANlnJtUKJz0c/hMCtjh
 oCwuXlcYqrKqsrl/Mume1bsu8hKFpqOwfm22a6MD3T42DrxkHscIVxNGa54hrz3Gvu0E
 /ijxtHZeK011ndqjila2pTiVp8x8n502gLOQgLLfwhiVRgXmGMNiUxFn7WW23BQfTGbY
 b9VOJoX/f9548CXyKyZOiNelfyAum0DBOVDurNpd4P8YwIsQEsRu38iG6a/bkIgfAQ/I EA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2xf73yvu5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jan 2020 20:07:56 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00GK3mcQ042328;
        Thu, 16 Jan 2020 20:07:56 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2xj1ptpydj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jan 2020 20:07:55 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00GK7q6v014129;
        Thu, 16 Jan 2020 20:07:52 GMT
Received: from localhost.localdomain (/10.159.157.9)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 16 Jan 2020 12:07:52 -0800
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
To:     soc@kernel.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     khilman@kernel.org, arnd@arndb.de, olof@lixom.net,
        linux-kernel@vger.kernel.org, santosh.shilimkar@oracle.com,
        vkoul@kernel.org
Subject: [GIT_PULL] SOC: TI Keystone Ring Accelerator driver for v5.6
Date:   Thu, 16 Jan 2020 12:07:39 -0800
Message-Id: <1579205259-4845-1-git-send-email-santosh.shilimkar@oracle.com>
X-Mailer: git-send-email 1.9.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9502 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=749
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001160161
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9502 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=824 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001160161
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Its bit late for pull request, but if possible, please pull it to
soc drivers tree.

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/drivers_soc_for_5.6

for you to fetch changes up to 3277e8aa2504d97e022ecb9777d784ac1a439d36:

  soc: ti: k3: add navss ringacc driver (2020-01-15 10:07:27 -0800)

----------------------------------------------------------------
SOC: TI Keystone Ring Accelerator driver

The Ring Accelerator (RINGACC or RA) provides hardware acceleration to
enable straightforward passing of work between a producer and a consumer.
There is one RINGACC module per NAVSS on TI AM65x SoCs.

----------------------------------------------------------------
Grygorii Strashko (2):
      bindings: soc: ti: add documentation for k3 ringacc
      soc: ti: k3: add navss ringacc driver

 .../devicetree/bindings/soc/ti/k3-ringacc.txt      |   59 +
 drivers/soc/ti/Kconfig                             |   11 +
 drivers/soc/ti/Makefile                            |    1 +
 drivers/soc/ti/k3-ringacc.c                        | 1157 ++++++++++++++++++++
 include/linux/soc/ti/k3-ringacc.h                  |  244 +++++
 5 files changed, 1472 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/ti/k3-ringacc.txt
 create mode 100644 drivers/soc/ti/k3-ringacc.c
 create mode 100644 include/linux/soc/ti/k3-ringacc.h
