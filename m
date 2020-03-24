Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF378191B85
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 21:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbgCXUzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 16:55:25 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:31146 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726984AbgCXUzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 16:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585083324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Uc7oHYG1tknGBqYKVVNUHTaZFCOcjvw1sadbGT0pzLg=;
        b=BuSufmjyufHhB2bLif+HB4pjuXtUEoCc4Bu7o3PirlMIKGrpzJwR5b76EYMGYuSyGQVGUp
        CnEx/n3+BSIqSXAK7QKBd9sFLTlAubt/O595xWRMZNGdh4/VnWmeJH1Q8EqAWzolA/2kdC
        4I8+BL/u0JBKICEaOGXkXODrfL+Adak=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-SljkCi8SPASP0oabhpdtcw-1; Tue, 24 Mar 2020 16:55:22 -0400
X-MC-Unique: SljkCi8SPASP0oabhpdtcw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DBBD7800D48;
        Tue, 24 Mar 2020 20:55:20 +0000 (UTC)
Received: from treble (unknown [10.10.119.253])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 938A360BE0;
        Tue, 24 Mar 2020 20:55:19 +0000 (UTC)
Date:   Tue, 24 Mar 2020 15:55:17 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: Re: [PATCH v3 05/26] x86/kexec: Make relocate_kernel_64.S objtool
 clean
Message-ID: <20200324205517.newb3k32i67pxyel@treble>
References: <20200324153113.098167666@infradead.org>
 <20200324160924.202621656@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200324160924.202621656@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 04:31:18PM +0100, Peter Zijlstra wrote:
> Having fixed the biggest objtool issue in this file; fix up the rest
> and remove the exception.
> 
> Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

