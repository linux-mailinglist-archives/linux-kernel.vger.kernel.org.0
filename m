Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA3CC19AD2E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 15:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732801AbgDANyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 09:54:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:48728 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732234AbgDANyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 09:54:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B6F8AABC6;
        Wed,  1 Apr 2020 13:54:03 +0000 (UTC)
Date:   Wed, 1 Apr 2020 15:54:03 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Julien Thierry <jthierry@redhat.com>
cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, raphael.gault@arm.com
Subject: Re: [PATCH v2 07/10] objtool: check: Allow save/restore hint in non
 standard function symbols
In-Reply-To: <20200327152847.15294-8-jthierry@redhat.com>
Message-ID: <alpine.LSU.2.21.2004011552290.15809@pobox.suse.cz>
References: <20200327152847.15294-1-jthierry@redhat.com> <20200327152847.15294-8-jthierry@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Mar 2020, Julien Thierry wrote:

> The kernel code base provides CODE_SYM_START/END to declare assembly
> code sequences that don't follow function standard calling conventions.
> 
> As non-C/non-standard code, these sequences can very much benefit from
> unwind hints. However, when a restore unwind_hint is used in a
> non-function code sequence, objtool will crash when looking for the
> corresponding save hint.
> 
> Record the code symbol an instruction belongs to and look for save hints
> belonging to the same code symbol as the restore hint.
> 
> Signed-off-by: Julien Thierry <jthierry@redhat.com>

Looks ok, but save/restore hints are about to go away. See 
https://lore.kernel.org/lkml/20200331222703.GH2452@worktop.programming.kicks-ass.net/

Miroslav
