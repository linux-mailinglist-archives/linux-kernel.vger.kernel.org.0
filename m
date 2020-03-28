Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC56196753
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Mar 2020 17:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgC1QbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Mar 2020 12:31:21 -0400
Received: from sender4-op-o14.zoho.com ([136.143.188.14]:17477 "EHLO
        sender4-op-o14.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbgC1QbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 12:31:20 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1585413070; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=WibfFDlX9nNQavD9Vuze/fsJ6LfffxjGVsCGCYjcAZnESnGnzbKcgTt/pca8rr/juDlkQVBkfTKETXhhML0FAnAX0/YOswPs/BoLngbJ86SszFcLW/95EY23MM+oQpA1TKhjXSwEhYYhK5fjmGdSHyGOxkB3QAJGoBHCzSiXuws=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1585413070; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=lv58KTHttKhkSKHvO90o6T1u6Q/s85Jk79hT6tors5g=; 
        b=MkLXwWvLe1aWnvj/YxE8QRv949vtk2vtVXa2R7Ad5LtQ8uWDMrdv1Mi7KIWDZlmZ5pmmMklvs1P4bF3x/aP5hxZyehVWcGh3fBgFZa2pQEHLufr5hf1NZ6ZyXQCoOz/UYxhuZz/75Qn6ZnZAZr4zaGjhhNirtU41sY0oD5Sx2m0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=hurranet.com;
        spf=pass  smtp.mailfrom=aiman.najjar@hurranet.com;
        dmarc=pass header.from=<aiman.najjar@hurranet.com> header.from=<aiman.najjar@hurranet.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1585413070;
        s=zoho; d=hurranet.com; i=aiman.najjar@hurranet.com;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=lv58KTHttKhkSKHvO90o6T1u6Q/s85Jk79hT6tors5g=;
        b=gmw8p687FaxOkKwaP8OBJRJApMU23CeCvp3gyZMzeP8cSJ3182z+eP/tC9UZ3tBd
        6EIdM1oJX/NMTk5mJNQB6QdxkS0acvL+ko/Q/A7/qw8AAIvJxJV0cL5cxIz6HoggGWW
        wxHxO76pDDzUAvHUg2Sz7/OzXMztr+SE6PlMeXtg=
Received: from kernel-dev (097-100-022-132.res.spectrum.com [97.100.22.132]) by mx.zohomail.com
        with SMTPS id 1585413067764270.18101230636637; Sat, 28 Mar 2020 09:31:07 -0700 (PDT)
From:   aimannajjar <aiman.najjar@hurranet.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     aimannajjar <aiman.najjar@hurranet.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Message-ID: <afcc551421d4642f2d5585dba1d87ee76bf63ab0.1585353747.git.aiman.najjar@hurranet.com>
Subject: [PATCH v2 2/5] staging: rtl8712: fix long-line checkpatch warning
Date:   Fri, 27 Mar 2020 20:08:08 -0400
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1585353747.git.aiman.najjar@hurranet.com>
References: <20200327080429.GB1627562@kroah.com> <cover.1585353747.git.aiman.najjar@hurranet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following warning in rtl871x_xmit.c:

WARNING: line over 80 characters
130: FILE: drivers/staging//rtl8712/rtl871x_xmit.c:130:
+=09=09pxmitbuf->pallocated_buf =3D kmalloc(MAX_XMITBUF_SZ + XMITBUF_ALIGN_=
SZ,

Signed-off-by: aimannajjar <aiman.najjar@hurranet.com>
---
 drivers/staging/rtl8712/rtl871x_xmit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_xmit.c b/drivers/staging/rtl87=
12/rtl871x_xmit.c
index 628e4bad1547..454c26f83406 100644
--- a/drivers/staging/rtl8712/rtl871x_xmit.c
+++ b/drivers/staging/rtl8712/rtl871x_xmit.c
@@ -127,8 +127,8 @@ int _r8712_init_xmit_priv(struct xmit_priv *pxmitpriv,
 =09pxmitbuf =3D (struct xmit_buf *)pxmitpriv->pxmitbuf;
 =09for (i =3D 0; i < NR_XMITBUFF; i++) {
 =09=09INIT_LIST_HEAD(&pxmitbuf->list);
-=09=09pxmitbuf->pallocated_buf =3D kmalloc(MAX_XMITBUF_SZ + XMITBUF_ALIGN_=
SZ,
-=09=09=09=09=09=09   GFP_ATOMIC);
+=09=09pxmitbuf->pallocated_buf =3D
+=09=09=09kmalloc(MAX_XMITBUF_SZ + XMITBUF_ALIGN_SZ, GFP_ATOMIC);
 =09=09if (!pxmitbuf->pallocated_buf)
 =09=09=09return -ENOMEM;
 =09=09pxmitbuf->pbuf =3D pxmitbuf->pallocated_buf + XMITBUF_ALIGN_SZ -
--=20
2.20.1


