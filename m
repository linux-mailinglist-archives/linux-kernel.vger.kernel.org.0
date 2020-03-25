Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26AE8192310
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 09:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbgCYIo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 04:44:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:32794 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726658AbgCYIo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 04:44:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 77F06AFD4;
        Wed, 25 Mar 2020 08:44:57 +0000 (UTC)
Date:   Wed, 25 Mar 2020 09:44:56 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     tglx@linutronix.de, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org,
        brgerst@gmail.com
Subject: Re: [PATCH v3 03/26] objtool: Rename func_for_each_insn_all()
In-Reply-To: <20200324160924.083720147@infradead.org>
Message-ID: <alpine.LSU.2.21.2003250944430.12098@pobox.suse.cz>
References: <20200324153113.098167666@infradead.org> <20200324160924.083720147@infradead.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Mar 2020, Peter Zijlstra wrote:

> Now that func_for_each_insn() is available, rename
> func_for_each_insn_all(). This gets us:
> 
>   sym_for_each_insn()  - iterate on symbol offset/len
>   func_for_each_insn() - iterate on insn->func
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M
