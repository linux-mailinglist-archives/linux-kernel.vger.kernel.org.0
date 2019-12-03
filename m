Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 116AD10F8B9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 08:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfLCHcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 02:32:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21254 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727386AbfLCHcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 02:32:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575358336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QDZ6zkutNb+UsMTsOrqqbjPx6wHX610gfsQwcSvpFp8=;
        b=JUCKwY0oa/kjOHpIP1/HUQBZx0isquM9YMIVIYT0eJtsgijzWpNkkg6VwKr5dEJauHm+st
        WLL0+YCvYGIe8s6Do6RfacyzBJw3uQxY1niuILfucmbVoL8hTNH7CT04dhhEchVCfk0uWO
        6UpxLLHhrhs2kN1rVd3+EFdNPsb37Gg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-MehOVIs7Oo2YqNwBQWYxaQ-1; Tue, 03 Dec 2019 02:32:15 -0500
Received: by mail-qk1-f199.google.com with SMTP id b9so1609582qkl.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 23:32:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6xKT/ZrBuwY/dROOLKR3Rna6H1BFhaRlBSFPw3pHzCk=;
        b=DSVVcqvIKoR4ry6qG3iweyQWlEDQB+BfBW9Twg6WNS6krBnV0p+fcImLda8dik0DYu
         ooTTR0qFuLlR+9SP3CD+iLwwNCoqhxOkNupoW62S0AzK8mHAZxaLyBuhq840ZLufJJrG
         +LIIU1RYRd88agV9nksMaWWJTt0JRE8cj5ASSYyahVILXApqCpz3Uce/09H9AahiaQxc
         XvGvqmGvNUtfYHe26fkJ28Ey4UOAFVVMGmEcFi+5jUhIkcd8BE+oCaX3PXsuv7P6jfTE
         SDhgaSk438cd0VKeedWajxYmtCOiaBci1HNeHdXD7XaOsK652WJPpUrzP+ejRWMAQDYR
         ZjkQ==
X-Gm-Message-State: APjAAAXr3kgzeyGrCmPXGkCjFC2W4QnVLLUVa+m6LLCtaXCIKsgYRNs6
        /+q7Y3/pv9lim/sOfxgV+wgXtIz9PJQrQCLZNETPL/CF36p4OIKfUXHJZRPkj2JTL6IhK5p+dVP
        mpC8+XEnlJ1EiQmeX7YPUx0+n
X-Received: by 2002:a37:4f83:: with SMTP id d125mr3826270qkb.205.1575358334436;
        Mon, 02 Dec 2019 23:32:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqw9SwwNQE59WdoMcrLUQeGGNOBWpqfUZPXMhfa3nkO1AfEgg7+4frtIMTFsaovZ3lKFFAH+BA==
X-Received: by 2002:a37:4f83:: with SMTP id d125mr3826243qkb.205.1575358334155;
        Mon, 02 Dec 2019 23:32:14 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
        by smtp.gmail.com with ESMTPSA id q126sm1299731qkd.21.2019.12.02.23.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 23:32:13 -0800 (PST)
Date:   Tue, 3 Dec 2019 02:32:10 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH RFC v7 net-next 2/1] mlx4: use new txqueue timeout argument
Message-ID: <20191203072757.429125-1-mst@redhat.com>
References: <20191203071101.427592-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191203071101.427592-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-MC-Unique: MehOVIs7Oo2YqNwBQWYxaQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

untested

 drivers/net/ethernet/mellanox/mlx4/en_netdev.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c b/drivers/net/e=
thernet/mellanox/mlx4/en_netdev.c
index d2728933d420..3bcf5f682af5 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
@@ -1363,15 +1363,9 @@ static void mlx4_en_tx_timeout(struct net_device *de=
v, unsigned int txqueue)
 =09if (netif_msg_timer(priv))
 =09=09en_warn(priv, "Tx timeout called on port:%d\n", priv->port);
=20
-=09for (i =3D 0; i < priv->tx_ring_num[TX]; i++) {
-=09=09struct mlx4_en_tx_ring *tx_ring =3D priv->tx_ring[TX][i];
-
-=09=09if (!netif_tx_queue_stopped(netdev_get_tx_queue(dev, i)))
-=09=09=09continue;
-=09=09en_warn(priv, "TX timeout on queue: %d, QP: 0x%x, CQ: 0x%x, Cons: 0x=
%x, Prod: 0x%x\n",
-=09=09=09i, tx_ring->qpn, tx_ring->sp_cqn,
-=09=09=09tx_ring->cons, tx_ring->prod);
-=09}
+=09en_warn(priv, "TX timeout on queue: %d, QP: 0x%x, CQ: 0x%x, Cons: 0x%x,=
 Prod: 0x%x\n",
+=09=09txqueue, tx_ring->qpn, tx_ring->sp_cqn,
+=09=09tx_ring->cons, tx_ring->prod);
=20
 =09priv->port_stats.tx_timeout++;
 =09en_dbg(DRV, priv, "Scheduling watchdog\n");
--=20
MST

