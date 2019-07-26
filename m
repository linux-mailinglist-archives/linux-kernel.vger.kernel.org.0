Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B29F876EAB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 18:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfGZQNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 12:13:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:37458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726705AbfGZQNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 12:13:19 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC52D218DA;
        Fri, 26 Jul 2019 16:13:18 +0000 (UTC)
Date:   Fri, 26 Jul 2019 12:13:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Matt Helsley <mhelsley@vmware.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 08/13] recordmcount: Clarify what cleanup() does
Message-ID: <20190726121317.169d3ab0@gandalf.local.home>
In-Reply-To: <bf4508b8f5c191473d9f7476f1361e61dd2ae0eb.1563992889.git.mhelsley@vmware.com>
References: <cover.1563992889.git.mhelsley@vmware.com>
        <bf4508b8f5c191473d9f7476f1361e61dd2ae0eb.1563992889.git.mhelsley@vmware.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jul 2019 14:05:02 -0700
Matt Helsley <mhelsley@vmware.com> wrote:

> @@ -436,10 +451,11 @@ static void MIPS64_r_info(Elf64_Rel *const rp, unsigned sym, unsigned type)
>  
>  static int do_file(char const *const fname)
>  {
> -	Elf32_Ehdr *const ehdr = mmap_file(fname);
> +	Elf32_Ehdr *ehdr;
>  	unsigned int reltype = 0;
>  	int rc = -1;
>  

On small nit that I'm going to tweak, is the ordering of the
declarations above. By removing the const and the assignment, you lost
the "upside-down x-mas tree" look of the declaration.

That is, we went from:

static int do_file(char const *const fname)
{
	Elf32_Ehdr *const ehdr = mmap_file(fname);
	unsigned int reltype = 0;
	int rc = -1;

to:

static int do_file(char const *const fname)
{
	Elf32_Ehdr *ehdr;
	unsigned int reltype = 0;
	int rc = -1;


Which, I'll change to:

static int do_file(char const *const fname)
{
	unsigned int reltype = 0;
	Elf32_Ehdr *ehdr;
	int rc = -1;

-- Steve
