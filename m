Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDDA57217
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 21:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbfFZT7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 15:59:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39468 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbfFZT7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 15:59:39 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CD6CDC05678B;
        Wed, 26 Jun 2019 19:59:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-57.rdu2.redhat.com [10.10.120.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A1827600CC;
        Wed, 26 Jun 2019 19:59:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <1d868a7a-0a15-e2b1-d73b-13d9229855ad@infradead.org>
References: <1d868a7a-0a15-e2b1-d73b-13d9229855ad@infradead.org> <20190626231617.1e858da3@canb.auug.org.au>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     dhowells@redhat.com, Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Jun 26 (task_struct: cached_requested_key)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <13369.1561579172.1@warthog.procyon.org.uk>
Date:   Wed, 26 Jun 2019 20:59:32 +0100
Message-ID: <13370.1561579172@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 26 Jun 2019 19:59:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> wrote:

> Multiple build errors like this when CONFIG_KEYS is not set/enabled:
> (this was seen on one i386 build)

Ah - I forgot to make CONFIG_KEYS_REQUEST_CACHE depend on CONFIG_KEYS.

David
