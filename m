Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 260F8D3A6B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 09:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfJKHym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 03:54:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48078 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbfJKHym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 03:54:42 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5285518C8902;
        Fri, 11 Oct 2019 07:54:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-84.rdu2.redhat.com [10.10.121.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A488C4521;
        Fri, 11 Oct 2019 07:54:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <32afa048-0b12-ce26-2bb0-7672dca8ffb8@infradead.org>
References: <32afa048-0b12-ce26-2bb0-7672dca8ffb8@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     dhowells@redhat.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] samples: watch_queue: depends on HEADERS_INSTALL
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6436.1570780480.1@warthog.procyon.org.uk>
Date:   Fri, 11 Oct 2019 08:54:40 +0100
Message-ID: <6438.1570780480@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.70]); Fri, 11 Oct 2019 07:54:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've folded in this patch.

David
