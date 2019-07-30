Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 423827AEB0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 19:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbfG3Q6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 12:58:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37626 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727297AbfG3Q6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 12:58:05 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4C3F930A7C6E;
        Tue, 30 Jul 2019 16:58:05 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 898415D6A7;
        Tue, 30 Jul 2019 16:58:03 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 30 Jul 2019 18:58:04 +0200 (CEST)
Date:   Tue, 30 Jul 2019 18:58:02 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, matthew.wilcox@oracle.com,
        kirill.shutemov@linux.intel.com, kernel-team@fb.com,
        william.kucharski@oracle.com, srikar@linux.vnet.ibm.com
Subject: Re: [PATCH v10 2/4] uprobe: use original page when all uprobes are
 removed
Message-ID: <20190730165801.GF18501@redhat.com>
References: <20190730052305.3672336-1-songliubraving@fb.com>
 <20190730052305.3672336-3-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730052305.3672336-3-songliubraving@fb.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 30 Jul 2019 16:58:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/29, Song Liu wrote:
>
> This patch allows uprobe to use original page when possible (all uprobes
> on the page are already removed).

Again, the changelog is not 100% accurate. all uprobes removed _and_
the original page is in page cache and uptodate.

Otherwise looks correct...

Oleg.

