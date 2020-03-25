Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF2419254B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 11:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbgCYKUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 06:20:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:54106 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726154AbgCYKUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 06:20:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2525BAC19;
        Wed, 25 Mar 2020 10:20:32 +0000 (UTC)
Date:   Wed, 25 Mar 2020 11:20:31 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     tglx@linutronix.de, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org,
        brgerst@gmail.com
Subject: Re: [PATCH v3 10/26] objtool: Optimize find_symbol_*() and
 read_symbols()
In-Reply-To: <20200324160924.499016559@infradead.org>
Message-ID: <alpine.LSU.2.21.2003251120160.12098@pobox.suse.cz>
References: <20200324153113.098167666@infradead.org> <20200324160924.499016559@infradead.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Mar 2020, Peter Zijlstra wrote:

> All of:
> 
>   read_symbols(), find_symbol_by_offset(), find_symbol_containing(),
>   find_containing_func()
> 
> do a linear search of the symbols. Add an RB tree to make it go
> faster.
> 
> This about halves objtool runtime on vmlinux.o, from 34s to 18s.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M
