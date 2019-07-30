Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE247B320
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 21:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbfG3TSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 15:18:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43324 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfG3TSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 15:18:09 -0400
Received: from X1 (unknown [76.191.170.112])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C324932A5;
        Tue, 30 Jul 2019 19:18:03 +0000 (UTC)
Date:   Tue, 30 Jul 2019 12:17:59 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <matthew.wilcox@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        William Kucharski <william.kucharski@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: + uprobe-use-original-page-when-all-uprobes-are-removed.patch
 added to -mm tree
Message-Id: <20190730121759.41b4ddf25eb887fafa27fb28@linux-foundation.org>
In-Reply-To: <40C3ABEE-B1D1-445B-9637-A2BD5ED9C316@fb.com>
References: <20190726230333.drvM6x-wz%akpm@linux-foundation.org>
        <20190729150539.GB11349@redhat.com>
        <40C3ABEE-B1D1-445B-9637-A2BD5ED9C316@fb.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jul 2019 17:04:05 +0000 Song Liu <songliubraving@fb.com> wrote:

> > this assumes that __replace_page() can't fail, but it can. I think you
> > should move this into into __replace_page().
> 
> Good catch! Let me fix it. 
> 
> Hi Andrew,
> 
> Do you prefer a whole v10 (1/4 to 4/4) or just newer version of this 
> one (2/4)?

Either is OK.  I guess just a new 2/4 is sufficient, if the difference
is minor.

