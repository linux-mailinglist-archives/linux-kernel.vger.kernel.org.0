Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02BAD14A32F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jan 2020 12:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbgA0LoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 06:44:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37174 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726210AbgA0LoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 06:44:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580125456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sUtieaM6GD2PpqnJW9FIIx3PImpT0oW9u9OtwSX9XIA=;
        b=QaXmIyLjhuil/6diU+4737S1IPW/lGtx8LDMY5QUVeUhByDLuX4vasZKOhQIbt8IpxqFTF
        ur94XbRDEOMHW5kkTYBLsLJjCjfO0f+bCsmV68Rw/zrf6nKVXpeXWkUIG0jigQk3aL/1i+
        C00j/yA4Qm5yf0rFsj2qf2U9OteI8I0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-foaiDgyzN-uZrsXuUKjA4Q-1; Mon, 27 Jan 2020 06:44:12 -0500
X-MC-Unique: foaiDgyzN-uZrsXuUKjA4Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9756B800EBB;
        Mon, 27 Jan 2020 11:44:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-99.rdu2.redhat.com [10.10.120.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F919451F;
        Mon, 27 Jan 2020 11:44:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200122081340.2bhx5jfezl55b3qb@kili.mountain>
References: <20200122081340.2bhx5jfezl55b3qb@kili.mountain> <000000000000da7a79059caf2656@google.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     dhowells@redhat.com,
        syzbot <syzbot+b904ba7c947a37b4b291@syzkaller.appspotmail.com>,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: WARNING in __proc_create (2)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1452048.1580125449.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 27 Jan 2020 11:44:09 +0000
Message-ID: <1452049.1580125449@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> wrote:

> We should probably ban '/' characters from the cell name in
> afs_alloc_cell().

Sorry, I forgot to cc you on the patch.  It's now upstream:

	https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Da45ea48e2bcd92c1f678b794f488ca0bda9835b8

David

