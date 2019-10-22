Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45AD7E0E52
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 00:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733049AbfJVWoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 18:44:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:56428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731850AbfJVWoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 18:44:01 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B27B2084C;
        Tue, 22 Oct 2019 22:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571784239;
        bh=s6jIaDy6L8w46Wpyk5SR+8mifFro7PId0+D18ldD7mY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AoD4+JQ5VH5btT9ZL6/jrLNahb9N/Tjnv29pjX6mJpMxwJ1sHfyPDFTACCWXBaJEV
         W+JRzve4gQ8Tl393GA6ujKrgIkCBuUm3qo2wiCF13xkXgXowJxTltO0NAh8DVi37nH
         KAmMWJhSYMVM6oIn7ZFCwRSkmVvYljGSsVL+O5i0=
Date:   Tue, 22 Oct 2019 15:43:58 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>, 1vier1@web.de,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/5] ipc/mqueue.c: Remove duplicated code
Message-Id: <20191022154358.a99d7d3f972c72d74399b4ed@linux-foundation.org>
In-Reply-To: <20191020123305.14715-3-manfred@colorfullife.com>
References: <20191020123305.14715-1-manfred@colorfullife.com>
        <20191020123305.14715-3-manfred@colorfullife.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Oct 2019 14:33:02 +0200 Manfred Spraul <manfred@colorfullife.com> wrote:

> Patch from Davidlohr, I just added this change log.
> pipelined_send() and pipelined_receive() are identical, so merge them.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Manfred Spraul <manfred@colorfullife.com>

I redid the changelog as below:

From: Davidlohr Bueso <dave@stgolabs.net>
Subject: ipc/mqueue.c: remove duplicated code

pipelined_send() and pipelined_receive() are identical, so merge them.

[manfred@colorfullife.com: add changelog]
Link: http://lkml.kernel.org/r/20191020123305.14715-3-manfred@colorfullife.com
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Manfred Spraul <manfred@colorfullife.com>


