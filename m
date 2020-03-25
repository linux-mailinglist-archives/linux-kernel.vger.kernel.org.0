Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E253E19230F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 09:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbgCYIno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 04:43:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:60568 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbgCYIno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 04:43:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 10FAEAFB8;
        Wed, 25 Mar 2020 08:43:43 +0000 (UTC)
Date:   Wed, 25 Mar 2020 09:43:41 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     tglx@linutronix.de, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org,
        brgerst@gmail.com
Subject: Re: [PATCH v3 02/26] objtool: Rename func_for_each_insn()
In-Reply-To: <20200324160924.024341229@infradead.org>
Message-ID: <alpine.LSU.2.21.2003250942370.12098@pobox.suse.cz>
References: <20200324153113.098167666@infradead.org> <20200324160924.024341229@infradead.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Mar 2020, Peter Zijlstra wrote:

> There is func_for_each_insn() and func_for_each_insn_all(), the both
> iterate the instructions, but the first uses symbol offset/length
> while the second uses insn->func.
> 
> Rename func_for_each_insn() to sym_for_eac_insn() because it iterates

I did not notice before, but there is a typo

s/sym_for_eac_insn/sym_for_each_insn/

> on symbol information.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M
