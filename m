Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14DD6E8F0C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 19:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730980AbfJ2SLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 14:11:30 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38442 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730435AbfJ2SL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 14:11:29 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9TI5MjK148312;
        Tue, 29 Oct 2019 18:11:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=kZ8BD5sjRssVt02kzdNHOFdftrYSLXQ8OYCabXdc6H4=;
 b=RV5+jh1sHwu/sXY/P++s6o/fvWpmdeg2pzTisP5S/+HOjJ4ZGSLygcPi0Lr0vo5jsE0h
 V5hfmBbmNZN6vC759StBWhd1/OKGE+xSVbhF9mgzFtA5mI6Rb20hlihbrrt9nXSt3eK8
 MV6JDIgzkIjiqe0K4L1KYxcgS8GwEIIFMmd5sGwNbv4hvEm2DXWVs6a5SVY/HUyswPQu
 dO+bMYKSaa/30lp1Zo0/uDPMaza6yHKdbDVVB0VyoI/mJ/6KuuvkkM1jcJJiBWDaCc5a
 8wAPfWEpc+sWlzMhRQ7nmF8AzZ2oWpv63W7uYSAMFtFJveOx3UrFBho4MxSnuqJQXpdp BA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2vvumffw7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Oct 2019 18:11:17 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9TI8RZQ052391;
        Tue, 29 Oct 2019 18:11:17 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2vxj8gprjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Oct 2019 18:11:16 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9TIB9Sb028453;
        Tue, 29 Oct 2019 18:11:09 GMT
Received: from localhost.localdomain (/10.159.132.196)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 29 Oct 2019 11:11:09 -0700
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
To:     arm@kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     khilman@kernel.org, arnd@arndb.de, olof@lixom.net,
        linux-kernel@vger.kernel.org, santosh.shilimkar@oracle.com
Subject: 
Date:   Tue, 29 Oct 2019 11:10:54 -0700
Message-Id: <1572372654-19805-2-git-send-email-santosh.shilimkar@oracle.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1572372654-19805-1-git-send-email-santosh.shilimkar@oracle.com>
References: <1572372654-19805-1-git-send-email-santosh.shilimkar@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=569
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910290160
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=669 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910290160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [GIT PULL 2/2] ARM: Keystone platform DTS updates for v5.5

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git for_5.5/keystone-dts

for you to fetch changes up to cfc0e76bbbde6875e026c18ea72f181e5d00d93f:

  ARM: configs: keystone: enable cpts (2019-10-07 10:59:10 -0700)

----------------------------------------------------------------
Grygorii Strashko (6):
      ARM: dts: keystone-clocks: add input fixed clocks
      ARM: dts: k2e-clocks: add input ext. fixed clocks tsipclka/b
      ARM: dts: k2e-netcp: add cpts refclk_mux node
      ARM: dts: k2hk-netcp: add cpts refclk_mux node
      ARM: dts: k2l-netcp: add cpts refclk_mux node
      ARM: configs: keystone: enable cpts

 arch/arm/boot/dts/keystone-clocks.dtsi     | 27 +++++++++++++++++++++++++++
 arch/arm/boot/dts/keystone-k2e-clocks.dtsi | 20 ++++++++++++++++++++
 arch/arm/boot/dts/keystone-k2e-netcp.dtsi  | 21 +++++++++++++++++++--
 arch/arm/boot/dts/keystone-k2hk-netcp.dtsi | 20 ++++++++++++++++++--
 arch/arm/boot/dts/keystone-k2l-netcp.dtsi  | 20 ++++++++++++++++++--
 arch/arm/configs/keystone_defconfig        |  1 +
 6 files changed, 103 insertions(+), 6 deletions(-)
