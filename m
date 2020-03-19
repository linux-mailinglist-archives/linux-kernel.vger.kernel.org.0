Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B80218BE12
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 18:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbgCSRdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 13:33:35 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:36995 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727180AbgCSRdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 13:33:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584639214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1ltXOqIPzRx7dR67ps6b3k3yRk8aYyZvqCRinMvNF4E=;
        b=gLdyCm/1c2NbmBLL1kp7fW/rvtP79LFDmXQkTJPY/LyHYtOYhgL+05usmaJAb345wpWZWv
        WqB13mqmfi5oZ6UidRaGEao/to9Z4i2VQfGpiNVd6Wnh1xdkHhEm1K2nyGK93Snga64P+v
        isvEdc1cqDrcbdJm1GTNCogM3v+0fu0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-UJfw37p7PLSHd3_tr4PPDA-1; Thu, 19 Mar 2020 13:33:32 -0400
X-MC-Unique: UJfw37p7PLSHd3_tr4PPDA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 046698010EC;
        Thu, 19 Mar 2020 17:33:31 +0000 (UTC)
Received: from treble (unknown [10.10.110.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C404460BF1;
        Thu, 19 Mar 2020 17:33:29 +0000 (UTC)
Date:   Thu, 19 Mar 2020 12:33:26 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: linux-next: Tree for Mar 18 (objtool)
Message-ID: <20200319173326.oj4qs24x4ly5lrgt@treble>
References: <20200318220920.48df2e76@canb.auug.org.au>
 <d7dc5b4a-9a7e-ccf7-e00e-2e7f0e79a9bc@infradead.org>
 <20200318182352.2dgwwl4ugbwndi4x@treble>
 <20200318200542.GK20730@hirez.programming.kicks-ass.net>
 <20200319173101.wufpymi7obhqgoqd@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200319173101.wufpymi7obhqgoqd@treble>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 12:31:05PM -0500, Josh Poimboeuf wrote:
> ... except the __builtin_trap() UD2 seems to be coming *after* the BUG
> UD2.  Could it be the BUG UD2 itself which is convincing UBSAN to add
> the __builtin_trap()?

Actually I suspect it's the __builtin_unreachable() annotation which is
making UBSAN add the __builtin_trap()...  because I don't see any double
UD2s for WARNs.

-- 
Josh

