Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03BB6D2A68
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 15:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387787AbfJJNJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Oct 2019 09:09:55 -0400
Received: from sender2-of-o52.zoho.com.cn ([163.53.93.247]:21371 "EHLO
        sender2-of-o52.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733300AbfJJNJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 09:09:54 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1570712984; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=dzGVLNhlQAnkvoMVmwtwDTLhfVl3fNxwl/hucMMHVdpQdvPMrOnsGX5DnN1g6nwErnOEuxWSMQBJCVEQgD3Nq7ps2NLvyf+c3369iklBE07FZuepYCfDjwOJm0IDvQK4FhwdQxHzZlqbzHd95bc1KUZWsdnEJlJCDKtj2bx2w5Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1570712984; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=2dzT5h3IL4cdmj7rE2OhK8O7CRAGjGXyu7ncyaConKU=; 
        b=RapY3WVi7TrcfZC/tcod6rbaCHzI4aAXINnuQEjVPtHECviQDxNNgZqkWciV4U13O/6H0dUMqJN2bLmJbskdPCjedy5CknsrH4NE+3d+UqSkK/Yi1wjyXIJU7ElvT+4MVnmOqDJyFY6veuLWy8Y3cHJwQww8LcYhMq9xRU0JNy0=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1570712984;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        l=721; bh=2dzT5h3IL4cdmj7rE2OhK8O7CRAGjGXyu7ncyaConKU=;
        b=gnmox6pBuhF3ooMdlANhu/u+sENwM3lPQPApz5sIGVofSvtscyM6pxeEc0FBp2Ls
        Kri59jahWq6u+uSHxXBFoBZd8jONt+mwNFrvk9wxEOtsAQ2H1nE2GDm4R9xsHy6oabb
        XXsElXXPjeooHdKTfdRycAlGIlr1FzzDS1dcRK+8=
Received: from localhost.localdomain (113.88.133.79 [113.88.133.79]) by mx.zoho.com.cn
        with SMTPS id 1570712980468688.636944062762; Thu, 10 Oct 2019 21:09:40 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     jack@suse.com
Cc:     linux-kernel@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20191010130924.17697-1-cgxu519@mykernel.net>
Subject: [PATCH] quota: minor code cleanup for v1_format_ops
Date:   Thu, 10 Oct 2019 21:09:24 +0800
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's not a functinal change, it's just for keeping
consistent coding style.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/quota/quota_v1.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/quota/quota_v1.c b/fs/quota/quota_v1.c
index c740e5572eb8..cd92e5fa0062 100644
--- a/fs/quota/quota_v1.c
+++ b/fs/quota/quota_v1.c
@@ -217,7 +217,6 @@ static const struct quota_format_ops v1_format_ops =3D =
{
 =09.check_quota_file=09=3D v1_check_quota_file,
 =09.read_file_info=09=09=3D v1_read_file_info,
 =09.write_file_info=09=3D v1_write_file_info,
-=09.free_file_info=09=09=3D NULL,
 =09.read_dqblk=09=09=3D v1_read_dqblk,
 =09.commit_dqblk=09=09=3D v1_commit_dqblk,
 };
--=20
2.21.0



