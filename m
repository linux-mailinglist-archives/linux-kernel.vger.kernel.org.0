Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5432911B7C3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 17:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388826AbfLKQKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 11:10:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:35176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731038AbfLKQKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 11:10:02 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6E7D20836;
        Wed, 11 Dec 2019 16:10:00 +0000 (UTC)
Date:   Wed, 11 Dec 2019 11:09:59 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sven Schnelle <svens@stackframe.org>
Cc:     linux-trace-devel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: ftrace histogram sorting broken on BE architecures
Message-ID: <20191211110959.2baeb70f@gandalf.local.home>
In-Reply-To: <20191211103557.7bed6928@gandalf.local.home>
References: <20191211123316.GD12147@stackframe.org>
        <20191211103557.7bed6928@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Dec 2019 10:35:57 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> > Any thoughts on how to fix this? I'm not sure whether i fully understand the
> > ftrace maps... ;-)  
> 
> Your analysis makes sense. I'll take a deeper look at it.

Sven,

Does this patch fix it for you?

Tom,

Correct me if I'm wrong, from what I can tell, all sums and keys are
u64 unless they are a string. Thus, I believe this patch should not
have any issues.

-- Steve

diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
index 9a1c22310323..9e31bfc818ff 100644
--- a/kernel/trace/tracing_map.c
+++ b/kernel/trace/tracing_map.c
@@ -148,8 +148,8 @@ static int tracing_map_cmp_atomic64(void *val_a, void *val_b)
 #define DEFINE_TRACING_MAP_CMP_FN(type)					\
 static int tracing_map_cmp_##type(void *val_a, void *val_b)		\
 {									\
-	type a = *(type *)val_a;					\
-	type b = *(type *)val_b;					\
+	type a = (type)(*(u64 *)val_a);					\
+	type b = (type)(*(u64 *)val_b);					\
 									\
 	return (a > b) ? 1 : ((a < b) ? -1 : 0);			\
 }
