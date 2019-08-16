Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB6DD90017
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 12:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfHPKgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 06:36:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45038 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbfHPKgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 06:36:33 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 60EB7308A958;
        Fri, 16 Aug 2019 10:36:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-255.rdu2.redhat.com [10.10.120.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E9E62100195F;
        Fri, 16 Aug 2019 10:36:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <d98d1f0150bec8b69a886f77fc375b8ca9d24262.camel@perches.com>
References: <d98d1f0150bec8b69a886f77fc375b8ca9d24262.camel@perches.com> <e77b0f32a2ce97c872eede52c88b84aa78094ae5.1565836130.git.joe@perches.com> <12308.1565876416@warthog.procyon.org.uk>
To:     Joe Perches <joe@perches.com>
Cc:     dhowells@redhat.com, Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Huckleberry <nhuck@google.com>,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs: Move comments after /* fallthrough */
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <13105.1565951791.1@warthog.procyon.org.uk>
Date:   Fri, 16 Aug 2019 11:36:31 +0100
Message-ID: <13106.1565951791@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Fri, 16 Aug 2019 10:36:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Perches <joe@perches.com> wrote:

> Here the script would not convert the /* Fall through */
> because the next non-blank line does not start with
> case or default

Convert the "/* Fall through */" to what?

You said "for a script to appropriately convert case statement blocks with /*
fallthrough */ comments to a macro".  Can you give an example of what the code
would look like with this macro emplaced?

David
