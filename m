Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75583105B38
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 21:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfKUUif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 15:38:35 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26093 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726546AbfKUUif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 15:38:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574368714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q5xmbM7S9oTnc1i2DG5ScuBudhWd8zh5E/mOB6XLuO4=;
        b=FoTRNgJzKDLp0eH6EpldJp9BgZhxHYbIQ7Fj//xtulU3kwHWLviC3nuBo8NTV/j8f+207i
        7vdKzBkZ38U8U9KhLQLIG587Beg5xS23heqP8MkU9B3aqVfGvnCcNzYDA6yAMhGIb+RABN
        AsVMDkw07sJ0e06xhLQpS2ZX5NT8i/g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-uHAReWEoMmWa0K7WY-ucGg-1; Thu, 21 Nov 2019 15:38:32 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28CA8107ACC4;
        Thu, 21 Nov 2019 20:38:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-161.rdu2.redhat.com [10.10.120.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3B552100EBAC;
        Thu, 21 Nov 2019 20:38:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20191122072307.000b6492@canb.auug.org.au>
References: <20191122072307.000b6492@canb.auug.org.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     dhowells@redhat.com,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commits in the afs tree
MIME-Version: 1.0
Content-ID: <9440.1574368709.1@warthog.procyon.org.uk>
Date:   Thu, 21 Nov 2019 20:38:29 +0000
Message-ID: <9441.1574368709@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: uHAReWEoMmWa0K7WY-ucGg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> wrote:

>   297c6f6378a6 ("afs: Remove set but not used variable 'ret'")
>   b264b5bc97c2 ("afs: Remove set but not used variables 'before', 'after'=
")
>   b850554983e6 ("afs: xattr: use scnprintf")

I've signed them off, retagged and repushed.

David

