Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFAA7CC183
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 19:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbfJDRUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 13:20:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39044 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729291AbfJDRUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 13:20:23 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C1CAD1801758;
        Fri,  4 Oct 2019 17:20:23 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 630929F7A;
        Fri,  4 Oct 2019 17:20:23 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 492E21808876;
        Fri,  4 Oct 2019 17:20:23 +0000 (UTC)
Date:   Fri, 4 Oct 2019 13:20:23 -0400 (EDT)
From:   Bob Peterson <rpeterso@redhat.com>
To:     Andrew Price <anprice@redhat.com>
Cc:     cluster-devel@redhat.com,
        syzbot+c2fdfd2b783754878fb6@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Message-ID: <824921067.4882112.1570209623167.JavaMail.zimbra@redhat.com>
In-Reply-To: <20191003153552.2015-1-anprice@redhat.com>
References: <000000000000afc1b40593f68888@google.com> <20191003153552.2015-1-anprice@redhat.com>
Subject: Re: [Cluster-devel] [PATCH] gfs2: Fix memory leak when gfs2meta's
        fs_context is freed
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.3.116.219, 10.4.195.10]
Thread-Topic: gfs2: Fix memory leak when gfs2meta's fs_context is freed
Thread-Index: Ei86TZNaiDR88EYSEPqE/xTVbulYpQ==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.62]); Fri, 04 Oct 2019 17:20:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
> gfs2 and gfs2meta share an ->init_fs_context function which allocates an
> args structure stored in fc->fs_private. gfs2 registers a ->free
> function to free this memory when the fs_context is cleaned up, but
> there was not one registered for gfs2meta, causing a leak.
> 
> Register a ->free function for gfs2meta. The existing gfs2_fc_free
> function does what we need.
> 
> Reported-by: syzbot+c2fdfd2b783754878fb6@syzkaller.appspotmail.com
> Signed-off-by: Andrew Price <anprice@redhat.com>
> ---

Thanks. Now pushed to for-next.

Bob Peterson
