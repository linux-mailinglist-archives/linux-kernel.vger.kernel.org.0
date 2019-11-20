Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7099C1043C2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 19:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfKTS4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 13:56:52 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:36734 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbfKTS4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 13:56:45 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAKIs6SO026177;
        Wed, 20 Nov 2019 18:56:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=Vyk7zTFLGmHD7QT7ZBJLwCH8ALXYwWs90USs3NJmkNY=;
 b=DicE+rK1Z41itpwarsatmD35LAMDmvsVkGODi197rxL5f1t+iEAdOfHpastUmzmfBbva
 0HHsFM5Ytro4KtRT63BYspxch8kievE3+eHfb93EyR7sf3Ifo7hju8FVEYv48QHmtlSm
 1x+BBxga1uKXGs4In7u0KqKnC98QWF7wx4m9W9xfnce/hYL2O6GlpxRNrOt/z2w8+utO
 DsfiUjFa3jKk/1OvvUFlCLmZLTVP1z15VyeUjpc5CFIuMcDZi+Cv47dc2ILy0VQEDu4d
 beyBQYKQynvd7ZgOOUfbDCFxvA1LLwQSkvA6pvjRNfzVa01s2Ytts6qvq2VkcuqKqBXL KQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2wa8htyjep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Nov 2019 18:56:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAKIriiD139536;
        Wed, 20 Nov 2019 18:56:37 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2wd47vmgtm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Nov 2019 18:56:36 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAKIuaLZ012933;
        Wed, 20 Nov 2019 18:56:36 GMT
Received: from zissou.us.oracle.com (/10.152.34.58)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Nov 2019 10:56:35 -0800
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: [PATCH 3/4] padata: always acquire cpu_hotplug_lock before pinst->lock
Date:   Wed, 20 Nov 2019 13:54:11 -0500
Message-Id: <20191120185412.302-4-daniel.m.jordan@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191120185412.302-1-daniel.m.jordan@oracle.com>
References: <20191120185412.302-1-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9447 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911200156
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9447 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911200156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lockdep complains when padata's paths to update cpumasks via CPU hotplug
and sysfs are both taken:

  # echo 0 > /sys/devices/system/cpu/cpu1/online
  # echo ff > /sys/kernel/pcrypt/pencrypt/parallel_cpumask

  ======================================================
  WARNING: possible circular locking dependency detected
  5.4.0-rc8-padata-cpuhp-v3+ #1 Not tainted
  ------------------------------------------------------
  bash/205 is trying to acquire lock:
  ffffffff8286bcd0 (cpu_hotplug_lock.rw_sem){++++}, at: padata_set_cpumask+0x2b/0x120

  but task is already holding lock:
  ffff8880001abfa0 (&pinst->lock){+.+.}, at: padata_set_cpumask+0x26/0x120

  which lock already depends on the new lock.

padata doesn't take cpu_hotplug_lock and pinst->lock in a consistent
order.  Which should be first?  CPU hotplug calls into padata with
cpu_hotplug_lock already held, so it should have priority.

Fixes: 6751fb3c0e0c ("padata: Use get_online_cpus/put_online_cpus")
Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 kernel/padata.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/padata.c b/kernel/padata.c
index 5c9bd8df0f0f..cd9ae6822460 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -623,8 +623,8 @@ int padata_set_cpumask(struct padata_instance *pinst, int cpumask_type,
 	struct cpumask *serial_mask, *parallel_mask;
 	int err = -EINVAL;
 
-	mutex_lock(&pinst->lock);
 	get_online_cpus();
+	mutex_lock(&pinst->lock);
 
 	switch (cpumask_type) {
 	case PADATA_CPU_PARALLEL:
@@ -642,8 +642,8 @@ int padata_set_cpumask(struct padata_instance *pinst, int cpumask_type,
 	err =  __padata_set_cpumasks(pinst, parallel_mask, serial_mask);
 
 out:
-	put_online_cpus();
 	mutex_unlock(&pinst->lock);
+	put_online_cpus();
 
 	return err;
 }
-- 
2.23.0

