Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F41A7355C9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2019 06:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfFEEOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jun 2019 00:14:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbfFEEOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 00:14:19 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AA582083E;
        Wed,  5 Jun 2019 04:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559708058;
        bh=edj9xHB7N4qyQuNAjukxlep6ykAdTpTJSbDVobW9eyE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2YKq0Ebk1+cB6qr58E9NAgemhGn6EHb0HDouxp1tY+7raXsMRSeotQrm+P5lIPs1v
         L6mN1jBg0wqjF15WZC+qr2bLNQOb6kr4HaRV+v0csG/ttAlC9TpwLb3UFcUAR0mm1f
         QiE+/S8AFSkUzLizIkatXvaSNq3NKDwY8kGiTTn8=
Date:   Tue, 4 Jun 2019 21:14:18 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v6 00/10] mm: reparent slab memory on cgroup removal
Message-Id: <20190604211418.70d178253550d96da46cee21@linux-foundation.org>
In-Reply-To: <20190605024454.1393507-1-guro@fb.com>
References: <20190605024454.1393507-1-guro@fb.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jun 2019 19:44:44 -0700 Roman Gushchin <guro@fb.com> wrote:

> So instead of trying to find a maybe non-existing balance, let's do reparent
> the accounted slabs to the parent cgroup on cgroup removal.

s/slabs/slab caches/.  Take more care with the terminology, please...

> There is a bonus: currently we do release empty kmem_caches on cgroup
> removal, however all other are waiting for the releasing of the memory cgroup.
> These refactorings allow kmem_caches to be released as soon as they
> become inactive and free.

Unclear.

s/All other/releasing of all non-empty slab caches depends upon the releasing/

I think?
