Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 742D18BAB3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 15:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbfHMNrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 09:47:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:59636 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729229AbfHMNrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 09:47:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 62248AD95;
        Tue, 13 Aug 2019 13:47:04 +0000 (UTC)
Date:   Tue, 13 Aug 2019 15:46:59 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Petr Mladek <pmladek@suse.com>
cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Nicolai Stange <nstange@suse.de>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] livepatch: new API to track system state
 changes
In-Reply-To: <20190719074034.29761-1-pmladek@suse.com>
Message-ID: <alpine.LSU.2.21.1908131543280.10477@pobox.suse.cz>
References: <20190719074034.29761-1-pmladek@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jul 2019, Petr Mladek wrote:

> Hi,
> 
> this is another piece in the puzzle that helps to maintain more
> livepatches.
> 
> Especially pre/post (un)patch callbacks might change a system state.
> Any newly installed livepatch has to somehow deal with system state
> modifications done be already installed livepatches.
> 
> This patchset provides a simple and generic API that
> helps to keep and pass information between the livepatches.
> It is also usable to prevent loading incompatible livepatches.
> 
> 
> Changes since v1:
> 
>   + Use "unsigned long" instead of "int" for "state.id" [Nicolai]
>   + Use "unsigned int" instead of "int" for "state.version [Petr]
>   + Include "state.h" to avoid warning about non-static func [Miroslav]
>   + Simplify logic in klp_is_state_compatible() [Miroslav]
>   + Document how livepatches should handle the state [Nicolai]
>   + Fix some typos, formulation, module metadata [Joe, Miroslav]

I noticed couple of typos along the way but apart from that

Acked-by: Miroslav Benes <mbenes@suse.cz>

Miroslav
