Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 308A0774C6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2019 01:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbfGZXCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 19:02:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:56770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbfGZXCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 19:02:41 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F11A921994;
        Fri, 26 Jul 2019 23:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564182160;
        bh=uog7xDvm2Trfq+568RxA/iEycB6CRRejnXbrvr8BSdY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2UhTedPZgajbGffiDMPEjqh9WvdDSCfJpTpcwge1EckBFQeXPRAAOUE224YbTQlOS
         m3Y7UOcKHobcI4Ihfus2az9muFpUFcpJhLNy22x+4J/gwhKkUZ5lPIp+dPpJjz1Fgv
         rlMlOoGOJE83ZjTF3wGfOM25M+WcnUIekcZo6eTw=
Date:   Fri, 26 Jul 2019 16:02:39 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <matthew.wilcox@oracle.com>, <kirill.shutemov@linux.intel.com>,
        <peterz@infradead.org>, <oleg@redhat.com>, <rostedt@goodmis.org>,
        <kernel-team@fb.com>, <william.kucharski@oracle.com>,
        <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH v9 4/4] uprobe: use FOLL_SPLIT_PMD instead of FOLL_SPLIT
Message-Id: <20190726160239.68f538a79913df343308b473@linux-foundation.org>
In-Reply-To: <20190726054654.1623433-5-songliubraving@fb.com>
References: <20190726054654.1623433-1-songliubraving@fb.com>
        <20190726054654.1623433-5-songliubraving@fb.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jul 2019 22:46:54 -0700 Song Liu <songliubraving@fb.com> wrote:

> This patches uses newly added FOLL_SPLIT_PMD in uprobe. This enables easy
> regroup of huge pmd after the uprobe is disabled (in next patch).

Confused.  There is no "next patch".
