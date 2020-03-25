Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 226FD1927E2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 13:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbgCYMKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 08:10:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:53460 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727253AbgCYMKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:10:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4BA19AC44;
        Wed, 25 Mar 2020 12:10:34 +0000 (UTC)
Date:   Wed, 25 Mar 2020 13:10:33 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     tglx@linutronix.de, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org,
        brgerst@gmail.com
Subject: Re: [PATCH v3 14/26] objtool: Optimize read_sections()
In-Reply-To: <20200324160924.739153726@infradead.org>
Message-ID: <alpine.LSU.2.21.2003251308540.21800@pobox.suse.cz>
References: <20200324153113.098167666@infradead.org> <20200324160924.739153726@infradead.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Mar 2020, Peter Zijlstra wrote:

> Perf showed that __hash_init() is a significant portion of
> read_sections(), so instead of doing a per section rela_hash, use an
> elf-wide rela_hash.
> 
> Statistics show us there are about 1.1 million relas, so size it
> accordingly.
> 
> This reduces the objtool on vmlinux.o runtime to a third, from 15 to 5
> seconds.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M
