Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0A12FF9E8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2019 14:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfKQNgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Nov 2019 08:36:24 -0500
Received: from sender3-of-o52.zoho.com.cn ([124.251.121.247]:21947 "EHLO
        sender2.zoho.com.cn" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726037AbfKQNgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 08:36:24 -0500
X-Greylist: delayed 918 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Nov 2019 08:36:06 EST
ARC-Seal: i=1; a=rsa-sha256; t=1573996834; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=gA3utkj4m2vuOiQTTK0cNW72xnBOOzoUujRHi6BnJTkBehIP9Lm4IEBh/60ilaYy3Ni9jOvdLNeC3BEGurID9QaT0mojPUFZ+H0iPqBffBKF/2lzyXtJLoFTEdWlpbCx69MEWqBdeOgQpsOb13mpXd2BiVsfMD8qKz5SG8bjBpY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1573996834; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=bbpR7jOn1tWkOik0+7zAOlYex1xS4WFEXsmnmFvAWdM=; 
        b=fTujq2cDWnhR6N1o4/GnSQHy2AQBZEYkaOxjZyjMar8kuswJ4BcUpRAgBAD+Ghc+NchZG790iJx1NRSxWoZlVeIVyF27f91baJCgbU/g82BFWINR95mFImSIK01ssY1nwM9Eu0HuOy9u7XYkopKik4nDAlsARydEqJBjs/qSQmI=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1573996834;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        l=1041; bh=bbpR7jOn1tWkOik0+7zAOlYex1xS4WFEXsmnmFvAWdM=;
        b=a6ST8dJZeoCSSHgVMx4KdtjwQZE9LiVeog9uG5y9vrQf8Cf9OvBagq5KB2WyyDOo
        41qUey/EFhsUtVBmokHXXvG7xTX4pUdtpfzlq2/D3SDLyzmWTtdWH2ugwHm+3mNVXxz
        Hkz85JIt9VRN745mztCJj8VlddReLmhsto+t6Oz8=
Received: from localhost.localdomain (113.116.50.122 [113.116.50.122]) by mx.zoho.com.cn
        with SMTPS id 1573996831319973.1883777334837; Sun, 17 Nov 2019 21:20:31 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     jack@suse.com
Cc:     linux-kernel@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20191117132028.19564-1-cgxu519@mykernel.net>
Subject: [PATCH] quota: remove unnecessary check in dquot_add_inodes() and dquot_add_space()
Date:   Sun, 17 Nov 2019 21:20:28 +0800
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After passed grace time we treat softlimit as hardlimit,
so we don't have to compare desire usage with softlimit
in this place.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/quota/dquot.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 6e826b454082..97740077afac 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -1283,7 +1283,6 @@ static int dquot_add_inodes(struct dquot *dquot, qsiz=
e_t inodes,
 =09}
=20
 =09if (dquot->dq_dqb.dqb_isoftlimit &&
-=09    newinodes > dquot->dq_dqb.dqb_isoftlimit &&
 =09    dquot->dq_dqb.dqb_itime &&
 =09    ktime_get_real_seconds() >=3D dquot->dq_dqb.dqb_itime &&
             !ignore_hardlimit(dquot)) {
@@ -1333,7 +1332,6 @@ static int dquot_add_space(struct dquot *dquot, qsize=
_t space,
 =09}
=20
 =09if (dquot->dq_dqb.dqb_bsoftlimit &&
-=09    tspace > dquot->dq_dqb.dqb_bsoftlimit &&
 =09    dquot->dq_dqb.dqb_btime &&
 =09    ktime_get_real_seconds() >=3D dquot->dq_dqb.dqb_btime &&
             !ignore_hardlimit(dquot)) {
--=20
2.21.0



