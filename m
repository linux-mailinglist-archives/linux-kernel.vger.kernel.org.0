Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36FCF1796F7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 18:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730005AbgCDRr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 12:47:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33208 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729904AbgCDRr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 12:47:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583344076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qFsgHwaWXmIBlPzKK/shVPEiYQi0kQM9th6g/XxIkjg=;
        b=VIFzhcIuGqdaSkzWalEA7OWm10VLvdueXUGKkynPSrEKs7n9bh3UFoaTiaUDhpOdBRKd79
        KbHjHXKsrelSznnj1yN/+XXzvwv2tjDul9YxNpB2SdZis0aSq+vq1fBIKfnPOh3cMwlvdi
        gTr8DbuDZ5qhh05vbfsm+avypNaXQDI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-98uK-k8WNZ2HS1UAWR7nsw-1; Wed, 04 Mar 2020 12:47:54 -0500
X-MC-Unique: 98uK-k8WNZ2HS1UAWR7nsw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 162A3107ACCD;
        Wed,  4 Mar 2020 17:47:53 +0000 (UTC)
Received: from treble (ovpn-121-218.rdu2.redhat.com [10.10.121.218])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DBE9F8B56A;
        Wed,  4 Mar 2020 17:47:51 +0000 (UTC)
Date:   Wed, 4 Mar 2020 11:47:49 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/unwind/orc: Do not skip the first frame unless
 explicitly asked for
Message-ID: <20200304174749.iwoyf5gp4lkb22t5@treble>
References: <20200304123259.32199-1-mbenes@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200304123259.32199-1-mbenes@suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 01:32:59PM +0100, Miroslav Benes wrote:
> ORC unwinder can currently skip the first frame even if a user does not
> ask for it. If both regs and first_frame parameters of unwind_start()
> are set to NULL, state->sp and first_frame are later initialized to the
> same value for an inactive task. Given there is "less than or equal to"
> comparison used at the end of __unwind_start() for skipping stack frames,
> the first frame is always skipped in this case.
> 
> Drop the equal part of the comparison and make it equivalent to the
> frame pointer unwinder.
> 
> Signed-off-by: Miroslav Benes <mbenes@suse.cz>

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

