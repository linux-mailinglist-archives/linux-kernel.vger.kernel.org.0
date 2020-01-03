Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5321B12FAC9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jan 2020 17:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgACQsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jan 2020 11:48:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:35078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727912AbgACQsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 11:48:31 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 214C62072C;
        Fri,  3 Jan 2020 16:48:30 +0000 (UTC)
Date:   Fri, 3 Jan 2020 11:48:28 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, saiprakash.ranjan@codeaurora.org,
        nachukannan@gmail.com, rdunlap@infradead.org
Subject: Re: [PATCH v3 0/3] docs: ftrace: Fix minor issues in the doc
Message-ID: <20200103114828.15581051@gandalf.local.home>
In-Reply-To: <cover.1577231751.git.frank@generalsoftwareinc.com>
References: <cover.1577231751.git.frank@generalsoftwareinc.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Dec 2019 19:05:38 -0500
"Frank A. Cancio Bello" <frank@generalsoftwareinc.com> wrote:

> I didn't want to be pushy with these minor fixes but occur to me
> now that, even all seem to be clear in the latest version of the
> RFC (v2) related to these fixes, a clean patchset could be expected
> after such RFC. So here we go:
> 
> Clarifies the RAM footprint of buffer_size_kb without getting into
> implementation details.
> 
> Fix typos and a small notation mistakes in the doc.
> 

Jon,

Can you take these in your tree?

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Thanks!

-- Steve
