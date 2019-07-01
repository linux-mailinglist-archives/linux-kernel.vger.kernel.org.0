Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5441B249DF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 10:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfEUIK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 04:10:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49956 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbfEUIK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 04:10:59 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B8357307D866;
        Tue, 21 May 2019 08:10:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-170.rdu2.redhat.com [10.10.120.170])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F4596103B;
        Tue, 21 May 2019 08:10:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190521093743.5afaaadf@canb.auug.org.au>
References: <20190521093743.5afaaadf@canb.auug.org.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     dhowells@redhat.com,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Kukjin Kim <kgene.kim@samsung.com>,
        Rich Felker <dalias@libc.org>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jiri Kosina <jikos@kernel.org>,
        "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
        Bart Van Assche <bart.vanassche@gmail.com>
Subject: Re: linux-next: removed trees
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <16206.1558426250.1@warthog.procyon.org.uk>
Date:   Tue, 21 May 2019 09:10:50 +0100
Message-ID: <16207.1558426250@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 21 May 2019 08:10:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> init_task

Yeah - that went upstream, thanks.

David
